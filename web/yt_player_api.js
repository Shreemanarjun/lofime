/**
 * Optimized YouTube Player API Wrapper for Production
 *
 * Improvements:
 * 1. Namespaced under window.LofimePlayer to avoid global pollution.
 * 2. More robust script loading with Promise.
 * 3. Efficient event handling and cleanup.
 * 4. Error reporting.
 */

(function() {
    let player = null;
    let playerOptions = null;
    let isPlayerReady = false;
    let progressInterval = null;
    let apiLoadingPromise = null;

    /**
     * Loads the YouTube IFrame API script
     * @returns {Promise}
     */
    function loadYouTubeApi() {
        if (apiLoadingPromise) return apiLoadingPromise;

        apiLoadingPromise = new Promise((resolve, reject) => {
            if (window.YT && window.YT.Player) {
                resolve();
                return;
            }

            // The API calls this function when ready
            const previousOnReady = window.onYouTubeIframeAPIReady;
            window.onYouTubeIframeAPIReady = () => {
                if (previousOnReady) previousOnReady();
                console.log('YouTube API Loaded');
                resolve();
            };

            const tag = document.createElement('script');
            tag.src = 'https://www.youtube.com/iframe_api';
            tag.async = true;
            tag.onerror = () => reject(new Error('Failed to load YouTube API'));

            const firstScriptTag = document.getElementsByTagName('script')[0];
            firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
        });

        return apiLoadingPromise;
    }

    function startProgressTracking() {
        if (progressInterval) clearInterval(progressInterval);

        progressInterval = setInterval(() => {
            if (player && isPlayerReady && playerOptions && playerOptions.onProgress) {
                try {
                    const currentTime = player.getCurrentTime();
                    const duration = player.getDuration();

                    // Only send progress if the player is actually playing
                    if (player.getPlayerState() === 1) { // 1 = PLAYING
                        playerOptions.onProgress({
                            currentTime: currentTime || 0,
                            duration: duration || 0
                        });
                    }
                } catch (e) {
                    // Silently fail progress if player is not ready
                }
            }
        }, 500); // 500ms is usually enough for Lofi apps and saves CPU/Overhead
    }

    function stopProgressTracking() {
        if (progressInterval) {
            clearInterval(progressInterval);
            progressInterval = null;
        }
    }

    // Export to a namespace
    window.LofimePlayer = {
        init: function(options) {
            playerOptions = options;
            return loadYouTubeApi();
        },

        create: async function(videoId) {
            await loadYouTubeApi();

            if (player) {
                this.destroy();
            }

            return new Promise((resolve, reject) => {
                // Container check
                let container = document.getElementById('youtube-player');
                if (!container) {
                    container = document.createElement('div');
                    container.id = 'youtube-player';
                    // Invisible but present to avoid throttling
                    Object.assign(container.style, {
                        position: 'fixed',
                        bottom: '0',
                        right: '0',
                        width: '1px',
                        height: '1px',
                        opacity: '0.01',
                        pointerEvents: 'none',
                        zIndex: '-1'
                    });
                    document.body.appendChild(container);
                }

                player = new YT.Player('youtube-player', {
                    height: '1',
                    width: '1',
                    videoId: videoId,
                    playerVars: {
                        autoplay: 0,
                        controls: 0,
                        disablekb: 1,
                        enablejsapi: 1,
                        iv_load_policy: 3,
                        modestbranding: 1,
                        playsinline: 1,
                        rel: 0,
                        origin: window.location.origin
                    },
                    events: {
                        onReady: () => {
                            isPlayerReady = true;
                            const data = player.getVideoData();

                            if (playerOptions && playerOptions.onTrackInfo) {
                                playerOptions.onTrackInfo({
                                    videoId: videoId,
                                    title: data.title || 'Unknown',
                                    author: data.author || 'Unknown',
                                    duration: player.getDuration() || 0
                                });
                            }

                            if (playerOptions && playerOptions.onReady) {
                                playerOptions.onReady();
                            }

                            resolve();
                        },
                        onStateChange: (event) => {
                            if (playerOptions && playerOptions.onStateChange) {
                                playerOptions.onStateChange(event.data);
                            }

                            if (event.data === 1) startProgressTracking();
                            else stopProgressTracking();
                        },
                        onError: (err) => {
                            console.error('YT Player Error:', err.data);
                            reject(err.data);
                        }
                    }
                });
            });
        },

        play: function() {
            if (player && isPlayerReady) player.playVideo();
        },

        pause: function() {
            if (player && isPlayerReady) player.pauseVideo();
        },

        seek: function(time) {
            if (player && isPlayerReady) player.seekTo(time, true);
        },

        setVolume: function(volume) {
            if (player && isPlayerReady) {
                player.setVolume(Math.round(volume * 100));
            }
        },

        load: function(videoId) {
            if (player && isPlayerReady) player.loadVideoById(videoId);
        },

        destroy: function() {
            stopProgressTracking();
            if (player && typeof player.destroy === 'function') {
                try {
                    player.destroy();
                } catch (e) {
                    console.error('Error destroying player:', e);
                }
            }
            player = null;
            isPlayerReady = false;

            const container = document.getElementById('youtube-player');
            if (container) container.remove();

            return Promise.resolve();
        }
    };
})();