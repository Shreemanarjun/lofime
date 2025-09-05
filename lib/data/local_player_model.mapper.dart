// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_player_model.dart';

class TrackMapper extends ClassMapperBase<Track> {
  TrackMapper._();

  static TrackMapper? _instance;
  static TrackMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TrackMapper._());
      LocalTrackMapper.ensureInitialized();
      YouTubeTrackMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Track';

  static String _$title(Track v) => v.title;
  static const Field<Track, String> _f$title = Field('title', _$title);
  static String _$artist(Track v) => v.artist;
  static const Field<Track, String> _f$artist = Field('artist', _$artist);
  static String _$url(Track v) => v.url;
  static const Field<Track, String> _f$url = Field('url', _$url);
  static double? _$duration(Track v) => v.duration;
  static const Field<Track, double> _f$duration = Field(
    'duration',
    _$duration,
    opt: true,
  );

  @override
  final MappableFields<Track> fields = const {
    #title: _f$title,
    #artist: _f$artist,
    #url: _f$url,
    #duration: _f$duration,
  };

  static Track _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('Track');
  }

  @override
  final Function instantiate = _instantiate;

  static Track fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Track>(map);
  }

  static Track fromJson(String json) {
    return ensureInitialized().decodeJson<Track>(json);
  }
}

mixin TrackMappable {
  String toJson();
  Map<String, dynamic> toMap();
  TrackCopyWith<Track, Track, Track> get copyWith;
}

abstract class TrackCopyWith<$R, $In extends Track, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, String? artist, String? url, double? duration});
  TrackCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class LocalTrackMapper extends ClassMapperBase<LocalTrack> {
  LocalTrackMapper._();

  static LocalTrackMapper? _instance;
  static LocalTrackMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalTrackMapper._());
      TrackMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LocalTrack';

  static String _$title(LocalTrack v) => v.title;
  static const Field<LocalTrack, String> _f$title = Field('title', _$title);
  static String _$artist(LocalTrack v) => v.artist;
  static const Field<LocalTrack, String> _f$artist = Field('artist', _$artist);
  static String _$url(LocalTrack v) => v.url;
  static const Field<LocalTrack, String> _f$url = Field('url', _$url);
  static double? _$duration(LocalTrack v) => v.duration;
  static const Field<LocalTrack, double> _f$duration = Field(
    'duration',
    _$duration,
    opt: true,
  );

  @override
  final MappableFields<LocalTrack> fields = const {
    #title: _f$title,
    #artist: _f$artist,
    #url: _f$url,
    #duration: _f$duration,
  };

  static LocalTrack _instantiate(DecodingData data) {
    return LocalTrack(
      title: data.dec(_f$title),
      artist: data.dec(_f$artist),
      url: data.dec(_f$url),
      duration: data.dec(_f$duration),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalTrack fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalTrack>(map);
  }

  static LocalTrack fromJson(String json) {
    return ensureInitialized().decodeJson<LocalTrack>(json);
  }
}

mixin LocalTrackMappable {
  String toJson() {
    return LocalTrackMapper.ensureInitialized().encodeJson<LocalTrack>(
      this as LocalTrack,
    );
  }

  Map<String, dynamic> toMap() {
    return LocalTrackMapper.ensureInitialized().encodeMap<LocalTrack>(
      this as LocalTrack,
    );
  }

  LocalTrackCopyWith<LocalTrack, LocalTrack, LocalTrack> get copyWith =>
      _LocalTrackCopyWithImpl<LocalTrack, LocalTrack>(
        this as LocalTrack,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LocalTrackMapper.ensureInitialized().stringifyValue(
      this as LocalTrack,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalTrackMapper.ensureInitialized().equalsValue(
      this as LocalTrack,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalTrackMapper.ensureInitialized().hashValue(this as LocalTrack);
  }
}

extension LocalTrackValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalTrack, $Out> {
  LocalTrackCopyWith<$R, LocalTrack, $Out> get $asLocalTrack =>
      $base.as((v, t, t2) => _LocalTrackCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LocalTrackCopyWith<$R, $In extends LocalTrack, $Out>
    implements TrackCopyWith<$R, $In, $Out> {
  @override
  $R call({String? title, String? artist, String? url, double? duration});
  LocalTrackCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LocalTrackCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalTrack, $Out>
    implements LocalTrackCopyWith<$R, LocalTrack, $Out> {
  _LocalTrackCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalTrack> $mapper =
      LocalTrackMapper.ensureInitialized();
  @override
  $R call({
    String? title,
    String? artist,
    String? url,
    Object? duration = $none,
  }) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (artist != null) #artist: artist,
      if (url != null) #url: url,
      if (duration != $none) #duration: duration,
    }),
  );
  @override
  LocalTrack $make(CopyWithData data) => LocalTrack(
    title: data.get(#title, or: $value.title),
    artist: data.get(#artist, or: $value.artist),
    url: data.get(#url, or: $value.url),
    duration: data.get(#duration, or: $value.duration),
  );

  @override
  LocalTrackCopyWith<$R2, LocalTrack, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LocalTrackCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class YouTubeTrackMapper extends ClassMapperBase<YouTubeTrack> {
  YouTubeTrackMapper._();

  static YouTubeTrackMapper? _instance;
  static YouTubeTrackMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = YouTubeTrackMapper._());
      TrackMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'YouTubeTrack';

  static String _$title(YouTubeTrack v) => v.title;
  static const Field<YouTubeTrack, String> _f$title = Field('title', _$title);
  static String _$artist(YouTubeTrack v) => v.artist;
  static const Field<YouTubeTrack, String> _f$artist = Field(
    'artist',
    _$artist,
  );
  static String _$url(YouTubeTrack v) => v.url;
  static const Field<YouTubeTrack, String> _f$url = Field('url', _$url);
  static double? _$duration(YouTubeTrack v) => v.duration;
  static const Field<YouTubeTrack, double> _f$duration = Field(
    'duration',
    _$duration,
    opt: true,
  );
  static String _$youtubeId(YouTubeTrack v) => v.youtubeId;
  static const Field<YouTubeTrack, String> _f$youtubeId = Field(
    'youtubeId',
    _$youtubeId,
  );

  @override
  final MappableFields<YouTubeTrack> fields = const {
    #title: _f$title,
    #artist: _f$artist,
    #url: _f$url,
    #duration: _f$duration,
    #youtubeId: _f$youtubeId,
  };

  static YouTubeTrack _instantiate(DecodingData data) {
    return YouTubeTrack(
      title: data.dec(_f$title),
      artist: data.dec(_f$artist),
      url: data.dec(_f$url),
      duration: data.dec(_f$duration),
      youtubeId: data.dec(_f$youtubeId),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static YouTubeTrack fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<YouTubeTrack>(map);
  }

  static YouTubeTrack fromJson(String json) {
    return ensureInitialized().decodeJson<YouTubeTrack>(json);
  }
}

mixin YouTubeTrackMappable {
  String toJson() {
    return YouTubeTrackMapper.ensureInitialized().encodeJson<YouTubeTrack>(
      this as YouTubeTrack,
    );
  }

  Map<String, dynamic> toMap() {
    return YouTubeTrackMapper.ensureInitialized().encodeMap<YouTubeTrack>(
      this as YouTubeTrack,
    );
  }

  YouTubeTrackCopyWith<YouTubeTrack, YouTubeTrack, YouTubeTrack> get copyWith =>
      _YouTubeTrackCopyWithImpl<YouTubeTrack, YouTubeTrack>(
        this as YouTubeTrack,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return YouTubeTrackMapper.ensureInitialized().stringifyValue(
      this as YouTubeTrack,
    );
  }

  @override
  bool operator ==(Object other) {
    return YouTubeTrackMapper.ensureInitialized().equalsValue(
      this as YouTubeTrack,
      other,
    );
  }

  @override
  int get hashCode {
    return YouTubeTrackMapper.ensureInitialized().hashValue(
      this as YouTubeTrack,
    );
  }
}

extension YouTubeTrackValueCopy<$R, $Out>
    on ObjectCopyWith<$R, YouTubeTrack, $Out> {
  YouTubeTrackCopyWith<$R, YouTubeTrack, $Out> get $asYouTubeTrack =>
      $base.as((v, t, t2) => _YouTubeTrackCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class YouTubeTrackCopyWith<$R, $In extends YouTubeTrack, $Out>
    implements TrackCopyWith<$R, $In, $Out> {
  @override
  $R call({
    String? title,
    String? artist,
    String? url,
    double? duration,
    String? youtubeId,
  });
  YouTubeTrackCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _YouTubeTrackCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, YouTubeTrack, $Out>
    implements YouTubeTrackCopyWith<$R, YouTubeTrack, $Out> {
  _YouTubeTrackCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<YouTubeTrack> $mapper =
      YouTubeTrackMapper.ensureInitialized();
  @override
  $R call({
    String? title,
    String? artist,
    String? url,
    Object? duration = $none,
    String? youtubeId,
  }) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (artist != null) #artist: artist,
      if (url != null) #url: url,
      if (duration != $none) #duration: duration,
      if (youtubeId != null) #youtubeId: youtubeId,
    }),
  );
  @override
  YouTubeTrack $make(CopyWithData data) => YouTubeTrack(
    title: data.get(#title, or: $value.title),
    artist: data.get(#artist, or: $value.artist),
    url: data.get(#url, or: $value.url),
    duration: data.get(#duration, or: $value.duration),
    youtubeId: data.get(#youtubeId, or: $value.youtubeId),
  );

  @override
  YouTubeTrackCopyWith<$R2, YouTubeTrack, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _YouTubeTrackCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PlaylistMapper extends ClassMapperBase<Playlist> {
  PlaylistMapper._();

  static PlaylistMapper? _instance;
  static PlaylistMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlaylistMapper._());
      LocalPlaylistMapper.ensureInitialized();
      YouTubePlaylistMapper.ensureInitialized();
      TrackMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Playlist';

  static String _$name(Playlist v) => v.name;
  static const Field<Playlist, String> _f$name = Field('name', _$name);
  static List<Track> _$tracks(Playlist v) => v.tracks;
  static const Field<Playlist, List<Track>> _f$tracks = Field(
    'tracks',
    _$tracks,
  );
  static DateTime _$createdAt(Playlist v) => v.createdAt;
  static const Field<Playlist, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<Playlist> fields = const {
    #name: _f$name,
    #tracks: _f$tracks,
    #createdAt: _f$createdAt,
  };

  static Playlist _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('Playlist');
  }

  @override
  final Function instantiate = _instantiate;

  static Playlist fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Playlist>(map);
  }

  static Playlist fromJson(String json) {
    return ensureInitialized().decodeJson<Playlist>(json);
  }
}

mixin PlaylistMappable {
  String toJson();
  Map<String, dynamic> toMap();
  PlaylistCopyWith<Playlist, Playlist, Playlist> get copyWith;
}

abstract class PlaylistCopyWith<$R, $In extends Playlist, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Track, TrackCopyWith<$R, Track, Track>> get tracks;
  $R call({String? name, List<Track>? tracks, DateTime? createdAt});
  PlaylistCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class LocalPlaylistMapper extends ClassMapperBase<LocalPlaylist> {
  LocalPlaylistMapper._();

  static LocalPlaylistMapper? _instance;
  static LocalPlaylistMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalPlaylistMapper._());
      PlaylistMapper.ensureInitialized();
      TrackMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LocalPlaylist';

  static String _$name(LocalPlaylist v) => v.name;
  static const Field<LocalPlaylist, String> _f$name = Field('name', _$name);
  static List<Track> _$tracks(LocalPlaylist v) => v.tracks;
  static const Field<LocalPlaylist, List<Track>> _f$tracks = Field(
    'tracks',
    _$tracks,
  );
  static DateTime _$createdAt(LocalPlaylist v) => v.createdAt;
  static const Field<LocalPlaylist, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<LocalPlaylist> fields = const {
    #name: _f$name,
    #tracks: _f$tracks,
    #createdAt: _f$createdAt,
  };

  static LocalPlaylist _instantiate(DecodingData data) {
    return LocalPlaylist(
      name: data.dec(_f$name),
      tracks: data.dec(_f$tracks),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalPlaylist fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalPlaylist>(map);
  }

  static LocalPlaylist fromJson(String json) {
    return ensureInitialized().decodeJson<LocalPlaylist>(json);
  }
}

mixin LocalPlaylistMappable {
  String toJson() {
    return LocalPlaylistMapper.ensureInitialized().encodeJson<LocalPlaylist>(
      this as LocalPlaylist,
    );
  }

  Map<String, dynamic> toMap() {
    return LocalPlaylistMapper.ensureInitialized().encodeMap<LocalPlaylist>(
      this as LocalPlaylist,
    );
  }

  LocalPlaylistCopyWith<LocalPlaylist, LocalPlaylist, LocalPlaylist>
  get copyWith => _LocalPlaylistCopyWithImpl<LocalPlaylist, LocalPlaylist>(
    this as LocalPlaylist,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return LocalPlaylistMapper.ensureInitialized().stringifyValue(
      this as LocalPlaylist,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalPlaylistMapper.ensureInitialized().equalsValue(
      this as LocalPlaylist,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalPlaylistMapper.ensureInitialized().hashValue(
      this as LocalPlaylist,
    );
  }
}

extension LocalPlaylistValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalPlaylist, $Out> {
  LocalPlaylistCopyWith<$R, LocalPlaylist, $Out> get $asLocalPlaylist =>
      $base.as((v, t, t2) => _LocalPlaylistCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LocalPlaylistCopyWith<$R, $In extends LocalPlaylist, $Out>
    implements PlaylistCopyWith<$R, $In, $Out> {
  @override
  ListCopyWith<$R, Track, TrackCopyWith<$R, Track, Track>> get tracks;
  @override
  $R call({String? name, List<Track>? tracks, DateTime? createdAt});
  LocalPlaylistCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LocalPlaylistCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalPlaylist, $Out>
    implements LocalPlaylistCopyWith<$R, LocalPlaylist, $Out> {
  _LocalPlaylistCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalPlaylist> $mapper =
      LocalPlaylistMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Track, TrackCopyWith<$R, Track, Track>> get tracks =>
      ListCopyWith(
        $value.tracks,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(tracks: v),
      );
  @override
  $R call({String? name, List<Track>? tracks, DateTime? createdAt}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (tracks != null) #tracks: tracks,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  LocalPlaylist $make(CopyWithData data) => LocalPlaylist(
    name: data.get(#name, or: $value.name),
    tracks: data.get(#tracks, or: $value.tracks),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  LocalPlaylistCopyWith<$R2, LocalPlaylist, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LocalPlaylistCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class YouTubePlaylistMapper extends ClassMapperBase<YouTubePlaylist> {
  YouTubePlaylistMapper._();

  static YouTubePlaylistMapper? _instance;
  static YouTubePlaylistMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = YouTubePlaylistMapper._());
      PlaylistMapper.ensureInitialized();
      TrackMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'YouTubePlaylist';

  static String _$name(YouTubePlaylist v) => v.name;
  static const Field<YouTubePlaylist, String> _f$name = Field('name', _$name);
  static List<Track> _$tracks(YouTubePlaylist v) => v.tracks;
  static const Field<YouTubePlaylist, List<Track>> _f$tracks = Field(
    'tracks',
    _$tracks,
  );
  static DateTime _$createdAt(YouTubePlaylist v) => v.createdAt;
  static const Field<YouTubePlaylist, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<YouTubePlaylist> fields = const {
    #name: _f$name,
    #tracks: _f$tracks,
    #createdAt: _f$createdAt,
  };

  static YouTubePlaylist _instantiate(DecodingData data) {
    return YouTubePlaylist(
      name: data.dec(_f$name),
      tracks: data.dec(_f$tracks),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static YouTubePlaylist fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<YouTubePlaylist>(map);
  }

  static YouTubePlaylist fromJson(String json) {
    return ensureInitialized().decodeJson<YouTubePlaylist>(json);
  }
}

mixin YouTubePlaylistMappable {
  String toJson() {
    return YouTubePlaylistMapper.ensureInitialized()
        .encodeJson<YouTubePlaylist>(this as YouTubePlaylist);
  }

  Map<String, dynamic> toMap() {
    return YouTubePlaylistMapper.ensureInitialized().encodeMap<YouTubePlaylist>(
      this as YouTubePlaylist,
    );
  }

  YouTubePlaylistCopyWith<YouTubePlaylist, YouTubePlaylist, YouTubePlaylist>
  get copyWith =>
      _YouTubePlaylistCopyWithImpl<YouTubePlaylist, YouTubePlaylist>(
        this as YouTubePlaylist,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return YouTubePlaylistMapper.ensureInitialized().stringifyValue(
      this as YouTubePlaylist,
    );
  }

  @override
  bool operator ==(Object other) {
    return YouTubePlaylistMapper.ensureInitialized().equalsValue(
      this as YouTubePlaylist,
      other,
    );
  }

  @override
  int get hashCode {
    return YouTubePlaylistMapper.ensureInitialized().hashValue(
      this as YouTubePlaylist,
    );
  }
}

extension YouTubePlaylistValueCopy<$R, $Out>
    on ObjectCopyWith<$R, YouTubePlaylist, $Out> {
  YouTubePlaylistCopyWith<$R, YouTubePlaylist, $Out> get $asYouTubePlaylist =>
      $base.as((v, t, t2) => _YouTubePlaylistCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class YouTubePlaylistCopyWith<$R, $In extends YouTubePlaylist, $Out>
    implements PlaylistCopyWith<$R, $In, $Out> {
  @override
  ListCopyWith<$R, Track, TrackCopyWith<$R, Track, Track>> get tracks;
  @override
  $R call({String? name, List<Track>? tracks, DateTime? createdAt});
  YouTubePlaylistCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _YouTubePlaylistCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, YouTubePlaylist, $Out>
    implements YouTubePlaylistCopyWith<$R, YouTubePlaylist, $Out> {
  _YouTubePlaylistCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<YouTubePlaylist> $mapper =
      YouTubePlaylistMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Track, TrackCopyWith<$R, Track, Track>> get tracks =>
      ListCopyWith(
        $value.tracks,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(tracks: v),
      );
  @override
  $R call({String? name, List<Track>? tracks, DateTime? createdAt}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (tracks != null) #tracks: tracks,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  YouTubePlaylist $make(CopyWithData data) => YouTubePlaylist(
    name: data.get(#name, or: $value.name),
    tracks: data.get(#tracks, or: $value.tracks),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  YouTubePlaylistCopyWith<$R2, YouTubePlaylist, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _YouTubePlaylistCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class YouTubePlayerStateMapper extends ClassMapperBase<YouTubePlayerState> {
  YouTubePlayerStateMapper._();

  static YouTubePlayerStateMapper? _instance;
  static YouTubePlayerStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = YouTubePlayerStateMapper._());
      YouTubeTrackMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'YouTubePlayerState';

  static List<YouTubeTrack> _$playlist(YouTubePlayerState v) => v.playlist;
  static const Field<YouTubePlayerState, List<YouTubeTrack>> _f$playlist =
      Field('playlist', _$playlist, opt: true, def: const []);
  static int _$currentTrackIndex(YouTubePlayerState v) => v.currentTrackIndex;
  static const Field<YouTubePlayerState, int> _f$currentTrackIndex = Field(
    'currentTrackIndex',
    _$currentTrackIndex,
    opt: true,
    def: 0,
  );
  static bool _$isPlaying(YouTubePlayerState v) => v.isPlaying;
  static const Field<YouTubePlayerState, bool> _f$isPlaying = Field(
    'isPlaying',
    _$isPlaying,
    opt: true,
    def: false,
  );
  static double _$volume(YouTubePlayerState v) => v.volume;
  static const Field<YouTubePlayerState, double> _f$volume = Field(
    'volume',
    _$volume,
    opt: true,
    def: 0.7,
  );
  static bool _$autoPlay(YouTubePlayerState v) => v.autoPlay;
  static const Field<YouTubePlayerState, bool> _f$autoPlay = Field(
    'autoPlay',
    _$autoPlay,
    opt: true,
    def: true,
  );
  static double _$currentTime(YouTubePlayerState v) => v.currentTime;
  static const Field<YouTubePlayerState, double> _f$currentTime = Field(
    'currentTime',
    _$currentTime,
    opt: true,
    def: 0,
  );
  static double _$duration(YouTubePlayerState v) => v.duration;
  static const Field<YouTubePlayerState, double> _f$duration = Field(
    'duration',
    _$duration,
    opt: true,
    def: 0,
  );
  static YouTubeTrack? _$currentTrack(YouTubePlayerState v) => v.currentTrack;
  static const Field<YouTubePlayerState, YouTubeTrack> _f$currentTrack = Field(
    'currentTrack',
    _$currentTrack,
    mode: FieldMode.member,
  );

  @override
  final MappableFields<YouTubePlayerState> fields = const {
    #playlist: _f$playlist,
    #currentTrackIndex: _f$currentTrackIndex,
    #isPlaying: _f$isPlaying,
    #volume: _f$volume,
    #autoPlay: _f$autoPlay,
    #currentTime: _f$currentTime,
    #duration: _f$duration,
    #currentTrack: _f$currentTrack,
  };

  static YouTubePlayerState _instantiate(DecodingData data) {
    return YouTubePlayerState(
      playlist: data.dec(_f$playlist),
      currentTrackIndex: data.dec(_f$currentTrackIndex),
      isPlaying: data.dec(_f$isPlaying),
      volume: data.dec(_f$volume),
      autoPlay: data.dec(_f$autoPlay),
      currentTime: data.dec(_f$currentTime),
      duration: data.dec(_f$duration),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static YouTubePlayerState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<YouTubePlayerState>(map);
  }

  static YouTubePlayerState fromJson(String json) {
    return ensureInitialized().decodeJson<YouTubePlayerState>(json);
  }
}

mixin YouTubePlayerStateMappable {
  String toJson() {
    return YouTubePlayerStateMapper.ensureInitialized()
        .encodeJson<YouTubePlayerState>(this as YouTubePlayerState);
  }

  Map<String, dynamic> toMap() {
    return YouTubePlayerStateMapper.ensureInitialized()
        .encodeMap<YouTubePlayerState>(this as YouTubePlayerState);
  }

  YouTubePlayerStateCopyWith<
    YouTubePlayerState,
    YouTubePlayerState,
    YouTubePlayerState
  >
  get copyWith =>
      _YouTubePlayerStateCopyWithImpl<YouTubePlayerState, YouTubePlayerState>(
        this as YouTubePlayerState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return YouTubePlayerStateMapper.ensureInitialized().stringifyValue(
      this as YouTubePlayerState,
    );
  }

  @override
  bool operator ==(Object other) {
    return YouTubePlayerStateMapper.ensureInitialized().equalsValue(
      this as YouTubePlayerState,
      other,
    );
  }

  @override
  int get hashCode {
    return YouTubePlayerStateMapper.ensureInitialized().hashValue(
      this as YouTubePlayerState,
    );
  }
}

extension YouTubePlayerStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, YouTubePlayerState, $Out> {
  YouTubePlayerStateCopyWith<$R, YouTubePlayerState, $Out>
  get $asYouTubePlayerState => $base.as(
    (v, t, t2) => _YouTubePlayerStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class YouTubePlayerStateCopyWith<
  $R,
  $In extends YouTubePlayerState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    YouTubeTrack,
    YouTubeTrackCopyWith<$R, YouTubeTrack, YouTubeTrack>
  >
  get playlist;
  $R call({
    List<YouTubeTrack>? playlist,
    int? currentTrackIndex,
    bool? isPlaying,
    double? volume,
    bool? autoPlay,
    double? currentTime,
    double? duration,
  });
  YouTubePlayerStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _YouTubePlayerStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, YouTubePlayerState, $Out>
    implements YouTubePlayerStateCopyWith<$R, YouTubePlayerState, $Out> {
  _YouTubePlayerStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<YouTubePlayerState> $mapper =
      YouTubePlayerStateMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    YouTubeTrack,
    YouTubeTrackCopyWith<$R, YouTubeTrack, YouTubeTrack>
  >
  get playlist => ListCopyWith(
    $value.playlist,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(playlist: v),
  );
  @override
  $R call({
    List<YouTubeTrack>? playlist,
    int? currentTrackIndex,
    bool? isPlaying,
    double? volume,
    bool? autoPlay,
    double? currentTime,
    double? duration,
  }) => $apply(
    FieldCopyWithData({
      if (playlist != null) #playlist: playlist,
      if (currentTrackIndex != null) #currentTrackIndex: currentTrackIndex,
      if (isPlaying != null) #isPlaying: isPlaying,
      if (volume != null) #volume: volume,
      if (autoPlay != null) #autoPlay: autoPlay,
      if (currentTime != null) #currentTime: currentTime,
      if (duration != null) #duration: duration,
    }),
  );
  @override
  YouTubePlayerState $make(CopyWithData data) => YouTubePlayerState(
    playlist: data.get(#playlist, or: $value.playlist),
    currentTrackIndex: data.get(
      #currentTrackIndex,
      or: $value.currentTrackIndex,
    ),
    isPlaying: data.get(#isPlaying, or: $value.isPlaying),
    volume: data.get(#volume, or: $value.volume),
    autoPlay: data.get(#autoPlay, or: $value.autoPlay),
    currentTime: data.get(#currentTime, or: $value.currentTime),
    duration: data.get(#duration, or: $value.duration),
  );

  @override
  YouTubePlayerStateCopyWith<$R2, YouTubePlayerState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _YouTubePlayerStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

