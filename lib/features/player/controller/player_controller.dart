import 'dart:js_interop';
import 'dart:async';

import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:lofime/core/models/player_models.dart';
import 'package:lofime/core/services/youtube_music_service.dart';
import 'package:lofime/features/player/controller/player_interop.dart';

import 'package:talker/talker.dart';
import 'package:universal_web/web.dart' as web;
import 'dart:convert';

/// Controller to manage the YouTube player
class YouTubePlayerController extends Notifier<YouTubePlayerState> {
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

    final initialPlaylist = ref.watch(intialPlayListProvider);

    // Initialize player after build
    Future.microtask(() => _initializeAndCreatePlayer());

    // Load favorites from local storage
    Future.microtask(() => _loadFavorites());

    return YouTubePlayerState(playlist: initialPlaylist);
  }

  static const String _favoritesKey = 'lofime_favorites';

  void _loadFavorites() {
    try {
      final saved = web.window.localStorage.getItem(_favoritesKey);
      if (saved != null) {
        final List<dynamic> json = jsonDecode(saved);
        final favs = json.map((e) => YouTubeTrackMapper.fromMap(e as Map<String, dynamic>)).toList();
        state = state.copyWith(favorites: favs);
        _talker.info('Loaded ${favs.length} favorites from local storage');
      }
    } catch (e) {
      _talker.error('Failed to load favorites', e);
    }
  }

  void _saveFavorites() {
    try {
      final json = state.favorites.map((e) => e.toMap()).toList();
      web.window.localStorage.setItem(_favoritesKey, jsonEncode(json));
    } catch (e) {
      _talker.error('Failed to save favorites', e);
    }
  }

  void toggleFavorite(YouTubeTrack track) {
    final isFav = state.isFavorite(track.youtubeId);
    if (isFav) {
      state = state.copyWith(
        favorites: state.favorites.where((t) => t.youtubeId != track.youtubeId).toList(),
      );
    } else {
      state = state.copyWith(
        favorites: [...state.favorites, track],
      );
    }
    _saveFavorites();
  }

  void playFavorite(int index) {
    if (index < 0 || index >= state.favorites.length) return;

    // Switch main playlist to favorites if we play from there?
    // Or just play it. Let's make the favorites a playable list.
    state = state.copyWith(
      playlist: state.favorites,
      currentTrackIndex: index,
    );
    _loadTrack(index);
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
      _playerReadyFuture!
          .then((_) {
            _talker.info('Dart: Initial player is ready. Setting volume.');
            setVideoVolume(state.volume);
            // Don't auto-play on initialization - wait for user interaction
          })
          .catchError((e, st) {
            _talker.error('Dart: Failed to create initial player', e, st);
            _playerReadyFuture = null; // Invalidate the future on error.
          });
    }
  }

  // --- Callbacks from JavaScript ---

  void _onPlayerReady() {
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
    _hasUserInteraction = true;

    if (_playerReadyFuture == null) {
      _talker.warning('Play called but player is not initialized.');
      return;
    }

    try {
      await _playerReadyFuture!;
      _talker.info('Player is ready, calling playVideo()');
      playVideo();
      state = state.copyWith(isPlaying: true);
    } catch (e, st) {
      _talker.error('Failed to play video', e, st);
    }
  }

  Future<void> pause() async {
    _talker.info('pause() called.');
    if (_playerReadyFuture == null) return;

    try {
      await _playerReadyFuture!;
      pauseVideo();
      state = state.copyWith(isPlaying: false);
    } catch (e, st) {
      _talker.error('Failed to pause video', e, st);
    }
  }

  Future<void> stop() async {
    _talker.info('stop() called.');
    if (_playerReadyFuture == null) return;

    try {
      await _playerReadyFuture!;
      // Note: stopVideo is not in interop, usually pause + seek(0)
      pauseVideo();
      seekVideo(0);
      state = state.copyWith(isPlaying: false, currentTime: 0);
    } catch (e, st) {
      _talker.error('Failed to stop video', e, st);
    }
  }

  Future<void> next() async {
    _talker.info('next() called.');
    int nextIndex = state.currentTrackIndex + 1;
    if (nextIndex >= state.playlist.length) {
      nextIndex = 0;
    }
    await _loadTrack(nextIndex);
  }

  Future<void> previous() async {
    _talker.info('previous() called.');
    int prevIndex = state.currentTrackIndex - 1;
    if (prevIndex < 0) {
      prevIndex = state.playlist.length - 1;
    }
    await _loadTrack(prevIndex);
  }

  Future<void> setVolume(double volume) async {
    _talker.info('setVolume($volume) called.');
    state = state.copyWith(volume: volume);
    if (_playerReadyFuture == null) return;

    try {
      await _playerReadyFuture!;
      setVideoVolume(volume);
    } catch (e, st) {
      _talker.error('Failed to set volume', e, st);
    }
  }

  Future<void> seek(double time) async {
    _talker.info('seek($time) called.');
    if (_playerReadyFuture == null) return;

    try {
      await _playerReadyFuture!;
      seekVideo(time);
      state = state.copyWith(currentTime: time);
    } catch (e, st) {
      _talker.error('Failed to seek', e, st);
    }
  }

  void toggleAutoPlay() {
    _talker.info('toggleAutoPlay() called.');
    state = state.copyWith(autoPlay: !state.autoPlay);
  }

  Future<void> search(String query) async {
    if (query.isEmpty) return;
    _talker.info('search($query) called.');
    state = state.copyWith(isLoading: true, searchQuery: query);

    final results = await ref.read(youtubeMusicServiceProvider).searchLofi(query);

    if (results.isNotEmpty) {
      state = state.copyWith(
        playlist: results,
        currentTrackIndex: 0,
        isLoading: false,
      );
      await _loadTrack(0);
    } else {
      state = state.copyWith(isLoading: false);
      _talker.warning('No search results found for: $query');
    }
  }

  Future<void> autoDiscover() async {
    _talker.info('autoDiscover() called.');
    state = state.copyWith(isLoading: true);

    final results = await ref.read(youtubeMusicServiceProvider).discoverLofi();

    if (results.isNotEmpty) {
      state = state.copyWith(
        playlist: results,
        currentTrackIndex: 0,
        isLoading: false,
      );
      await _loadTrack(0);
    } else {
      state = state.copyWith(isLoading: false);
      _talker.warning('Discovery failed to return tracks.');
    }
  }

  Future<void> _loadTrack(int index) async {
    _talker.info('_loadTrack($index) called.');
    if (index < 0 || index >= state.playlist.length) return;

    final track = state.playlist[index];
    state = state.copyWith(currentTrackIndex: index, currentTime: 0, duration: 0);

    if (_playerReadyFuture == null) {
      _talker.warning('Player not ready during _loadTrack. Attempting re-init.');
      _initializeAndCreatePlayer();
      return;
    }

    try {
      await _playerReadyFuture!;
      _talker.info('Loading video ${track.youtubeId}');
      loadVideo(track.youtubeId);
      // Volume is preserved by the YT player usually, but we can set it again
      setVideoVolume(state.volume);
      if (state.isPlaying) {
        playVideo();
      }
    } catch (e, st) {
      _talker.error('Failed to load track', e, st);
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
