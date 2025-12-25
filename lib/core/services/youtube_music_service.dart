import 'dart:convert';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:lofime/core/models/player_models.dart';
import 'package:talker/talker.dart';
import 'package:http/http.dart' as http;

class YouTubeMusicService {
  final _talker = Talker();

  // Using a list of public Invidious instances that support CORS
  static const _invidiousInstances = [
    'https://inv.tux.rs',
    'https://invidious.projectsegfau.lt',
    'https://invidious.privacydev.net',
    'https://inv.vern.cc',
  ];

  Future<List<YouTubeTrack>> searchLofi(String query) async {
    _talker.info('Searching for lofi: $query via Invidious API');
    final fullQuery = query.toLowerCase().contains('lofi') ? query : '$query lofi';

    // Attempt multiple instances in case one is down
    for (final instance in _invidiousInstances) {
      try {
        final url = Uri.parse('$instance/api/v1/search?q=${Uri.encodeComponent(fullQuery)}&type=video');
        _talker.info('Requesting: $url');

        final response = await http.get(url).timeout(const Duration(seconds: 5));

        if (response.statusCode == 200) {
          final List<dynamic> data = jsonDecode(response.body);
          final tracks = data
              .map((json) {
                return YouTubeTrack(
                  title: json['title'] as String,
                  artist: json['author'] as String,
                  url: 'https://www.youtube.com/watch?v=${json['videoId']}',
                  youtubeId: json['videoId'] as String,
                  duration: (json['lengthSeconds'] as num?)?.toDouble() ?? 0,
                );
              })
              .take(15)
              .toList();

          _talker.info('Found ${tracks.length} tracks from $instance');
          return tracks;
        }
      } catch (e) {
        _talker.warning('Failed to search via $instance: $e');
        continue;
      }
    }

    _talker.error('All Invidious instances failed for search.');
    return [];
  }

  Future<List<YouTubeTrack>> discoverLofi() async {
    const genres = [
      'Hindi Lofi 2024',
      'Bollywood Lofi Chill',
      'Indian Lofi Hip Hop',
      'Late Night Hindi Lofi',
      '90s Bollywood Lofi',
      'Arijit Singh Lofi',
      'Coke Studio Lofi',
    ];
    final randomGenre = (List<String>.from(genres)..shuffle()).first;
    return searchLofi(randomGenre);
  }
}

final youtubeMusicServiceProvider = Provider((ref) => YouTubeMusicService());
