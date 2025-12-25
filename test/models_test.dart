import 'package:test/test.dart';
import 'package:lofime/core/models/player_models.dart';

void main() {
  group('Player Models', () {
    test('YouTubeTrack copyWith works correctly', () {
      const track = YouTubeTrack(
        title: 'Original Title',
        artist: 'Original Artist',
        url: 'original_url',
        youtubeId: 'original_id',
      );

      final updatedTrack = track.copyWith(
        title: 'Updated Title',
      );

      expect(updatedTrack.title, equals('Updated Title'));
      expect(updatedTrack.artist, equals('Original Artist'));
      expect(updatedTrack.youtubeId, equals('original_id'));
    });

    test('YouTubePlayerState copyWith works correctly', () {
      const state = YouTubePlayerState(
        isPlaying: false,
        volume: 0.5,
      );

      final updatedState = state.copyWith(
        isPlaying: true,
      );

      expect(updatedState.isPlaying, isTrue);
      expect(updatedState.volume, equals(0.5));
    });
  });
}
