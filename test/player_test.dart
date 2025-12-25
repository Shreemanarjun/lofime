import 'package:jaspr_test/jaspr_test.dart';
import 'package:lofime/features/player/player_view.dart';
import 'package:lofime/core/models/player_models.dart';

void main() {
  group('YouTubePlayer Component', () {
    testComponents('renders track info when playlist is not empty', (tester) async {
      final tracks = [
        const YouTubeTrack(
          title: 'Test Song',
          artist: 'Test Artist',
          url: '',
          youtubeId: 'test_id',
        ),
      ];

      tester.pumpComponent(YouTubePlayer(
        playlist: tracks,
        currentTrackIndex: 0,
        isPlaying: false,
        volume: 0.5,
        currentTime: 0,
        duration: 200,
        isLoading: false,
        onNext: () {},
        onPrevious: () {},
        onVolumeChange: (_) {},
        onPlay: () {},
        onPause: () {},
        autoPlay: true,
        onToggleAutoPlay: () {},
        onSeek: (_) {},
        onSearch: (_) {},
        onAutoDiscover: () {},
      ));

      expect(find.text('Test Song'), findsComponents);
      expect(find.text('Test Artist'), findsComponents);
    });

    testComponents('renders empty state when playlist is empty', (tester) async {
      tester.pumpComponent(YouTubePlayer(
        playlist: const [],
        currentTrackIndex: 0,
        isPlaying: false,
        volume: 0.5,
        currentTime: 0,
        duration: 0,
        isLoading: false,
        onNext: () {},
        onPrevious: () {},
        onVolumeChange: (_) {},
        onPlay: () {},
        onPause: () {},
        autoPlay: true,
        onToggleAutoPlay: () {},
        onSeek: (_) {},
        onSearch: (_) {},
        onAutoDiscover: () {},
      ));

      expect(find.text('Your stage is empty'), findsOneComponent);
    });
  });
}
