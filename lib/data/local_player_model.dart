// Track sealed class
import 'package:dart_mappable/dart_mappable.dart';
part 'local_player_model.mapper.dart';

@MappableClass()
sealed class Track with TrackMappable {
  final String title;
  final String artist;
  final String url;
  final double? duration;

  const Track({
    required this.title,
    required this.artist,
    required this.url,
    this.duration,
  });
}

@MappableClass()
final class LocalTrack extends Track with LocalTrackMappable {
  const LocalTrack({
    required super.title,
    required super.artist,
    required super.url,
    super.duration,
  });
}

@MappableClass()
final class YouTubeTrack extends Track with YouTubeTrackMappable {
  final String youtubeId;

  const YouTubeTrack({
    required super.title,
    required super.artist,
    required super.url,
    super.duration,
    required this.youtubeId,
  });
}

// Playlist sealed class
@MappableClass()
sealed class Playlist with PlaylistMappable {
  final String name;
  final List<Track> tracks;
  final DateTime createdAt;

  const Playlist({
    required this.name,
    required this.tracks,
    required this.createdAt,
  });
}

@MappableClass()
final class LocalPlaylist extends Playlist with LocalPlaylistMappable {
  const LocalPlaylist({
    required super.name,
    required super.tracks,
    required super.createdAt,
  });
}

@MappableClass()
final class YouTubePlaylist extends Playlist with YouTubePlaylistMappable {
  const YouTubePlaylist({
    required super.name,
    required super.tracks,
    required super.createdAt,
  });
}

/// Player state model
@MappableClass()
class YouTubePlayerState with YouTubePlayerStateMappable {
  final List<YouTubeTrack> playlist;
  final int currentTrackIndex;
  final bool isPlaying;
  final double volume;
  final bool autoPlay;
  final double currentTime;
  final double duration;

  const YouTubePlayerState({
    this.playlist = const [],
    this.currentTrackIndex = 0,
    this.isPlaying = false,
    this.volume = 0.7,
    this.autoPlay = true,
    this.currentTime = 0,
    this.duration = 0,
  });

  YouTubeTrack? get currentTrack => playlist.isNotEmpty && currentTrackIndex < playlist.length ? playlist[currentTrackIndex] : null;
}
