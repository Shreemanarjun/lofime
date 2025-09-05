import 'package:jaspr/jaspr.dart';

import 'package:jaspr_lucide/jaspr_lucide.dart' hide Component, List;
import 'package:lofime/data/local_player_model.dart';
import 'package:universal_web/web.dart' as web;

class YouTubePlayer extends StatefulComponent {
  final List<YouTubeTrack> playlist;
  final int currentTrackIndex;
  final bool isPlaying;
  final double volume;
  final double currentTime;
  final double duration;
  final void Function() onNext;
  final void Function() onPrevious;
  final void Function(double volume) onVolumeChange;
  final void Function() onPlay;
  final void Function() onPause;
  final bool autoPlay;
  final void Function() onToggleAutoPlay;
  final void Function(double time) onSeek;

  const YouTubePlayer({
    super.key,
    required this.playlist,
    required this.currentTrackIndex,
    required this.isPlaying,
    required this.volume,
    required this.currentTime,
    required this.duration,
    required this.onNext,
    required this.onPrevious,
    required this.onVolumeChange,
    required this.onPlay,
    required this.onPause,
    required this.autoPlay,
    required this.onToggleAutoPlay,
    required this.onSeek,
  });

  @override
  State createState() => _YouTubePlayerState();
}

class _YouTubePlayerState extends State<YouTubePlayer> {
  bool isLiked = false;

  @override
  Component build(BuildContext context) {
// ... inside build():

    if (component.playlist.isEmpty || component.currentTrackIndex >= component.playlist.length) {
      return div(
        classes: 'bg-black/20 backdrop-blur-md rounded-2xl p-8 border border-purple-300/30 shadow-2xl text-center',
        [
          p(classes: 'text-purple-200', [text('No tracks available')]),
        ],
      );
    }

    final currentTrack = component.playlist[component.currentTrackIndex];
    final progressPercentage = component.duration > 0 ? (component.currentTime / component.duration) * 100 : 0;
    // A simple heuristic for live streams: duration is 0 and playback has started.
    final isLiveStream = component.duration == 0 && component.currentTime > 0;

    return div(
      classes: 'bg-black/20 backdrop-blur-md rounded-2xl p-8 border border-purple-300/30 shadow-2xl',
      [
        // Track Info
        div(classes: 'text-center mb-8', [
          div(
            classes: 'w-48 h-48 mx-auto mb-6 rounded-2xl bg-gradient-to-br from-red-500/30 to-pink-500/30 flex items-center justify-center border border-red-300/50 relative overflow-hidden',
            [
              div(
                classes: 'w-40 h-40 rounded-xl bg-gradient-to-br from-red-600/40 to-pink-600/40 flex items-center justify-center relative overflow-hidden',
                [
                  img(
                    src: 'https://img.youtube.com/vi/${currentTrack.youtubeId}/hqdefault.jpg',
                    alt: currentTrack.title,
                    classes: 'w-full h-full object-cover',
                  ),
                  if (component.isPlaying) div(classes: 'absolute inset-0 border-4 border-red-400/50 rounded-xl animate-pulse', []),
                ],
              ),
              if (isLiveStream)
                div(
                  classes: 'absolute top-2 right-2 bg-red-600 text-white px-2 py-1 rounded-lg text-xs font-bold',
                  [text('LIVE')],
                ),
            ],
          ),
          h2(classes: 'text-2xl font-bold text-white mb-2', [text(currentTrack.title)]),
          p(classes: 'text-purple-200 text-lg', [text(currentTrack.artist)]),
        ]),

        // Progress Bar
        div(classes: 'mb-8', [
          div(classes: 'flex justify-between text-sm text-purple-200 mb-2', [
            span([text(_formatTime(component.currentTime))]),
            if (!isLiveStream) span([text(_formatTime(component.duration))]),
          ]),
          div(
            classes: 'w-full h-2 bg-purple-900/50 rounded-full relative overflow-hidden ${isLiveStream ? '' : 'cursor-pointer'}',
            events: {
              'click': (dynamic e) {
                if (isLiveStream || component.duration <= 0) return;

                final event = e as web.MouseEvent;
                final progressBar = event.currentTarget as web.HTMLElement;
                final rect = progressBar.getBoundingClientRect();
                final clickX = event.clientX - rect.left;
                final width = progressBar.clientWidth;
                final seekPercentage = (clickX / width).clamp(0.0, 1.0);
                final seekTime = seekPercentage * component.duration;

                component.onSeek(seekTime);
              },
            },
            [
              if (isLiveStream)
                div(classes: 'h-full w-full bg-gradient-to-r from-red-400 to-pink-400 rounded-full animate-pulse', []) // Indeterminate progress for live streams
              else ...[
                div(
                    classes: 'h-full bg-gradient-to-r from-red-400 to-pink-400 rounded-full transition-all duration-300',
                    styles: Styles(raw: {'width': '$progressPercentage%'}), // progress
                    []),
                div(
                    classes: 'absolute top-1/2 transform -translate-y-1/2 w-4 h-4 bg-white rounded-full shadow-lg transition-all duration-300',
                    styles: Styles(
                      raw: {
                        'left': '$progressPercentage%',
                        'margin-left': '-8px',
                      },
                    ),
                    []),
              ]
            ],
          ),
        ]),

        // Main Controls
        div(classes: 'flex items-center justify-center space-x-6 mb-8', [
          button(
            events: {'click': (e) => component.onPrevious()},
            classes: 'p-3 rounded-full bg-red-600/30 border border-red-400/50 hover:bg-red-500/40 transition-all duration-300 hover:scale-105',
            [
              SkipBack(),
            ],
          ),
          button(
            events: {'click': (e) => _togglePlay()},
            classes: 'p-4 rounded-full bg-gradient-to-r from-red-500 to-pink-500 hover:from-red-400 hover:to-pink-400 transition-all duration-300 hover:scale-105 shadow-lg',
            [
              component.isPlaying ? Pause() : Play(),
            ],
          ),
          button(
            events: {'click': (e) => component.onNext()},
            classes: 'p-3 rounded-full bg-red-600/30 border border-red-400/50 hover:bg-red-500/40 transition-all duration-300 hover:scale-105',
            [
              SkipForward(),
            ],
          ),
        ]),

        // Secondary Controls
        div(classes: 'flex items-center justify-between', [
          div(classes: 'flex items-center space-x-3', [
            button(
              events: {
                'click': (e) => setState(() => isLiked = !isLiked),
              },
              classes: 'p-2 rounded-full transition-all duration-300 ${isLiked ? 'bg-red-500/30 border border-red-400/50 text-red-300' : 'bg-purple-600/20 border border-purple-400/30 text-purple-300'} hover:scale-105',
              [text(isLiked ? '❤️' : '🤍')],
            ),
            button(
              events: {'click': (e) => component.onToggleAutoPlay()},
              classes: 'p-2 rounded-full transition-all duration-300 ${component.autoPlay ? 'bg-green-500/30 border border-green-400/50 text-green-300' : 'bg-purple-600/20 border border-purple-400/30 text-purple-300'} hover:scale-105',
              [text('🔀')],
            ),
          ]),
          div(classes: 'flex items-center space-x-3', [
            span(classes: 'text-purple-200', [text('🔊')]),
            input(
              type: InputType.range,
              attributes: {
                'min': '0',
                'max': '100',
                'value': '${(component.volume * 100).toInt()}',
              },
              classes: 'w-24 h-2 bg-purple-900/50 rounded-full appearance-none cursor-pointer slider',
              onInput: (value) {
                final val = double.tryParse(value) ?? 100;
                component.onVolumeChange(val / 100);
              },
            ),
          ]),
        ]),

        // Auto-Play Indicator
        if (component.autoPlay)
          div(classes: 'mt-4 text-center', [
            div(
              classes: 'inline-flex items-center space-x-2 bg-green-500/20 border border-green-400/30 rounded-lg px-3 py-1',
              [
                div(classes: 'w-2 h-2 bg-green-400 rounded-full animate-pulse', []),
                span(
                  classes: 'text-green-300 text-sm font-medium',
                  [text('Auto-Play Mode')],
                ),
              ],
            ),
          ]),
      ],
    );
  }

  String _formatTime(double time) {
    final minutes = (time ~/ 60);
    final seconds = (time % 60).toInt().toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _togglePlay() {
    if (component.isPlaying) {
      component.onPause();
    } else {
      component.onPlay();
    }
  }
}
