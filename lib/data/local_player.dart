import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' hide Component, List;
import 'package:lofime/data/local_player_model.dart';
class MusicPlayer extends StatefulComponent {
  final Track? currentTrack;
  final List<Track> playlist;
  final int currentTrackIndex;
  final bool isPlaying;
  final double volume;
  final double currentTime;
  final double duration;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final void Function(double) onVolumeChange;
  final void Function(double) onSeek;

  const MusicPlayer({
    super.key,
    required this.currentTrack,
    required this.playlist,
    required this.currentTrackIndex,
    required this.isPlaying,
    required this.volume,
    required this.currentTime,
    required this.duration,
    required this.onPlay,
    required this.onPause,
    required this.onNext,
    required this.onPrevious,
    required this.onVolumeChange,
    required this.onSeek,
  });

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool isLiked = false;

  String formatTime(double time) {
    final minutes = (time ~/ 60);
    final seconds = (time % 60).floor();
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Component build(BuildContext context) {
    final progressPercentage = component.duration > 0 ? (component.currentTime / component.duration) * 100 : 0.0;

    return div(
      classes: 'bg-black/20 backdrop-blur-md rounded-2xl p-8 border border-purple-300/30 shadow-2xl',
      [
        // Track Info
        div(classes: 'text-center mb-8', [
          div(
            classes: 'w-48 h-48 mx-auto mb-6 rounded-2xl bg-gradient-to-br from-purple-500/30 to-pink-500/30 flex items-center justify-center border border-purple-300/50',
            [
              div(
                classes: 'w-40 h-40 rounded-xl bg-gradient-to-br from-purple-600/40 to-pink-600/40 flex items-center justify-center',
                [
                  span(classes: 'text-4xl', [text('🎵')])
                ],
              )
            ],
          ),
          if (component.currentTrack != null) ...[
            h2(classes: 'text-2xl font-bold text-white mb-2', [text(component.currentTrack!.title)]),
            p(classes: 'text-purple-200 text-lg', [text(component.currentTrack!.artist)]),
          ],
        ]),

        // Progress Bar
        div(classes: 'mb-8', [
          div(classes: 'flex justify-between text-sm text-purple-200 mb-2', [
            span([text(formatTime(component.currentTime))]),
            span([text(formatTime(component.duration))]),
          ]),
          div(
            classes: 'w-full h-2 bg-purple-900/50 rounded-full cursor-pointer relative overflow-hidden',
            events: {
              'click': (e) {
              //  final rect = (e.target is web.HTMLInputElement).getBoundingClientRect();
               // final percentage = (e.clientX - rect.left) / rect.width;
              //  component.onSeek(percentage * component.duration);
              }
            },
            [
              div(
                classes: 'h-full bg-gradient-to-r from-purple-400 to-pink-400 rounded-full transition-all duration-300',
                styles: Styles(
                  raw: {'width': '$progressPercentage%'},
                ), // progress bar
                [],
              ),
              div(
                  classes: 'absolute top-1/2 transform -translate-y-1/2 w-4 h-4 bg-white rounded-full shadow-lg transition-all duration-300',
                  styles: Styles(
                    raw: {'left': '$progressPercentage%', 'margin-left': '-8px'},
                  ),
                  []),
            ],
          ),
        ]),

        // Controls
        div(classes: 'flex items-center justify-center space-x-6 mb-8', [
          button(
            classes: 'p-3 rounded-full bg-purple-600/30 border border-purple-400/50 hover:bg-purple-500/40 transition-all duration-300 hover:scale-105',
            disabled: component.playlist.length <= 1,
            events: {'click': (e) => component.onPrevious()},
            [SkipBack(classes: 'text-white')],
          ),
          button(
            classes: 'p-4 rounded-full bg-gradient-to-r from-purple-500 to-pink-500 hover:from-purple-400 hover:to-pink-400 transition-all duration-300 hover:scale-105 shadow-lg',
            events: {'click': (e) => component.isPlaying ? component.onPause() : component.onPlay()},
            [
              component.isPlaying
                  ? Pause(height: 32.px, width: 32.px, classes: 'text-white')
                  : Play(
                      height: 32.px,
                      width: 32.px,
                      classes: 'text-white ml-1',
                    ),
            ],
          ),
          button(
            classes: 'p-3 rounded-full bg-purple-600/30 border border-purple-400/50 hover:bg-purple-500/40 transition-all duration-300 hover:scale-105',
            disabled: component.playlist.length <= 1,
            events: {'click': (e) => component.onNext()},
            [SkipForward(height: 24.px, width: 24.px, classes: 'text-white')],
          ),
        ]),

        // Secondary Controls
        div(classes: 'flex items-center justify-between', [
          button(
            classes: 'p-2 rounded-full transition-all duration-300 ${isLiked ? 'bg-red-500/30 border border-red-400/50 text-red-300' : 'bg-purple-600/20 border border-purple-400/30 text-purple-300'} hover:scale-105',
            events: {
              'click': (e) => setState(() {
                    isLiked = !isLiked;
                  })
            },
            [
              Heart(height: 20.px, width: 20.px, classes: '', styles: Styles(raw: {"fill": isLiked ? 'currentColor' : 'none'}))
            ],
          ),
          div(classes: 'flex items-center space-x-3', [
            Volume2(height: 20.px, width: 20.px, classes: 'text-purple-200'),
            input(
              type: InputType.range,
              attributes: {'min': '0', 'max': '100', 'value': '${(component.volume * 100).toInt()}'},
              classes: 'w-24 h-2 bg-purple-900/50 rounded-full appearance-none cursor-pointer slider',
              onInput: (value) {
                final seekvalue = value ?? 100;
                component.onVolumeChange(seekvalue / 100);
              },
            )
          ]),
        ]),
      ],
    );
  }
}
