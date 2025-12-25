import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

class AnimatedBackground extends StatelessComponent {
  const AnimatedBackground({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'fixed inset-0 -z-10 overflow-hidden', [
      // Deep Space Base
      const div(classes: 'absolute inset-0 bg-[#0a0a1a]', []),

      // Animated Nebula Gradients
      const div(classes: 'absolute inset-0 opacity-40', [
        div(classes: 'absolute -top-[20%] -left-[10%] w-[60%] h-[60%] rounded-full bg-purple-600/30 blur-[120px] animate-pulse', []),
        div(classes: 'absolute top-[20%] -right-[10%] w-[50%] h-[50%] rounded-full bg-blue-600/20 blur-[100px] animate-pulse animation-delay-2000', []),
        div(classes: 'absolute -bottom-[10%] left-[20%] w-[55%] h-[55%] rounded-full bg-pink-600/20 blur-[110px] animate-pulse animation-delay-4000', []),
      ]),

      // Starry Particles
      div(classes: 'absolute inset-0', [
        for (var i = 0; i < 50; i++)
          div(
              classes: 'absolute rounded-full bg-white opacity-40 animate-twinkle',
              styles: Styles(raw: {
                'top': '${(i * 7) % 100}%',
                'left': '${(i * 13) % 100}%',
                'width': '${(i % 3) + 1}px',
                'height': '${(i % 3) + 1}px',
                'animation-delay': '${(i * 200)}ms',
                'box-shadow': '0 0 ${(i % 4) + 2}px rgba(255, 255, 255, 0.8)',
              }),
              const []),
      ]),

      // Floating Anime Blobs (Glassmorphism style)
      const div(classes: 'absolute inset-0 overflow-hidden pointer-events-none', [
        div(classes: 'absolute top-[10%] left-[15%] w-64 h-64 bg-white/5 rounded-full blur-3xl animate-float', []),
        div(classes: 'absolute bottom-[15%] right-[10%] w-96 h-96 bg-purple-500/5 rounded-full blur-3xl animate-float-delay-2', []),
      ]),

      // Scanline Effect (Retro Anime feel)
      const div(classes: 'absolute inset-0 pointer-events-none opacity-[0.03]', [
        div(
            classes: 'w-full h-full',
            styles: Styles(raw: {
              'background': 'linear-gradient(rgba(18, 16, 16, 0) 50%, rgba(0, 0, 0, 0.25) 50%), linear-gradient(90deg, rgba(255, 0, 0, 0.06), rgba(0, 255, 0, 0.02), rgba(0, 0, 255, 0.06))',
              'background-size': '100% 4px, 3px 100%',
            }),
            []),
      ]),
    ]);
  }
}
