import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:lofime/features/ui/components/background.dart';
import 'package:lofime/features/ui/components/footer.dart';
import 'package:lofime/features/ui/components/header.dart';
import 'package:lofime/features/player/controller/player_controller.dart';
import 'package:lofime/features/player/player_view.dart';

class Home extends StatefulComponent {
  const Home({super.key});

  @override
  State createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Component build(BuildContext context) {
    return const section(
      [
        AnimatedBackground(),
        div(classes: "relative z-10", [
          Header(),
          PlayerComponent(),
        ]),
      ],
    );
  }
}

class PlayerComponent extends StatelessComponent {
  const PlayerComponent({super.key});

  @override
  Component build(BuildContext context) {
    return main_(
      classes: "container mx-auto px-4 py-8",
      [
        div(
          classes: "flex justify-center items-start min-h-screen",
          [
            Builder(
              builder: (context) {
                final playerState = context.watch(youTubePlayerProvider);
                return div(
                  classes: "w-full max-w-4xl mx-auto",
                  [
                    YouTubePlayer(
                      playlist: playerState.playlist,
                      currentTrackIndex: playerState.currentTrackIndex,
                      isPlaying: playerState.isPlaying,
                      volume: playerState.volume,
                      currentTime: playerState.currentTime,
                      duration: playerState.duration,
                      isLoading: playerState.isLoading,
                      onNext: () => context.read(youTubePlayerProvider.notifier).next(),
                      onPrevious: () => context.read(youTubePlayerProvider.notifier).previous(),
                      onVolumeChange: (volume) => context.read(youTubePlayerProvider.notifier).setVolume(volume),
                      onPlay: () => context.read(youTubePlayerProvider.notifier).play(),
                      onPause: () => context.read(youTubePlayerProvider.notifier).pause(),
                      autoPlay: playerState.autoPlay,
                      onToggleAutoPlay: () => context.read(youTubePlayerProvider.notifier).toggleAutoPlay(),
                      onSeek: (time) => context.read(youTubePlayerProvider.notifier).seek(time),
                      onSearch: (query) => context.read(youTubePlayerProvider.notifier).search(query),
                      onAutoDiscover: () => context.read(youTubePlayerProvider.notifier).autoDiscover(),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        const Footer(),
      ],
    );
  }
}
