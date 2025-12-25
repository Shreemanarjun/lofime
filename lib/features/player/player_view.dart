import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import 'package:jaspr_lucide/jaspr_lucide.dart' hide List, Key;
import 'package:lofime/core/models/player_models.dart';
import 'package:universal_web/web.dart' as web;

class YouTubePlayer extends StatefulComponent {
  final List<YouTubeTrack> playlist;
  final int currentTrackIndex;
  final bool isPlaying;
  final double volume;
  final double currentTime;
  final double duration;
  final bool isLoading;
  final void Function() onNext;
  final void Function() onPrevious;
  final void Function(double volume) onVolumeChange;
  final void Function() onPlay;
  final void Function() onPause;
  final bool autoPlay;
  final void Function() onToggleAutoPlay;
  final void Function(double time) onSeek;
  final void Function(String query) onSearch;
  final void Function() onAutoDiscover;

  const YouTubePlayer({
    super.key,
    required this.playlist,
    required this.currentTrackIndex,
    required this.isPlaying,
    required this.volume,
    required this.currentTime,
    required this.duration,
    required this.isLoading,
    required this.onNext,
    required this.onPrevious,
    required this.onVolumeChange,
    required this.onPlay,
    required this.onPause,
    required this.autoPlay,
    required this.onToggleAutoPlay,
    required this.onSeek,
    required this.onSearch,
    required this.onAutoDiscover,
  });

  @override
  State createState() => _YouTubePlayerState();
}

class _YouTubePlayerState extends State<YouTubePlayer> {
  bool isLiked = false;
  String _tempSearchQuery = '';

  @override
  Component build(BuildContext context) {
    final currentTrack = component.playlist.isNotEmpty && component.currentTrackIndex < component.playlist.length ? component.playlist[component.currentTrackIndex] : null;

    final progressPercentage = component.duration > 0 ? (component.currentTime / component.duration) * 100 : 0;
    final isLiveStream = component.duration == 0 && component.currentTime > 0;

    return div(
      classes: 'max-w-4xl mx-auto space-y-8',
      [
        // Search and Discover Bar
        div(classes: 'flex flex-col sm:flex-row gap-4 items-center justify-between bg-white/10 backdrop-blur-xl p-4 rounded-3xl border border-white/20 shadow-xl', [
          div(classes: 'relative w-full sm:max-w-md group', [
            input(
              type: InputType.text,
              classes: 'w-full bg-white/5 border border-white/10 rounded-2xl px-12 py-3 text-white placeholder-white/40 focus:outline-none focus:ring-2 focus:ring-purple-500/50 transition-all group-hover:bg-white/10',
              attributes: const {'placeholder': 'Search for lofi hits...'},
              onInput: (value) => _tempSearchQuery = value.toString(),
              events: {
                'keydown': (dynamic e) {
                  final event = e as web.KeyboardEvent;
                  if (event.key == 'Enter') {
                    component.onSearch(_tempSearchQuery);
                  }
                }
              },
            ),
            div(classes: 'absolute left-4 top-1/2 -translate-y-1/2 text-white/40', [Search(width: const Unit.pixels(20), height: const Unit.pixels(20))]),
          ]),
          div(classes: 'flex gap-3 w-full sm:w-auto', [
            button(
                events: {'click': (e) => component.onSearch(_tempSearchQuery)},
                classes: 'px-6 py-3 bg-purple-600 hover:bg-purple-500 text-white font-semibold rounded-2xl transition-all hover:scale-105 active:scale-95 shadow-lg shadow-purple-600/20',
                const [Component.text('Search')]),
            button(
                events: {'click': (e) => component.onAutoDiscover()},
                classes: 'px-6 py-3 bg-white/10 hover:bg-white/20 text-white font-semibold rounded-2xl border border-white/10 transition-all flex items-center gap-2 hover:scale-105 active:scale-95',
                [Sparkles(width: const Unit.pixels(18), height: const Unit.pixels(18)), const Component.text('Surprise me')]),
          ]),
        ]),

        if (component.isLoading)
          const div(classes: 'flex flex-col items-center justify-center p-20 space-y-4 bg-black/20 rounded-3xl backdrop-blur-md', [
            div(classes: 'w-16 h-16 border-4 border-purple-500/30 border-t-purple-500 rounded-full animate-spin', []),
            p(classes: 'text-purple-200 font-medium animate-pulse', [Component.text('Discovering magic...')]),
          ])
        else if (currentTrack == null)
          div(classes: 'bg-black/20 backdrop-blur-md rounded-3xl p-12 border border-white/10 text-center', [
            Music(width: const Unit.pixels(48), height: const Unit.pixels(48), classes: 'mx-auto text-white/20 mb-4'),
            const h3(classes: 'text-xl font-bold text-white mb-2', [Component.text('Your stage is empty')]),
            const p(classes: 'text-white/60', [Component.text('Search for a track or use "Surprise me" to start the lofi vibe.')]),
          ])
        else
          div(
            classes: 'grid grid-cols-1 lg:grid-cols-12 gap-8',
            [
              // Main Player Card
              div(classes: 'lg:col-span-8 bg-black/30 backdrop-blur-2xl rounded-[40px] p-8 sm:p-12 border border-white/10 shadow-2xl relative overflow-hidden group', [
                const div(classes: 'absolute -top-24 -right-24 w-64 h-64 bg-purple-500/10 blur-[80px] rounded-full group-hover:bg-purple-500/20 transition-all duration-1000', []),
                div(classes: 'relative flex flex-col items-center', [
                  div(classes: 'relative mb-10 w-full max-w-[280px]', [
                    const div(classes: 'absolute inset-0 bg-gradient-to-tr from-purple-500/40 to-pink-500/40 blur-2xl rounded-full scale-90 animate-pulse', []),
                    div(
                      classes: 'relative aspect-square rounded-[32px] overflow-hidden border-2 border-white/20 shadow-2xl transition-transform duration-500 hover:scale-105',
                      [
                        img(
                          src: 'https://img.youtube.com/vi/${currentTrack.youtubeId}/maxresdefault.jpg',
                          alt: currentTrack.title,
                          classes: 'w-full h-full object-cover',
                          events: {
                            'error': (dynamic e) {
                              final el = e.target as web.HTMLImageElement;
                              el.src = 'https://img.youtube.com/vi/${currentTrack.youtubeId}/hqdefault.jpg';
                            }
                          },
                        ),
                        if (component.isPlaying)
                          div(classes: 'absolute inset-0 flex items-center justify-center bg-black/20', [
                            div(classes: 'flex gap-1 items-end h-8', [
                              for (var i = 0; i < 4; i++) div(classes: 'w-1.5 bg-white rounded-full animate-music-bar', styles: Styles(raw: {'animation-delay': '${i * 150}ms'}), const []),
                            ])
                          ]),
                      ],
                    ),
                  ]),
                  div(classes: 'text-center mb-10 w-full', [
                    h2(classes: 'text-3xl sm:text-4xl font-black text-white mb-3 line-clamp-1 leading-tight', [Component.text(currentTrack.title)]),
                    p(classes: 'text-xl text-purple-200/80 font-medium', [Component.text(currentTrack.artist)]),
                  ]),
                  div(classes: 'w-full mb-10', [
                    div(classes: 'flex justify-between text-sm font-bold text-white/60 mb-3 font-mono', [
                      span([Component.text(_formatTime(component.currentTime))]),
                      if (!isLiveStream) span([Component.text(_formatTime(component.duration))]),
                    ]),
                    div(
                      classes: 'relative h-3 w-full bg-white/5 rounded-full cursor-pointer group/progress',
                      events: {
                        'click': (dynamic e) {
                          if (isLiveStream || component.duration <= 0) return;
                          final event = e as web.MouseEvent;
                          final progressBar = event.currentTarget as web.HTMLElement;
                          final rect = progressBar.getBoundingClientRect();
                          final clickX = event.clientX - rect.left;
                          final width = progressBar.clientWidth;
                          final seekTime = (clickX / width) * component.duration;
                          component.onSeek(seekTime);
                        },
                      },
                      [
                        const div(classes: 'absolute inset-0 bg-white/10 rounded-full scale-y-50 group-hover/progress:scale-y-100 transition-transform origin-center', []),
                        div(classes: 'absolute h-full bg-gradient-to-r from-purple-500 via-pink-500 to-purple-500 rounded-full transition-all shadow-[0_0_20px_rgba(168,85,247,0.4)]', styles: Styles(raw: {'width': '$progressPercentage%'}), const []),
                        div(classes: 'absolute h-6 w-1.5 bg-white rounded-full top-1/2 -translate-y-1/2 -translate-x-1 shadow-lg opacity-0 group-hover/progress:opacity-100 transition-opacity', styles: Styles(raw: {'left': '$progressPercentage%'}), const []),
                      ],
                    ),
                  ]),
                  div(classes: 'flex items-center gap-6 sm:gap-10', [
                    button(events: {'click': (e) => component.onPrevious()}, classes: 'text-white/60 hover:text-white transition-all hover:scale-110 active:scale-90', [SkipBack(width: const Unit.pixels(32), height: const Unit.pixels(32))]),
                    button(
                        events: {'click': (e) => component.isPlaying ? component.onPause() : component.onPlay()},
                        classes: 'w-20 h-20 sm:w-24 sm:h-24 flex items-center justify-center bg-white text-black rounded-full hover:scale-105 active:scale-95 transition-all shadow-xl shadow-white/10',
                        [
                          component.isPlaying ? Pause(width: const Unit.pixels(40), height: const Unit.pixels(40), attributes: const {'fill': 'black'}) : Play(width: const Unit.pixels(40), height: const Unit.pixels(40), attributes: const {'fill': 'black'})
                        ]),
                    button(events: {'click': (e) => component.onNext()}, classes: 'text-white/60 hover:text-white transition-all hover:scale-110 active:scale-90', [SkipForward(width: const Unit.pixels(32), height: const Unit.pixels(32))]),
                  ]),
                ]),
              ]),

              div(classes: 'lg:col-span-4 flex flex-col gap-6', [
                div(classes: 'bg-black/30 backdrop-blur-xl p-6 rounded-[32px] border border-white/10', [
                  div(classes: 'flex items-center justify-between mb-4', [
                    const h3(classes: 'text-xl font-bold text-white', [Component.text('Coming up next')]),
                    span(classes: 'text-white/40 text-sm font-mono', [Component.text('${component.playlist.length} Tracks')]),
                  ]),
                  div(classes: 'space-y-3 max-h-[400px] overflow-y-auto pr-2 custom-scrollbar', [for (var i = 0; i < component.playlist.length; i++) _buildTrackItem(i, component.playlist[i], i == component.currentTrackIndex)]),
                ]),
                div(classes: 'bg-black/30 backdrop-blur-xl p-6 rounded-[32px] border border-white/10 space-y-6', [
                  div(classes: 'flex items-center gap-4', [
                    Volume2(width: const Unit.pixels(20), height: const Unit.pixels(20), classes: 'text-white/60'),
                    input(
                      type: InputType.range,
                      attributes: {'min': '0', 'max': '100', 'value': '${(component.volume * 100).toInt()}'},
                      classes: 'flex-1 h-1.5 bg-white/10 rounded-full appearance-none cursor-pointer slider-premium',
                      onInput: (val) => component.onVolumeChange((double.tryParse(val.toString()) ?? 100) / 100),
                    ),
                  ]),
                  div(classes: 'flex items-center justify-between', [
                    button(
                        events: {'click': (e) => setState(() => isLiked = !isLiked)},
                        classes: 'flex items-center gap-2 px-4 py-2 rounded-xl transition-all ${isLiked ? 'bg-red-500/20 text-red-500 border border-red-500/20' : 'bg-white/5 text-white/40 border border-white/5'}',
                        [
                          Heart(width: const Unit.pixels(18), height: const Unit.pixels(18), attributes: {'fill': isLiked ? 'currentColor' : 'none'}),
                          const Component.text('Sweet')
                        ]),
                    button(
                        events: {'click': (e) => component.onToggleAutoPlay()},
                        classes: 'flex items-center gap-2 px-4 py-2 rounded-xl transition-all ${component.autoPlay ? 'bg-green-500/20 text-green-500 border border-green-500/20' : 'bg-white/5 text-white/40 border border-white/5'}',
                        [Shuffle(width: const Unit.pixels(18), height: const Unit.pixels(18)), const Component.text('Infinite')]),
                  ]),
                ]),
              ]),
            ],
          ),
      ],
    );
  }

  Component _buildTrackItem(int index, YouTubeTrack track, bool isActive) {
    return div(
      key: ValueKey('track-$index'),
      classes: 'group flex items-center gap-4 p-3 rounded-2xl transition-all cursor-pointer ${isActive ? 'bg-white/10 border border-white/10' : 'hover:bg-white/5 border border-transparent'}',
      [
        div(classes: 'w-12 h-12 rounded-xl overflow-hidden flex-shrink-0', [
          img(src: 'https://img.youtube.com/vi/${track.youtubeId}/default.jpg', classes: 'w-full h-full object-cover'),
        ]),
        div(classes: 'flex-1 min-w-0', [
          p(classes: 'text-sm font-bold text-white truncate', [Component.text(track.title)]),
          p(classes: 'text-xs text-white/40 truncate', [Component.text(track.artist)]),
        ]),
        if (isActive) const div(classes: 'w-2 h-2 bg-purple-500 rounded-full', []) else span(classes: 'text-xs font-mono text-white/20 group-hover:text-white/40 transition-colors', [Component.text(_formatTime(track.duration ?? 0))]),
      ],
    );
  }

  String _formatTime(double time) {
    final minutes = (time ~/ 60);
    final seconds = (time % 60).toInt().toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
