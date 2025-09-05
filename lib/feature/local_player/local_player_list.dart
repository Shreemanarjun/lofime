import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' hide Component, List, File;
import 'package:lofime/data/local_player_model.dart';
import 'package:universal_web/web.dart';

class LocalPlayList extends StatefulComponent {
  final List<Track> playlist;
  final int currentTrackIndex;
  final void Function(int index) onTrackSelect;
  final void Function(Track track) onAddTrack;
  final void Function(int index) onRemoveTrack;
  final void Function() onSavePlaylist;
  final void Function(File file) onLoadPlaylist;

  const LocalPlayList({
    super.key,
    required this.playlist,
    required this.currentTrackIndex,
    required this.onTrackSelect,
    required this.onAddTrack,
    required this.onRemoveTrack,
    required this.onSavePlaylist,
    required this.onLoadPlaylist,
  });

  @override
  State<LocalPlayList> createState() => _PlaylistWidgetState();
}

class _PlaylistWidgetState extends State<LocalPlayList> {
  bool isAddingTrack = false;
  String title = '';
  String artist = '';
  String url = '';

  void handleAddTrack() {
    if (title.isNotEmpty && artist.isNotEmpty && url.isNotEmpty) {
      component.onAddTrack(LocalTrack(title: title, artist: artist, url: url));
      setState(() {
        title = '';
        artist = '';
        url = '';
        isAddingTrack = false;
      });
    }
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'bg-black/20 backdrop-blur-md rounded-2xl p-6 border border-purple-300/30 shadow-2xl', [
      // Header
      div(classes: 'flex items-center justify-between mb-6', [
        h3(classes: 'text-xl font-bold text-white flex items-center', [
          Music(
            classes: 'mr-2',
          ),
          text('Playlist (${component.playlist.length})'),
        ]),
        div(classes: 'flex space-x-2', [
          button(
            classes: 'p-2 rounded-lg bg-purple-600/30 border border-purple-400/50 hover:bg-purple-500/40 transition-all duration-300 text-purple-200',
            events: {'click': (_) => setState(() => isAddingTrack = !isAddingTrack)},
            [Plus(height: 18.px, width: 18.px)],
          ),
          button(
            classes: 'p-2 rounded-lg bg-green-600/30 border border-green-400/50 hover:bg-green-500/40 transition-all duration-300 text-green-200',
            events: {'click': (_) => component.onSavePlaylist()},
            [
              Save(
                height: 18.px,
                width: 18.px,
              )
            ],
          ),
          label(
            classes: 'p-2 rounded-lg bg-blue-600/30 border border-blue-400/50 hover:bg-blue-500/40 transition-all duration-300 text-blue-200 cursor-pointer',
            [
              Download(
                height: 18.px,
                width: 18.px,
              ),
              input(
                type: InputType.file,
                classes: 'hidden',
                attributes: {'accept': '.json'},
                onChange: (value) {
                  final files = value;
                  if (files != null && files.isNotEmpty) {
                    component.onLoadPlaylist(files.first);
                  }
                },
              )
            ],
          ),
        ]),
      ]),

      // Add Track Form
      if (isAddingTrack)
        div(classes: 'mb-6 p-4 bg-purple-900/30 rounded-xl border border-purple-400/30', [
          h4(classes: 'text-white font-semibold mb-3', [text('Add New Track')]),
          div(classes: 'space-y-3', [
            input(
              type: InputType.text,
              value: title,
              attributes: {
                "placeholder": 'Track Title',
              },
              classes: 'w-full px-3 py-2 bg-black/30 border border-purple-400/50 rounded-lg text-white placeholder-purple-300 focus:border-purple-300 focus:outline-none',
              onInput: (value) {
                setState(() => title = (value ?? ''));
              },
            ),
            input(
              type: InputType.text,
              value: artist,
              attributes: {
                "placeholder": 'Artist Name',
              },
              classes: 'w-full px-3 py-2 bg-black/30 border border-purple-400/50 rounded-lg text-white placeholder-purple-300 focus:border-purple-300 focus:outline-none',
              onInput: (value) {
                setState(() => artist = (value ?? ''));
              },
            ),
            input(
              type: InputType.url,
              value: url,
              attributes: {
                "placeholder": 'Music URL',
              },
              classes: 'w-full px-3 py-2 bg-black/30 border border-purple-400/50 rounded-lg text-white placeholder-purple-300 focus:border-purple-300 focus:outline-none',
              onInput: (value) {
                setState(() => url = (value ?? ''));
              },
            ),
            div(classes: 'flex space-x-2', [
              button(
                classes: 'px-4 py-2 bg-gradient-to-r from-purple-500 to-pink-500 rounded-lg text-white hover:from-purple-400 hover:to-pink-400 transition-all duration-300',
                events: {'click': (_) => handleAddTrack()},
                [text('Add Track')],
              ),
              button(
                classes: 'px-4 py-2 bg-gray-600/50 rounded-lg text-white hover:bg-gray-500/60 transition-all duration-300',
                events: {'click': (_) => setState(() => isAddingTrack = false)},
                [text('Cancel')],
              ),
            ]),
          ]),
        ]),

      // Track List
      div(classes: 'max-h-96 overflow-y-auto custom-scrollbar', [
        if (component.playlist.isEmpty)
          div(classes: 'text-center py-8 text-purple-200', [
            Music(height: 48.px, width: 48.px, classes: 'mx-auto mb-4 opacity-50'),
            p([text('No tracks in playlist')]),
            p(classes: 'text-sm opacity-70', [text('Add some tracks to get started')]),
            p(classes: 'text-xs opacity-50 mt-2', [text('Playlists are automatically saved in your browser')]),
          ])
        else
          div(classes: 'space-y-2', [
            for (var i = 0; i < component.playlist.length; i++)
              div(
                classes:
                    'p-3 rounded-xl border transition-all duration-300 cursor-pointer group ${i == component.currentTrackIndex ? 'bg-gradient-to-r from-purple-600/40 to-pink-600/40 border-purple-300/60' : 'bg-purple-900/20 border-purple-400/30 hover:bg-purple-800/30 hover:border-purple-300/50'}',
                events: {'click': (_) => component.onTrackSelect(i)},
                [
                  div(classes: 'flex items-center justify-between', [
                    div(classes: 'flex items-center space-x-3', [
                      div(
                        classes: 'w-8 h-8 rounded-lg bg-gradient-to-br from-purple-500/50 to-pink-500/50 flex items-center justify-center',
                        [
                          if (i == component.currentTrackIndex) Play(height: 14.px, classes: 'text-white') else span(classes: 'text-white text-sm font-bold', [text('${i + 1}')]),
                        ],
                      ),
                      div([
                        h4(classes: 'text-white font-medium', [text(component.playlist[i].title)]),
                        p(classes: 'text-purple-200 text-sm', [text(component.playlist[i].artist)]),
                      ]),
                    ]),
                    button(
                      classes: 'opacity-0 group-hover:opacity-100 p-1 rounded text-red-300 hover:text-red-200 transition-all duration-300',
                      events: {
                        'click': (e) {
                          e.stopPropagation();
                          component.onRemoveTrack(i);
                        }
                      },
                      [
                        Trash2(
                          height: 16.px,
                          width: 16.px,
                        )
                      ],
                    ),
                  ]),
                ],
              ),
          ]),
      ]),

      div(classes: 'mt-4 text-center text-xs text-purple-300/70', [
        p([text('💾 Playlist automatically saved to browser storage')]),
      ]),
    ]);
  }
}
