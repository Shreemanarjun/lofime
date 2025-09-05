import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' hide Component, List;
import 'package:lofime/data/local_player_model.dart';

class YouTubePlaylist extends StatelessComponent {
  final List<YouTubeTrack> playlist;
  final int currentTrackIndex;
  final void Function(int) onTrackSelect;
  final bool autoPlay;

  const YouTubePlaylist({
    super.key,
    required this.playlist,
    required this.currentTrackIndex,
    required this.onTrackSelect,
    required this.autoPlay,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'w-full max-w-md bg-black/20 backdrop-blur-md rounded-2xl p-6 border border-purple-300/30 shadow-2xl',
      [
        // Header
        div(classes: 'flex items-center justify-between mb-6', [
          h3(
            classes: 'text-xl font-bold text-white flex items-center',
            [
              Youtube(classes: 'mr-2 text-red-400'),
              text('YouTube LoFi Mix (${playlist.length})'),
            ],
          ),
          div(classes: 'flex items-center space-x-2', [
            div(classes: 'w-2 h-2 bg-red-500 rounded-full animate-pulse', []),
            span(classes: 'text-red-300 text-sm font-medium', [text('Live Stream')]),
          ]),
        ]),

        // AutoPlay Notice
        if (autoPlay)
          div(
            classes: 'mb-4 p-3 bg-green-500/20 border border-green-400/30 rounded-xl flex-shrink-0',
            [
              div(classes: 'flex items-center space-x-2', [
                div(classes: 'w-3 h-3 bg-green-400 rounded-full animate-pulse', []),
                span(classes: 'text-green-300 text-sm', [
                  text('Auto-play is enabled - tracks will play continuously'),
                ]),
              ]),
            ],
          ),

        // Playlist Container with proper height constraints
        div(
          classes: 'flex flex-col min-h-0 flex-1',
          [
            div(
              classes: 'flex-1 overflow-y-auto custom-scrollbar',
              styles: const Styles(
                raw: {
                  'max-height': 'calc(70vh - 200px)', // Responsive height calculation
                  'min-height': '200px',
                },
              ),
              [
                if (playlist.isEmpty)
                  div(classes: 'text-center py-8 text-purple-200', [
                    Youtube(height: 48.px, width: 48.px, classes: 'mx-auto mb-4 opacity-50'),
                    p([text('No YouTube tracks available')]),
                  ])
                else
                  div(classes: 'space-y-2 pr-2', [
                    // Added padding-right for scrollbar
                    for (var i = 0; i < playlist.length; i++)
                      div(
                        key: ValueKey(i),
                        classes:
                            'p-3 rounded-xl border transition-all duration-300 cursor-pointer group flex-shrink-0 ${i == currentTrackIndex ? 'bg-gradient-to-r from-red-600/40 to-pink-600/40 border-red-300/60' : 'bg-purple-900/20 border-purple-400/30 hover:bg-purple-800/30 hover:border-purple-300/50'}',
                        events: {'click': (e) => onTrackSelect(i)},
                        [
                          div(classes: 'flex items-center justify-between', [
                            div(classes: 'flex items-center space-x-3 flex-1 min-w-0', [
                              div(
                                classes: 'w-8 h-8 rounded-lg bg-gradient-to-br from-red-500/50 to-pink-500/50 flex items-center justify-center flex-shrink-0',
                                [
                                  if (i == currentTrackIndex) Play(height: 14.px, width: 14.px, classes: 'text-white') else Youtube(height: 14.px, width: 14.px, classes: 'text-white'),
                                ],
                              ),
                              div(classes: 'flex-1 min-w-0', [
                                h4(classes: 'text-white font-medium truncate', [text(playlist[i].title)]),
                                p(classes: 'text-purple-200 text-sm truncate', [text(playlist[i].artist)]),
                              ]),
                            ]),
                            if (i == currentTrackIndex)
                              div(classes: 'flex items-center space-x-2 flex-shrink-0 ml-2', [
                                div(classes: 'w-2 h-2 bg-red-400 rounded-full animate-pulse', []),
                                span(classes: 'text-red-300 text-xs whitespace-nowrap', [text('Now Playing')]),
                              ]),
                          ]),
                        ],
                      ),
                  ]),
              ],
            ),
          ],
        ),

        // Footer
        div(classes: 'mt-4 pt-4 text-center text-xs text-purple-300/70 flex-shrink-0 border-t border-purple-400/20', [
          p([text('🎧 Curated LoFi Bollywood collection from YouTube')]),
        ]),
      ],
    );
  }
}
