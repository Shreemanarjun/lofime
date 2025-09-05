import 'package:jaspr/jaspr.dart';
import 'package:lofime/pages/home.dart';

class TabNavigation extends StatelessComponent {
  final Tab activeTab;
  final void Function(Tab tab) onTabChange;

  const TabNavigation({
    super.key,
    required this.activeTab,
    required this.onTabChange,
  });

  @override
  Component build(BuildContext context) {
    return div(classes: 'flex justify-center mb-8', [
      div(
        classes:
            'bg-black/20 backdrop-blur-md rounded-2xl p-2 border border-purple-300/30',
        [
          div(classes: 'flex space-x-2', [
            // YouTube button
            button(
              events: {
                'click': (e) => onTabChange(Tab.youtube),
              },
              classes:
                  'flex items-center space-x-2 px-6 py-3 rounded-xl transition-all duration-300 ${activeTab == Tab.youtube ? 'bg-gradient-to-r from-red-500/40 to-red-600/40 border border-red-400/50 text-white' : 'text-purple-200 hover:bg-purple-600/20 hover:text-white'}',
              [
                // Youtube icon (Lucide inline SVG)
                svg(
                  attributes: {
                    'xmlns': 'http://www.w3.org/2000/svg',
                    'viewBox': '0 0 24 24',
                    'fill': 'none',
                    'stroke': 'currentColor',
                    'stroke-width': '2',
                    'stroke-linecap': 'round',
                    'stroke-linejoin': 'round',
                    'width': '20',
                    'height': '20',
                  },
                  [
                    path(attributes: {
                      'd':
                          'M22.54 6.42a2.78 2.78 0 0 0-1.95-1.96C18.88 4 12 4 12 4s-6.88 0-8.59.46a2.78 2.78 0 0 0-1.95 1.96A29.94 29.94 0 0 0 1 12a29.94 29.94 0 0 0 .46 5.58 2.78 2.78 0 0 0 1.95 1.96C5.12 20 12 20 12 20s6.88 0 8.59-.46a2.78 2.78 0 0 0 1.95-1.96A29.94 29.94 0 0 0 23 12a29.94 29.94 0 0 0-.46-5.58z'
                    }, []),
                    polygon(attributes: {
                      'points': '9.75 15.02 15.5 12 9.75 8.98 9.75 15.02'
                    }, []),
                  ],
                ),
                span(classes: 'font-medium', [text('YouTube Mode')]),
                div(classes: 'flex items-center space-x-1', [
                  div(
                      classes:
                          'w-2 h-2 bg-green-400 rounded-full animate-pulse',
                      []),
                  span(classes: 'text-xs text-green-300', [text('Auto')]),
                ]),
              ],
            ),

            // Local Playlist button
            button(
              events: {
                'click': (e) => onTabChange(Tab.local),
              },
              classes:
                  'flex items-center space-x-2 px-6 py-3 rounded-xl transition-all duration-300 ${activeTab == Tab.local ? 'bg-gradient-to-r from-purple-500/40 to-pink-500/40 border border-purple-400/50 text-white' : 'text-purple-200 hover:bg-purple-600/20 hover:text-white'}',
              [
                // Music icon (Lucide inline SVG)
                svg(
                  attributes: {
                    'xmlns': 'http://www.w3.org/2000/svg',
                    'viewBox': '0 0 24 24',
                    'fill': 'none',
                    'stroke': 'currentColor',
                    'stroke-width': '2',
                    'stroke-linecap': 'round',
                    'stroke-linejoin': 'round',
                    'width': '20',
                    'height': '20',
                  },
                  [
                    path(attributes: {'d': 'M9 18V5l12-2v13'}, []),
                    circle(attributes: {'cx': '6', 'cy': '18', 'r': '3'}, []),
                    circle(attributes: {'cx': '18', 'cy': '16', 'r': '3'}, []),
                  ],
                ),
                span(classes: 'font-medium', [text('Local Playlist')]),
              ],
            ),
          ]),
        ],
      ),
    ]);
  }
}
