import 'dart:convert';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:lofime/data/local_player_model.dart';

class MusicPlayerState {
  final List<Track> playlist;
  final int currentTrackIndex;
  final bool isPlaying;
  final double volume;
  final double currentTime;
  final double duration;
  final bool isLoading;

  Track? get currentTrack => playlist.isNotEmpty ? playlist[currentTrackIndex] : null;

  const MusicPlayerState({
    this.playlist = const [],
    this.currentTrackIndex = 0,
    this.isPlaying = false,
    this.volume = 0.7,
    this.currentTime = 0,
    this.duration = 0,
    this.isLoading = false,
  });

  MusicPlayerState copyWith({
    List<Track>? playlist,
    int? currentTrackIndex,
    bool? isPlaying,
    double? volume,
    double? currentTime,
    double? duration,
    bool? isLoading,
  }) {
    return MusicPlayerState(
      playlist: playlist ?? this.playlist,
      currentTrackIndex: currentTrackIndex ?? this.currentTrackIndex,
      isPlaying: isPlaying ?? this.isPlaying,
      volume: volume ?? this.volume,
      currentTime: currentTime ?? this.currentTime,
      duration: duration ?? this.duration,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class MusicPlayerNotifier extends Notifier<MusicPlayerState> {
  HTMLAudioElement? _audio;

  @override
  MusicPlayerState build() {
    _initAudio();
    return const MusicPlayerState();
  }

  void _initAudio() {
    if (_audio != null) return;

    _audio = HTMLAudioElement();
    _audio!.onLoad.listen((_) {
      state = state.copyWith(isLoading: true);
    });
    _audio!.onLoadedData.listen((_) {
      state = state.copyWith(isLoading: false);
    });
    _audio!.onLoadedMetadata.listen((_) {
      state = state.copyWith(duration: _audio!.duration.toDouble());
    });
    _audio!.onTimeUpdate.listen((_) {
      state = state.copyWith(currentTime: _audio!.currentTime.toDouble());
    });
    _audio!.onEnded.listen((_) {
      next();
    });
    _audio!.onError.listen((_) {
      state = state.copyWith(isPlaying: false, isLoading: false);
      print("Audio error: ${_audio?.error}");
    });
  }

  // Actions
  Future<void> play() async {
    final track = state.currentTrack;
    if (track == null) return;
    if (_audio == null) _initAudio();
    _audio!.src = track.url;
    _audio!.volume = state.volume;
    try {
      _audio!.play();
      state = state.copyWith(isPlaying: true);
    } catch (e) {
      print("Error playing: $e");
      state = state.copyWith(isPlaying: false);
    }
  }

  void pause() {
    _audio?.pause();
    state = state.copyWith(isPlaying: false);
  }

  void next() {
    if (state.playlist.isEmpty) return;
    final nextIndex = (state.currentTrackIndex + 1) % state.playlist.length;
    state = state.copyWith(currentTrackIndex: nextIndex, isPlaying: false);
    play();
  }

  void previous() {
    if (state.playlist.isEmpty) return;
    final prevIndex = state.currentTrackIndex == 0 ? state.playlist.length - 1 : state.currentTrackIndex - 1;
    state = state.copyWith(currentTrackIndex: prevIndex, isPlaying: false);
    play();
  }

  void seek(double time) {
    if (_audio != null) {
      _audio!.currentTime = time;
      state = state.copyWith(currentTime: time);
    }
  }

  void setVolume(double volume) {
    _audio?.volume = volume;
    state = state.copyWith(volume: volume);
  }

  void selectTrack(int index) {
    if (index < 0 || index >= state.playlist.length) return;
    state = state.copyWith(currentTrackIndex: index, isPlaying: false);
    play();
  }

  void addTrack(Track track) {
    final newPlaylist = [...state.playlist, track];
    state = state.copyWith(playlist: newPlaylist);
  }

  void removeTrack(int index) {
    if (index < 0 || index >= state.playlist.length) return;
    final newPlaylist = List<Track>.from(state.playlist)..removeAt(index);
    var newIndex = state.currentTrackIndex;
    if (index == state.currentTrackIndex && newPlaylist.isNotEmpty) {
      newIndex = 0;
    } else if (index < state.currentTrackIndex) {
      newIndex = state.currentTrackIndex - 1;
    }
    state = state.copyWith(playlist: newPlaylist, currentTrackIndex: newIndex);
  }

  void savePlaylist() {
    final playlistData = LocalPlaylist(
      name: "LoFi Bollywood Playlist",
      tracks: state.playlist,
      createdAt: DateTime.now(),
    );

    final blob = Blob(
        JSArray.from([
          jsonEncode({
            "name": playlistData.name,
            "createdAt": playlistData.createdAt.toIso8601String(),
            "tracks": playlistData.tracks
                .map((t) => {
                      "title": t.title,
                      "artist": t.artist,
                      "url": t.url,
                      "duration": t.duration,
                    })
                .toList(),
          })
        ].toJSBox),
        BlobPropertyBag(type: "application/json"));

    final a = HTMLAnchorElement()
      ..setAttribute("href", URL.createObjectURL(blob))
      ..download = "lofi-bollywood-playlist-${DateTime.now().millisecondsSinceEpoch}.json"
      ..style.display = "none";
    document.body!.append(a);
    a.click();
    a.remove();
  }

  void loadPlaylist(File file) {
    final reader = FileReader();
    reader.readAsText(file);
    reader.onload = ((_) {
      try {
        final data = jsonDecode(reader.result.toString());
        if (data["tracks"] is List) {
          final tracks = (data["tracks"] as List)
              .map((t) => YouTubeTrack(
                    title: t["title"],
                    artist: t["artist"],
                    url: t["url"],
                    duration: (t["duration"] as num?)?.toDouble(),
                    youtubeId: t["youtubeId"],
                  ))
              .toList();
          state = state.copyWith(playlist: tracks, currentTrackIndex: 0, isPlaying: false);
        }
      } catch (e) {
        print("Error loading playlist: $e");
        window.alert("Invalid playlist file format");
      }
    }).jsify() as JSFunction;
  }
}

// Global provider
final musicPlayerProvider = NotifierProvider<MusicPlayerNotifier, MusicPlayerState>(MusicPlayerNotifier.new);
