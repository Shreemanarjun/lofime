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
        div(classes: "relative z-10 w-full min-h-screen flex flex-col", [
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
      classes: "flex-1 flex flex-col container mx-auto px-4 md:px-8 py-8 md:py-16",
      [
        div(
          classes: "flex-1 w-full relative",
          [
            Builder(
              builder: (context) {
                final playerState = context.watch(youTubePlayerProvider);

                // Show loading state while playlist is being fetched
                if (playerState.playlist.isEmpty && playerState.isLoading) {
                  return div(classes: "flex flex-col items-center justify-center min-h-[600px] space-y-8", [
                    div(classes: "relative", [
                      div(classes: "w-32 h-32 border-4 border-purple-500/20 border-t-purple-500 rounded-full animate-spin", []),
                      div(classes: "absolute inset-0 w-32 h-32 border-4 border-pink-500/20 border-b-pink-500 rounded-full animate-spin animation-delay-1000", []),
                    ]),
                    div(classes: "text-center space-y-3", [
                      h2(classes: "text-2xl md:text-3xl font-black text-white tracking-tight", [Component.text("Loading your vibe...")]),
                      p(classes: "text-purple-300/60 text-sm font-medium tracking-widest uppercase", [Component.text("Searching for Amtee's finest")]),
                    ]),
                  ]);
                }

                return div(classes: "relative w-full", [
                  // Main Player
                  YouTubePlayer(
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
                    onJumpToTrack: (index) => context.read(youTubePlayerProvider.notifier).jumpToTrack(index),
                  ),
                ]);
              },
            ),
          ],
        ),

        // About Section integrated into Single Page
        section(classes: "mt-32 pt-24 border-t border-white/5", [
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
