// Global variables
let player;
let playerOptions;
let isPlayerReady = false;
let pendingVideoId = null;

// Initialize the YouTube Player
window.initYouTubePlayer = function(options) {
    console.log('Initializing YouTube Player with options:', options);
    playerOptions = options;

    // Load YouTube IFrame API if not already loaded
    if (!window.YT) {
        const tag = document.createElement('script');
        tag.src = 'https://www.youtube.com/iframe_api';
        const firstScriptTag = document.getElementsByTagName('script')[0];
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

        // Set up the callback for when the API is ready
        window.onYouTubeIframeAPIReady = function() {
            console.log('YouTube IFrame API Ready');
        };
    }
};

// Create a new player instance
window.createPlayer = function(videoId) {
    console.log('Creating player for video:', videoId);

    return new Promise((resolve, reject) => {
        try {
            // Store the video ID in case we need it before the player is ready
            pendingVideoId = videoId;

            // Destroy existing player if it exists
            if (player) {
                try {
                    player.destroy();
                } catch (e) {
                    console.warn('Error destroying existing player:', e);
                }
                player = null;
                isPlayerReady = false;
            }

            // Ensure we have a container element
            let playerContainer = document.getElementById('youtube-player');
            if (!playerContainer) {
                playerContainer = document.createElement('div');
                playerContainer.id = 'youtube-player';
                playerContainer.style.position = 'absolute';
                playerContainer.style.top = '-9999px';
                playerContainer.style.left = '-9999px';
                playerContainer.style.width = '1px';
                playerContainer.style.height = '1px';
                document.body.appendChild(playerContainer);
            }

            // Wait for YouTube API to be available
            const initPlayer = () => {
                if (!window.YT || !window.YT.Player) {
                    console.log('YouTube API not ready, retrying...');
                    setTimeout(initPlayer, 100);
                    return;
                }

                console.log('Creating new YouTube player');
                player = new YT.Player('youtube-player', {
                    height: '1',
                    width: '1',
                    videoId: videoId,
                    playerVars: {
                        autoplay: 0, // Don't autoplay - wait for user interaction
                        controls: 0,
                        disablekb: 1,
                        enablejsapi: 1,
                        fs: 0,
                        iv_load_policy: 3,
                        modestbranding: 1,
                        playsinline: 1,
                        rel: 0,
                        showinfo: 0,
                        origin: window.location.origin
                    },
                    events: {
                        onReady: (event) => {
                            console.log('Player ready for video:', videoId);
                            isPlayerReady = true;

                            // Get video info
                            try {
                                const duration = player.getDuration();
                                const title = player.getVideoData().title;
                                const author = player.getVideoData().author;

                                if (playerOptions.onTrackInfo) {
                                    playerOptions.onTrackInfo({
                                        videoId: videoId,
                                        title: title || 'Unknown Title',
                                        author: author || 'Unknown Artist',
                                        duration: duration || 0
                                    });
                                }
                            } catch (e) {
                                console.warn('Error getting video info:', e);
                            }

                            // Call the ready callback
                            if (playerOptions.onReady) {
                                playerOptions.onReady();
                            }

                            // Start progress tracking
                            startProgressTracking();

                            resolve();
                        },
                        onStateChange: (event) => {
                            console.log('Player state changed:', event.data);
                            if (playerOptions.onStateChange) {
                                playerOptions.onStateChange(event.data);
                            }

                            // Handle different states
                            if (event.data === YT.PlayerState.PLAYING) {
                                startProgressTracking();
                            } else if (event.data === YT.PlayerState.PAUSED ||
                                     event.data === YT.PlayerState.ENDED) {
                                stopProgressTracking();
                            }
                        },
                        onError: (event) => {
                            console.error('YouTube player error:', event.data);
                            reject(new Error(`YouTube player error: ${event.data}`));
                        }
                    }
                });
            };

            initPlayer();

        } catch (error) {
            console.error('Error creating player:', error);
            reject(error);
        }
    });
};

// Progress tracking
let progressInterval;

function startProgressTracking() {
    stopProgressTracking(); // Clear any existing interval

    progressInterval = setInterval(() => {
        if (player && isPlayerReady && playerOptions.onProgress) {
            try {
                const currentTime = player.getCurrentTime();
                const duration = player.getDuration();

                playerOptions.onProgress({
                    currentTime: currentTime || 0,
                    duration: duration || 0
                });
            } catch (e) {
                console.warn('Error getting progress:', e);
            }
        }
    }, 250); // Update every 250ms
}

function stopProgressTracking() {
    if (progressInterval) {
        clearInterval(progressInterval);
        progressInterval = null;
    }
}

// Control functions
window.playYouTubeVideo = function() {
    console.log('Play video called');
    if (player && isPlayerReady) {
        try {
            player.playVideo();
            console.log('Video play command sent');
        } catch (e) {
            console.error('Error playing video:', e);
        }
    } else {
        console.warn('Player not ready for play command');
    }
};

window.pauseYouTubeVideo = function() {
    console.log('Pause video called');
    if (player && isPlayerReady) {
        try {
            player.pauseVideo();
            console.log('Video pause command sent');
        } catch (e) {
            console.error('Error pausing video:', e);
        }
    } else {
        console.warn('Player not ready for pause command');
    }
};

window.seekYouTubeVideo = function(time) {
    console.log('Seek video called with time:', time);
    if (player && isPlayerReady) {
        try {
            player.seekTo(time, true);
            console.log('Video seek command sent');
        } catch (e) {
            console.error('Error seeking video:', e);
        }
    } else {
        console.warn('Player not ready for seek command');
    }
};

window.setYouTubeVolume = function(volume) {
    console.log('Set volume called with:', volume);
    if (player && isPlayerReady) {
        try {
            // Convert 0.0-1.0 to 0-100 for YouTube API
            const youtubeVolume = Math.round(volume * 100);
            player.setVolume(youtubeVolume);
            console.log('Volume set to:', youtubeVolume);
        } catch (e) {
            console.error('Error setting volume:', e);
        }
    } else {
        console.warn('Player not ready for volume command');
    }
};

window.loadYouTubeVideo = function(videoId) {
    console.log('Load video called with:', videoId);
    if (player && isPlayerReady) {
        try {
            player.loadVideoById(videoId);
            console.log('Video load command sent');
        } catch (e) {
            console.error('Error loading video:', e);
        }
    } else {
        console.warn('Player not ready for load command');
    }
};

window.destroyYouTubePlayer = function() {
    console.log('Destroying YouTube player');

    return new Promise((resolve) => {
        stopProgressTracking();

        if (player) {
            try {
                player.destroy();
            } catch (e) {
                console.warn('Error destroying player:', e);
            }
            player = null;
        }

        isPlayerReady = false;
        pendingVideoId = null;

        // Remove the container element
        const container = document.getElementById('youtube-player');
        if (container) {
            container.remove();
        }

        console.log('Player destroyed');
        resolve();
    });
};