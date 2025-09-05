import 'dart:js_interop';
import 'dart:async';

import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:lofime/data/local_player_model.dart';
import 'package:lofime/feature/yt_player/controller/yt_player_interop.dart';

import 'package:talker/talker.dart';

/// StateNotifier to control the player
class YouTubePlayerController extends AutoDisposeNotifier<YouTubePlayerState> {
  // A logger for debugging.
  final _talker = Talker(
    settings: TalkerSettings(),
  );

  /// A future that completes when the YouTube player is initialized and ready.
  /// Public methods that interact with the player should `await` this future.
  Future<void>? _playerReadyFuture;

  /// Track if we've had user interaction
  bool _hasUserInteraction = false;

  @override
  YouTubePlayerState build() {
    ref.onDispose(() async {
      _talker.warning('YouTubePlayerController disposing...');
      // destroyVideoPlayer returns a promise, so we await it.
      await destroyVideoPlayer().toDart;
    });

    ref.onAddListener(() {
      _talker.info('YouTubePlayerController added. Initializing player...');
      _initializeAndCreatePlayer();
    });

    final initialPlaylist = ref.watch(intialPlayListProvider);
    // Player starts in a paused state, waiting for user interaction.

    return YouTubePlayerState(playlist: initialPlaylist);
  }

  void _initializeAndCreatePlayer() {
    final options = JsPlayerOptions(
      onReady: _onPlayerReady.toJS,
      onStateChange: _onPlayerStateChange.toJS,
      onTrackInfo: _onTrackInfo.toJS,
      onProgress: _onProgress.toJS,
    );
    initVideoPlayer(options);

    // Create the player with the first video.
    final videoId = state.currentTrack?.youtubeId;
    if (videoId != null) {
      _talker.info('Dart: Calling createPlayer for initial track $videoId');
      // createPlayer returns a Future that completes when the player is ready.
      // We store this future to be awaited by other methods.
      _playerReadyFuture = createPlayer(videoId).toDart;
      _playerReadyFuture!.then((_) {
        _talker.info('Dart: Initial player is ready. Setting volume.');
        setVideoVolume(state.volume);
        // Don't auto-play on initialization - wait for user interaction
      }).catchError((e, st) {
        _talker.error('Dart: Failed to create initial player', e, st);
        _playerReadyFuture = null; // Invalidate the future on error.
      });
    }
  }

  // --- Callbacks from JavaScript ---

  void _onPlayerReady() {
    // This callback is now mostly for logging, as the `createPlayer` promise
    // is the primary signal for readiness.
    _talker.info('Dart: JS onReady event fired.');
  }

  void _onPlayerStateChange(int playerState) {
    _talker.info('Dart: Received player state change: $playerState');
    switch (playerState) {
      case -1: // UNSTARTED
        _talker.info('Player unstarted');
        break;
      case 0: // ENDED
        _talker.info('Player ended');
        if (state.autoPlay && _hasUserInteraction) {
          next();
        } else {
          state = state.copyWith(isPlaying: false);
        }
        break;
      case 1: // PLAYING
        _talker.info('Player playing');
        if (!state.isPlaying) state = state.copyWith(isPlaying: true);
        break;
      case 2: // PAUSED
        _talker.info('Player paused');
        if (state.isPlaying) state = state.copyWith(isPlaying: false);
        break;
      case 3: // BUFFERING
        _talker.info('Player buffering');
        break;
      case 5: // CUED
        _talker.info('Player cued');
        break;
      default:
        _talker.warning('Dart: Unknown player state: $playerState');
    }
  }

  void _onTrackInfo(JsTrackInfo trackInfo) {
    _talker.info('Dart: Received track info: ${trackInfo.title}');
    final trackIndex = state.playlist.indexWhere((t) => t.youtubeId == trackInfo.videoId);
    if (trackIndex != -1) {
      final newPlaylist = List<YouTubeTrack>.from(state.playlist);
      newPlaylist[trackIndex] = newPlaylist[trackIndex].copyWith(
        title: trackInfo.title,
        artist: trackInfo.author,
        duration: trackInfo.duration,
      );
      state = state.copyWith(playlist: newPlaylist, duration: trackInfo.duration);
    }
  }

  void _onProgress(JsProgressInfo progressInfo) {
    if (state.isPlaying) {
      state = state.copyWith(
        currentTime: progressInfo.currentTime,
        duration: progressInfo.duration,
      );
    }
  }

  // --- Public methods called from the UI ---

  Future<void> play() async {
    _talker.info('play() called.');

    // Mark that we have user interaction
    _hasUserInteraction = true;

    // Wait for player to be ready
    if (_playerReadyFuture == null) {
      _talker.warning('Play called but player is not initialized.');
      return;
    }

    try {
      await _playerReadyFuture!;
      _talker.info('Player is ready, calling playVideo()');
      playVideo();

      // Update state immediately to show playing status
      state = state.copyWith(isPlaying: true);
    } catch (e, st) {
      _talker.error('Failed to play video', e, st);
      state = state.copyWith(isPlaying: false);
    }
  }

  Future<void> pause() async {
    _talker.info('pause() called.');

    if (_playerReadyFuture == null) {
      _talker.warning('Pause called but player is not ready or failed to init.');
      return;
    }

    try {
      await _playerReadyFuture!;
      pauseVideo();
      state = state.copyWith(isPlaying: false);
    } catch (e, st) {
      _talker.error('Failed to pause video', e, st);
    }
  }

  Future<void> next() async {
    _talker.info('next() called.');
    _hasUserInteraction = true; // Mark user interaction

    if (state.playlist.isNotEmpty) {
      final nextIndex = (state.currentTrackIndex + 1) % state.playlist.length;
      await selectTrack(nextIndex);
    }
  }

  Future<void> previous() async {
    _talker.info('previous() called.');
    _hasUserInteraction = true; // Mark user interaction

    if (state.playlist.isNotEmpty) {
      final prevIndex = state.currentTrackIndex == 0 ? state.playlist.length - 1 : state.currentTrackIndex - 1;
      await selectTrack(prevIndex);
    }
  }

  Future<void> setVolume(double volume) async {
    _talker.info('setVolume() called with: $volume');
    final clampedVolume = volume.clamp(0.0, 1.0);
    state = state.copyWith(volume: clampedVolume);

    // Await readiness before sending command to JS
    if (_playerReadyFuture != null) {
      try {
        await _playerReadyFuture!;
        setVideoVolume(clampedVolume);
      } catch (e, st) {
        _talker.error('Failed to set volume', e, st);
      }
    }
  }

  Future<void> selectTrack(int index) async {
    _talker.info('selectTrack() called with index: $index');
    if (index >= 0 && index < state.playlist.length) {
      final wasPlaying = state.isPlaying && _hasUserInteraction;

      // Immediately update the UI to show the new track selection and pause state.
      state = state.copyWith(
        currentTrackIndex: index,
        currentTime: 0,
        duration: 0,
        isPlaying: false,
      );

      final videoId = state.playlist[index].youtubeId;

      // The JS `createPlayer` handles destroying the old player and creating a new one.
      // We get a new future that represents the readiness of this new player instance.
      _talker.info('Dart: Calling createPlayer for new track $videoId');

      try {
        final newPlayerFuture = createPlayer(videoId).toDart;
        _playerReadyFuture = newPlayerFuture;

        await newPlayerFuture;
        _talker.info('Dart: Player for new track $videoId is ready.');

        // New player is ready, re-apply settings and resume playback if needed.
        setVideoVolume(state.volume);

        // Only auto-play if we had user interaction and were previously playing
        if (wasPlaying) {
          // Small delay to ensure player is fully ready
          await Future.delayed(const Duration(milliseconds: 100));
          await play();
        }
      } catch (e, st) {
        _talker.error('Dart: Failed to create player for track $videoId', e, st);
        _playerReadyFuture = null; // Invalidate the future on error.
        state = state.copyWith(isPlaying: false);
      }
    }
  }

  void toggleAutoPlay() {
    _talker.info('toggleAutoPlay() called. New value: ${!state.autoPlay}');
    state = state.copyWith(autoPlay: !state.autoPlay);
  }

  Future<void> seek(double time) async {
    _talker.info('seek() called with time: $time');
    _hasUserInteraction = true; // Mark user interaction

    if (_playerReadyFuture == null || state.duration <= 0) {
      _talker.warning('Cannot seek - player not ready or no duration');
      return;
    }

    try {
      await _playerReadyFuture!;
      seekVideo(time);
      state = state.copyWith(currentTime: time);
    } catch (e, st) {
      _talker.error('Failed to seek video', e, st);
    }
  }
}

/// Global provider for player
final youTubePlayerProvider = NotifierProvider.autoDispose<YouTubePlayerController, YouTubePlayerState>(
  YouTubePlayerController.new,
);

final intialPlayListProvider = Provider.autoDispose<List<YouTubeTrack>>((ref) {
  return [
    const YouTubeTrack(
      title: "Lofi Bollywood Mix 2024 | Chill Hindi Songs",
      artist: "LoFi Bollywood",
      url: "",
      youtubeId: "uSX6Q7ZzIqY",
    ),
    const YouTubeTrack(
      title: "Best of Bollywood LoFi | Relaxing Hindi Music",
      artist: "Chill Bollywood",
      url: "",
      youtubeId: "36YnV9STBqc",
    ),
    const YouTubeTrack(
      title: "Arijit Singh LoFi Mix | Romantic Hindi Songs",
      artist: "LoFi Romance",
      url: "",
      youtubeId: "kJQP7kiw5Fk",
    ),
    const YouTubeTrack(
      title: "90s Bollywood LoFi | Nostalgic Hindi Hits",
      artist: "Retro LoFi",
      url: "",
      youtubeId: "4NRXx6U8ABQ",
    ),
    const YouTubeTrack(
      title: "Rahat Fateh Ali Khan LoFi | Sufi Chill Mix",
      artist: "Sufi LoFi",
      url: "",
      youtubeId: "kTJczUoc26U",
    ),
    const YouTubeTrack(
      title: "Bollywood Study Music | Focus LoFi Beats",
      artist: "Study Beats India",
      url: "",
      youtubeId: "5qap5aO4i9A",
    ),
    const YouTubeTrack(
      title: "Kishore Kumar LoFi | Classic Hindi Songs",
      artist: "Classic LoFi",
      url: "",
      youtubeId: "kJQP7kiw5Fk",
    ),
    const YouTubeTrack(
      title: "Lata Mangeshkar LoFi | Golden Era Hindi Music",
      artist: "Golden LoFi",
      url: "",
      youtubeId: "36YnV9STBqc",
    ),
  ];
});
