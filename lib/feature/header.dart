import 'package:jaspr/jaspr.dart';

class Header extends StatelessComponent {
  const Header({super.key});

  @override
  Component build(BuildContext context) {
    return header(classes: 'flex items-center justify-between p-6', [
      // Left side logo + title
      div(classes: 'flex items-center space-x-3', [
        div(
          classes:
              'w-12 h-12 bg-gradient-to-r from-purple-500 to-pink-500 rounded-2xl flex items-center justify-center',
          [
            // Lucide "Radio" icon replacement → inline SVG
            svg(
              classes: 'text-white',
              attributes: {
                'xmlns': 'http://www.w3.org/2000/svg',
                'viewBox': '0 0 24 24',
                'fill': 'none',
                'stroke': 'currentColor',
                'stroke-width': '2',
                'stroke-linecap': 'round',
                'stroke-linejoin': 'round',
                'width': '24',
                'height': '24',
              },
              [
                circle(
                  attributes: {'cx': '12', 'cy': '12', 'r': '2'},
                []),
                path(attributes: {'d': 'M16.24 7.76a6 6 0 0 1 0 8.49'}, []),
                path(
                  attributes: {'d': 'M7.76 7.76a6 6 0 0 0 0 8.49'},
                []),
                path(attributes: {'d': 'M19.07 4.93a10 10 0 0 1 0 14.14'}, []),
                path(attributes: {'d': 'M4.93 4.93a10 10 0 0 0 0 14.14'}, []),
              ],
            ),
          ],
        ),
        div([
          h1(
              classes: 'text-2xl font-bold text-white',
              [text('LoFi Bollywood')]),
          p(
              classes: 'text-purple-200 text-sm',
              [text('Chill Beats & Hindi Vibes')]),
        ]),
      ]),

      // Right side "Live" indicator (hidden on mobile)
      div(classes: 'hidden md:flex items-center space-x-6', [
        span(classes: 'text-purple-200 text-sm', [text('🎧 Relax & Unwind')]),
        div(classes: 'w-3 h-3 bg-green-400 rounded-full animate-pulse', []),
        span(classes: 'text-green-300 text-sm font-medium', [text('Live')]),
      ]),
    ]);
  }
}
