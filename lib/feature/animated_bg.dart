import 'package:jaspr/jaspr.dart';

class AnimatedBackground extends StatelessComponent {
  const AnimatedBackground({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'fixed inset-0 -z-10 overflow-hidden', [
      // Gradient Background
      div(classes:
              'absolute inset-0 bg-gradient-to-br from-purple-900 via-blue-900 to-pink-900 animate-gradient', []),

      // Floating Shapes
      div(classes: 'absolute inset-0', [
        div(classes:
                'absolute top-20 left-20 w-32 h-32 bg-purple-500/20 rounded-full blur-xl animate-float', []),
        div(classes:
                'absolute top-60 right-40 w-24 h-24 bg-pink-500/20 rounded-full blur-lg animate-float-delay-1', []),
        div(classes:
                'absolute bottom-40 left-60 w-40 h-40 bg-blue-500/20 rounded-full blur-2xl animate-float-delay-2', []),
        div(classes:
                'absolute bottom-20 right-20 w-28 h-28 bg-purple-400/20 rounded-full blur-xl animate-float-delay-3', []),
        div(classes:
                'absolute top-40 left-1/2 w-20 h-20 bg-pink-400/20 rounded-full blur-lg animate-float-delay-4', []),
        div(classes:
                'absolute bottom-60 right-1/3 w-36 h-36 bg-blue-400/20 rounded-full blur-2xl animate-float-delay-5', []),
      ]),

      // Grid Pattern
      div(classes: 'absolute inset-0 opacity-10', [
        div(classes: 'absolute inset-0',
            styles: const Styles(
              raw: {
                'background-image': '''
              linear-gradient(rgba(168, 85, 247, 0.4) 1px, transparent 1px),
              linear-gradient(90deg, rgba(168, 85, 247, 0.4) 1px, transparent 1px)
            ''',
                'background-size': '50px 50px',
              },
            ), []),
      ]),

      // Anime-inspired Elements
      div(classes: 'absolute inset-0 pointer-events-none', [
        div(classes:
                'absolute top-10 right-10 w-2 h-2 bg-yellow-300 rounded-full animate-twinkle', []),
        div(classes:
                'absolute top-32 right-32 w-1 h-1 bg-yellow-200 rounded-full animate-twinkle-delay-1', []),
        div(classes:
                'absolute bottom-32 left-10 w-2 h-2 bg-yellow-400 rounded-full animate-twinkle-delay-2', []),
        div(classes:
                'absolute bottom-10 left-32 w-1 h-1 bg-yellow-300 rounded-full animate-twinkle-delay-3', []),
        div(classes:
                'absolute top-1/2 right-1/4 w-1 h-1 bg-yellow-200 rounded-full animate-twinkle-delay-4', []),
      ]),
    ]);
  }
}
