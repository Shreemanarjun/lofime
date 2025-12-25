import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:lofime/features/ui/components/background.dart';
import 'package:lofime/features/ui/components/footer.dart';
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
        div(classes: "relative z-10 w-full min-h-screen flex flex-col", [
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
      classes: "flex-1 flex flex-col container mx-auto px-4 md:px-8 py-12 md:py-24",
      [
        // Minimal Logo/Header
        const div(classes: "mb-16 flex flex-col items-center text-center space-y-2", [
          h1(classes: "text-4xl md:text-6xl font-black text-white tracking-tighter", [Component.text("lofime")]),
          p(classes: "text-purple-400/60 text-xs md:text-sm font-black tracking-[0.4em] uppercase", [Component.text("Hindi Chill Beats")]),
        ]),

        div(
          classes: "flex-1 w-full",
          [
            Builder(
              builder: (context) {
                final playerState = context.watch(youTubePlayerProvider);
                return YouTubePlayer(
                  playlist: playerState.playlist,
                  favorites: playerState.favorites,
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
                  onToggleFavorite: (track) => context.read(youTubePlayerProvider.notifier).toggleFavorite(track),
                  onPlayFavorite: (index) => context.read(youTubePlayerProvider.notifier).playFavorite(index),
                );
              },
            ),
          ],
        ),

        // About Section integrated into Single Page
        const section(classes: "mt-32 pt-24 border-t border-white/5", [
          div(classes: "max-w-4xl mx-auto grid grid-cols-1 md:grid-cols-2 gap-12 text-white/40", [
            div(classes: "space-y-6", [
              h2(classes: "text-2xl font-black text-white px-2", [Component.text("About")]),
              p(classes: "text-sm leading-relaxed px-2", [Component.text("Lofime is an immersive lo-fi sanctuary. Designed for deep work and late-night vibes, bringing the soul of Bollywood chill to your browser.")]),
            ]),
            div(classes: "space-y-6", [
              h2(classes: "text-2xl font-black text-white px-2", [Component.text("Features")]),
              ul(classes: "space-y-3 text-xs font-bold tracking-widest uppercase", [
                li(classes: "flex items-center gap-3", [div(classes: "w-1 h-1 bg-purple-500 rounded-full", []), Component.text("YouTube HD Audio")]),
                li(classes: "flex items-center gap-3", [div(classes: "w-1 h-1 bg-purple-500 rounded-full", []), Component.text("Local Persistance")]),
                li(classes: "flex items-center gap-3", [div(classes: "w-1 h-1 bg-purple-500 rounded-full", []), Component.text("Glassmorphic Design")]),
              ]),
            ]),
          ]),
        ]),

        const Footer(),
      ],
    );
  }
}
