import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:lofime/components/tab_nav.dart';
import 'package:lofime/data/local_player.dart';
import 'package:lofime/feature/animated_bg.dart';
import 'package:lofime/feature/header.dart';

import 'package:lofime/feature/local_player/controller/local_player_notifier.dart';
import 'package:lofime/feature/local_player/local_player_list.dart';
import 'package:lofime/feature/yt_player/controller/yt_player_controller.dart';
import 'package:lofime/feature/yt_player/yt_player.dart';
import 'package:lofime/feature/yt_player/yt_playlist.dart';

enum Tab { youtube, local }

final currentTabProvider = StateProvider<Tab>(
  (ref) {
    return Tab.youtube;
  },
  name: 'currentTabProvider',
);

class Home extends StatefulComponent {
  const Home({super.key});

  @override
  State createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Component build(BuildContext context) {
    return section(
      [
        const AnimatedBackground(),
        div(classes: "relative z-10", [
          const Header(),
          Builder(
            builder: (context) {
              final currentTabState = context.watch(currentTabProvider);
              return TabNavigation(
                activeTab: currentTabState,
                onTabChange: (tab) {
                  context.read(currentTabProvider.notifier).state = tab;
                },
              );
            },
          ),
          const PlayerComponent(),
        ]),
      ],
    );
  }
}

class PlayerComponent extends StatelessComponent {
  const PlayerComponent();

  @override
  Component build(BuildContext context) {
    return main_(
      classes: "container mx-auto px-4 py-8",
      [
        div(
          classes: "flex justify-center items-start min-h-screen",
          [
            Builder(
              builder: (context) {
                final currentTabState = context.watch(currentTabProvider);
                final currentYtPlayState = context.watch(youTubePlayerProvider);
                return switch (currentTabState) {
                  Tab.youtube => div(
                      classes: "w-full max-w-6xl",
                      [
                        div(
                          classes: "grid grid-cols-1 lg:grid-cols-2 gap-8 items-start",
                          [
                            // Player column
                            div(
                              classes: "flex justify-center",
                              [
                                YouTubePlayer(
                                  playlist: currentYtPlayState.playlist,
                                  currentTrackIndex: currentYtPlayState.currentTrackIndex,
                                  isPlaying: currentYtPlayState.isPlaying,
                                  volume: currentYtPlayState.volume,
                                  onNext: () => context.read(youTubePlayerProvider.notifier).next(),
                                  onPrevious: () => context.read(youTubePlayerProvider.notifier).previous(),
                                  onVolumeChange: (volume) => context.read(youTubePlayerProvider.notifier).setVolume(volume),
                                  onPlay: () => context.read(youTubePlayerProvider.notifier).play(),
                                  onPause: () => context.read(youTubePlayerProvider.notifier).pause(),
                                  autoPlay: currentYtPlayState.autoPlay,
                                  onToggleAutoPlay: () => context.read(youTubePlayerProvider.notifier).toggleAutoPlay(),
                                  currentTime: currentYtPlayState.currentTime,
                                  duration: currentYtPlayState.duration,
                                  onSeek: (time) => context.read(youTubePlayerProvider.notifier).seek(time),
                                ),
                              ],
                            ),
                            // Playlist column
                            div(
                              classes: "flex justify-center",
                              [
                                YouTubePlaylist(
                                  playlist: currentYtPlayState.playlist,
                                  currentTrackIndex: currentYtPlayState.currentTrackIndex,
                                  onTrackSelect: (index) => context.read(youTubePlayerProvider.notifier).selectTrack(index),
                                  autoPlay: currentYtPlayState.autoPlay,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  Tab.local => Builder(builder: (context) {
                      final musicPlayerState = context.watch(musicPlayerProvider);
                      return div(
                        classes: "w-full max-w-6xl",
                        [
                          div(
                            classes: "grid grid-cols-1 lg:grid-cols-2 gap-8 items-start",
                            [
                              // Player column
                              div(
                                classes: "flex justify-center",
                                [
                                  MusicPlayer(
                                    playlist: musicPlayerState.playlist,
                                    currentTrack: musicPlayerState.currentTrack,
                                    currentTrackIndex: musicPlayerState.currentTrackIndex,
                                    isPlaying: musicPlayerState.isPlaying,
                                    volume: musicPlayerState.volume,
                                    currentTime: musicPlayerState.currentTime,
                                    duration: musicPlayerState.duration,
                                    onPlay: () => context.read(musicPlayerProvider.notifier).play(),
                                    onPause: () => context.read(musicPlayerProvider.notifier).pause(),
                                    onNext: () => context.read(musicPlayerProvider.notifier).next(),
                                    onPrevious: () => context.read(musicPlayerProvider.notifier).previous(),
                                    onVolumeChange: (volume) => context.read(musicPlayerProvider.notifier).setVolume(volume),
                                    onSeek: (time) => context.read(musicPlayerProvider.notifier).seek(time),
                                  ),
                                ],
                              ),
                              // Playlist column
                              div(
                                classes: "flex justify-center",
                                [
                                  LocalPlayList(
                                    playlist: musicPlayerState.playlist,
                                    currentTrackIndex: musicPlayerState.currentTrackIndex,
                                    onTrackSelect: (index) => context.read(musicPlayerProvider.notifier).selectTrack(index),
                                    onAddTrack: (track) => context.read(musicPlayerProvider.notifier).addTrack(track),
                                    onRemoveTrack: (index) => context.read(musicPlayerProvider.notifier).removeTrack(index),
                                    onSavePlaylist: () => context.read(musicPlayerProvider.notifier).savePlaylist(),
                                    onLoadPlaylist: (file) => context.read(musicPlayerProvider.notifier).loadPlaylist(file),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                };
              },
            ),
          ],
        ),
      ],
    );
  }
}
