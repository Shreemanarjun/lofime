import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import 'package:jaspr_lucide/jaspr_lucide.dart' hide List, Key;
import 'package:lofime/core/models/player_models.dart';
import 'package:universal_web/web.dart' as web;

class YouTubePlayer extends StatefulComponent {
  final List<YouTubeTrack> playlist;
  final List<YouTubeTrack> favorites;
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
  final void Function(YouTubeTrack track) onToggleFavorite;
  final void Function(int index) onPlayFavorite;

  const YouTubePlayer({
    super.key,
    required this.playlist,
    required this.favorites,
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
    required this.onToggleFavorite,
    required this.onPlayFavorite,
  });

  @override
  State createState() => _YouTubePlayerState();
}

class _YouTubePlayerState extends State<YouTubePlayer> {
  String _tempSearchQuery = '';
  int _activeTab = 0; // 0 for Playlist, 1 for Library

  @override
  Component build(BuildContext context) {
    final currentTrack = component.playlist.isNotEmpty && component.currentTrackIndex < component.playlist.length ? component.playlist[component.currentTrackIndex] : null;

    final progressPercentage = component.duration > 0 ? (component.currentTime / component.duration) * 100 : 0;
    final isLiveStream = component.duration == 0 && component.currentTime > 0;
    final isFavorite = currentTrack != null && component.favorites.any((t) => t.youtubeId == currentTrack.youtubeId);

    return div(
      classes: 'max-w-6xl mx-auto space-y-8 animate-in fade-in duration-700',
      [
        // Modern Search Bar
        div(classes: 'flex flex-col md:flex-row gap-4 items-center bg-white/5 backdrop-blur-2xl p-2 rounded-[2rem] border border-white/10 shadow-2xl overflow-hidden', [
          div(classes: 'relative flex-1 group w-full', [
            input(
              type: InputType.text,
              classes: 'w-full bg-transparent border-none rounded-2xl px-12 py-4 text-white placeholder-white/30 focus:outline-none transition-all',
              attributes: const {'placeholder': 'Search your vibe...'},
              onInput: (value) => _tempSearchQuery = value.toString(),
              events: {
                'keydown': (dynamic e) {
                  final event = e as web.KeyboardEvent;
                  if (event.key == 'Enter') {
                    component.onSearch(_tempSearchQuery);
                  }
                },
              },
            ),
            div(classes: 'absolute left-5 top-1/2 -translate-y-1/2 text-white/30 group-focus-within:text-purple-400 transition-colors', [Search(width: const Unit.pixels(22), height: const Unit.pixels(22))]),
          ]),
          div(classes: 'flex gap-2 p-1 w-full md:w-auto', [
            button(events: {'click': (e) => component.onSearch(_tempSearchQuery)}, classes: 'flex-1 md:flex-none px-8 py-3 bg-white text-black font-bold rounded-3xl hover:bg-neutral-200 transition-all active:scale-95', const [Component.text('Search')]),
            button(
              events: {'click': (e) => component.onAutoDiscover()},
              classes: 'p-3 bg-white/10 hover:bg-white/20 text-white rounded-full transition-all hover:rotate-12',
              [Sparkles(width: const Unit.pixels(22), height: const Unit.pixels(22))],
            ),
          ]),
        ]),

        if (component.isLoading)
          const div(classes: 'flex flex-col items-center justify-center py-32 space-y-6', [
            div(classes: 'w-20 h-20 border-2 border-purple-500/20 border-t-purple-500 rounded-full animate-spin', []),
            p(classes: 'text-purple-200/50 font-medium tracking-widest uppercase text-sm animate-pulse', [Component.text('Syncing with the universe...')]),
          ])
        else if (currentTrack == null)
          div(classes: 'bg-white/5 backdrop-blur-xl rounded-[3rem] p-24 border border-white/10 text-center space-y-6', [
            div(classes: 'w-24 h-24 bg-white/5 rounded-full flex items-center justify-center mx-auto', [Music(width: const Unit.pixels(40), height: const Unit.pixels(40), classes: 'text-white/20')]),
            const div([
              h3(classes: 'text-2xl font-bold text-white mb-2', [Component.text('Silence sounds better with lofi')]),
              p(classes: 'text-white/40 max-w-sm mx-auto', [Component.text('Start your session by searching for a track or discovery.')]),
            ]),
          ])
        else
          div(
            classes: 'grid grid-cols-1 lg:grid-cols-12 gap-8 items-start',
            [
              // Main Player View
              div(classes: 'lg:col-span-7 bg-white/5 backdrop-blur-3xl rounded-[3.5rem] p-8 md:p-12 border border-white/10 shadow-2xl relative overflow-hidden group', [
                // Top Action Bar
                div(classes: 'flex justify-between items-center mb-12', [
                  button(
                    events: {'click': (e) => component.onToggleFavorite(currentTrack)},
                    classes: 'p-4 rounded-3xl transition-all ${isFavorite ? 'bg-red-500/10 text-red-500 border border-red-500/20 shadow-lg shadow-red-500/10' : 'bg-white/5 text-white/30 hover:text-white border border-white/5'}',
                    [
                      Heart(width: const Unit.pixels(24), height: const Unit.pixels(24), attributes: {'fill': isFavorite ? 'currentColor' : 'none'}),
                    ],
                  ),
                  const div(classes: 'flex items-center gap-2 bg-white/5 px-4 py-2 rounded-2xl border border-white/5', [
                    div(classes: 'w-2 h-2 bg-green-500 rounded-full animate-pulse', []),
                    span(classes: 'text-[10px] font-black text-white/40 tracking-widest uppercase', [Component.text('Streaming HD')]),
                  ]),
                ]),

                div(classes: 'flex flex-col items-center text-center', [
                  // Artwork
                  div(classes: 'relative mb-12 group/art', [
                    div(
                      classes: 'absolute -inset-4 bg-gradient-to-tr from-purple-500/20 to-pink-500/20 blur-3xl rounded-full opacity-0 group-hover/art:opacity-100 transition-opacity duration-1000 ${component.isPlaying ? 'opacity-100 animate-pulse' : ''}',
                      const [],
                    ),
                    div(
                      classes: 'relative w-64 h-64 md:w-80 md:h-80 rounded-[3rem] overflow-hidden border-4 border-white/10 shadow-2xl transition-transform duration-700 group-hover/art:scale-105',
                      [
                        img(
                          src: 'https://img.youtube.com/vi/${currentTrack.youtubeId}/maxresdefault.jpg',
                          alt: currentTrack.title,
                          classes: 'w-full h-full object-cover grayscale-[0.2] hover:grayscale-0 transition-all duration-700',
                          events: {
                            'error': (dynamic e) {
                              final el = e.target as web.HTMLImageElement;
                              el.src = 'https://img.youtube.com/vi/${currentTrack.youtubeId}/hqdefault.jpg';
                            },
                          },
                        ),
                        if (component.isPlaying)
                          div(classes: 'absolute inset-0 flex items-center justify-center bg-black/20 backdrop-blur-[2px]', [
                            div(classes: 'flex gap-1.5 items-end h-10', [
                              for (var i = 0; i < 4; i++)
                                div(
                                  classes: 'w-1.5 bg-white rounded-full animate-music-bar',
                                  styles: Styles(raw: {'animation-delay': '${i * 0.2}s'}),
                                  const [],
                                ),
                            ]),
                          ]),
                      ],
                    ),
                  ]),

                  // Track Info
                  div(classes: 'mb-12 w-full', [
                    h2(classes: 'text-3xl md:text-5xl font-black text-white mb-3 tracking-tight leading-tight line-clamp-2 px-4', [Component.text(currentTrack.title)]),
                    p(classes: 'text-lg md:text-xl text-purple-300/60 font-medium', [Component.text(currentTrack.artist)]),
                  ]),

                  // Progress
                  div(classes: 'w-full mb-12 px-4', [
                    div(
                      classes: 'relative h-2 w-full bg-white/5 rounded-full cursor-pointer group/progress mb-4 overflow-hidden',
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
                        div(
                          classes: 'absolute h-full bg-white rounded-full transition-all group-hover/progress:bg-purple-400',
                          styles: Styles(raw: {'width': '$progressPercentage%'}),
                          const [],
                        ),
                      ],
                    ),
                    div(classes: 'flex justify-between text-[11px] font-black tracking-widest text-white/30 uppercase font-mono', [
                      span([Component.text(_formatTime(component.currentTime))]),
                      if (!isLiveStream) span([Component.text(_formatTime(component.duration))]),
                    ]),
                  ]),

                  // Controls
                  div(classes: 'flex items-center gap-8 md:gap-12', [
                    button(
                      events: {'click': (e) => component.onPrevious()},
                      classes: 'text-white/40 hover:text-white transition-all hover:scale-125 active:scale-90',
                      [SkipBack(width: const Unit.pixels(32), height: const Unit.pixels(32))],
                    ),
                    button(
                      events: {'click': (e) => component.isPlaying ? component.onPause() : component.onPlay()},
                      classes: 'w-24 h-24 md:w-28 md:h-28 flex items-center justify-center bg-white text-black rounded-full hover:scale-105 active:scale-95 transition-all shadow-2xl shadow-white/10 group/play',
                      [
                        component.isPlaying
                            ? Pause(width: const Unit.pixels(40), height: const Unit.pixels(40), attributes: const {'fill': 'black'})
                            : Play(width: const Unit.pixels(40), height: const Unit.pixels(40), attributes: const {'fill': 'black', 'class': 'ml-1'}),
                      ],
                    ),
                    button(
                      events: {'click': (e) => component.onNext()},
                      classes: 'text-white/40 hover:text-white transition-all hover:scale-125 active:scale-90',
                      [SkipForward(width: const Unit.pixels(32), height: const Unit.pixels(32))],
                    ),
                  ]),
                ]),
              ]),

              // Right Sidebar: Tabs & List
              div(classes: 'lg:col-span-5 flex flex-col gap-6 h-full', [
                div(classes: 'bg-white/5 backdrop-blur-2xl rounded-[3rem] border border-white/10 flex flex-col min-h-[600px] overflow-hidden shadow-2xl', [
                  // Tabs Header
                  div(classes: 'flex border-b border-white/10 p-2', [
                    button(
                      events: {'click': (e) => setState(() => _activeTab = 0)},
                      classes: 'flex-1 py-4 text-xs font-black tracking-widest uppercase transition-all rounded-[2rem] ${_activeTab == 0 ? 'bg-white/10 text-white' : 'text-white/30 hover:text-white/50'}',
                      const [Component.text('Discovery')],
                    ),
                    button(
                      events: {'click': (e) => setState(() => _activeTab = 1)},
                      classes: 'flex-1 py-4 text-xs font-black tracking-widest uppercase transition-all rounded-[2rem] ${_activeTab == 1 ? 'bg-white/10 text-white' : 'text-white/30 hover:text-white/50'}',
                      const [Component.text('Library')],
                    ),
                  ]),

                  // Tab Content
                  div(classes: 'flex-1 overflow-y-auto p-4 custom-scrollbar space-y-2', [
                    if (_activeTab == 0)
                      for (var i = 0; i < component.playlist.length; i++) _buildTrackItem(i, component.playlist[i], i == component.currentTrackIndex, false)
                    else if (component.favorites.isEmpty)
                      div(classes: 'flex flex-col items-center justify-center py-20 text-center opacity-30 px-8', [
                        Heart(width: const Unit.pixels(40), height: const Unit.pixels(40), classes: 'mb-4'),
                        const p(classes: 'text-sm font-medium', [Component.text('Your library is empty. Heart a track to save it.')]),
                      ])
                    else
                      for (var i = 0; i < component.favorites.length; i++) _buildTrackItem(i, component.favorites[i], currentTrack.youtubeId == component.favorites[i].youtubeId, true),
                  ]),

                  // Bottom Volume/AutoPlay Bar
                  div(classes: 'p-6 bg-white/[0.02] border-t border-white/10 space-y-6', [
                    div(classes: 'flex items-center gap-4', [
                      Volume2(width: const Unit.pixels(18), height: const Unit.pixels(18), classes: 'text-white/20'),
                      input(
                        type: InputType.range,
                        attributes: {'min': '0', 'max': '100', 'value': '${(component.volume * 100).toInt()}'},
                        classes: 'flex-1 h-1 bg-white/10 rounded-full appearance-none cursor-pointer accent-white',
                        onInput: (val) => component.onVolumeChange((double.tryParse(val.toString()) ?? 100) / 100),
                      ),
                    ]),
                    div(classes: 'flex items-center justify-between', [
                      div(classes: 'flex items-center gap-3', [
                        button(
                          events: {'click': (e) => component.onToggleAutoPlay()},
                          classes: 'flex items-center gap-2 px-5 py-2.5 rounded-2xl text-[10px] font-black tracking-[0.2em] transition-all ${component.autoPlay ? 'bg-purple-500 text-white' : 'bg-white/5 text-white/30 border border-white/5'}',
                          const [
                            Component.text('AUTOPLAY'),
                          ],
                        ),
                      ]),
                      const span(classes: 'text-[10px] font-black text-white/10 tracking-widest', [Component.text('LOFIME V0.22')]),
                    ]),
                  ]),
                ]),
              ]),
            ],
          ),
      ],
    );
  }

  Component _buildTrackItem(int index, YouTubeTrack track, bool isActive, bool isFromFavorites) {
    return div(
      key: ValueKey('track-${isFromFavorites ? 'fav-' : ''}$index'),
      events: {'click': (e) => isFromFavorites ? component.onPlayFavorite(index) : null}, // If not favorites, it's already in main playlist, but we need a way to play it if clicked.
      classes: 'group flex items-center gap-4 p-4 rounded-[2rem] transition-all cursor-pointer ${isActive ? 'bg-white/10 shadow-lg' : 'hover:bg-white/[0.03]'}',
      [
        // Small Artwork
        div(classes: 'relative w-14 h-14 rounded-2xl overflow-hidden flex-shrink-0 border border-white/10', [
          img(src: 'https://img.youtube.com/vi/${track.youtubeId}/default.jpg', classes: 'w-full h-full object-cover transition-transform group-hover:scale-110'),
          if (isActive && component.isPlaying)
            div(classes: 'absolute inset-0 bg-black/40 flex items-center justify-center', [
              div(classes: 'flex gap-0.5 items-end h-4', [
                for (var j = 0; j < 3; j++)
                  div(
                    classes: 'w-1 bg-white rounded-full animate-music-bar-small',
                    styles: Styles(raw: {'animation-delay': '${j * 0.1}s'}),
                    const [],
                  ),
              ]),
            ]),
        ]),

        // Track Info
        div(classes: 'flex-1 min-w-0', [
          p(classes: 'text-sm font-bold text-white truncate group-hover:text-purple-300 transition-colors', [Component.text(track.title)]),
          p(classes: 'text-[11px] text-white/30 truncate font-medium uppercase tracking-wider', [Component.text(track.artist)]),
        ]),

        // Play Button / Indicator
        if (isActive) const div(classes: 'w-2 h-2 bg-white rounded-full', []) else span(classes: 'text-[10px] font-mono text-white/10 group-hover:text-white/30', [Component.text(_formatTime(track.duration ?? 0))]),
      ],
    );
  }

  String _formatTime(double time) {
    final minutes = (time ~/ 60);
    final seconds = (time % 60).toInt().toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
