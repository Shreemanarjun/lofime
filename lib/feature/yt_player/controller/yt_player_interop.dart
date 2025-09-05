import 'dart:js_interop';

// This file defines the Dart interface for the JavaScript functions in `yt_player_api.js`.

// --- Data Structures for JS Callbacks ---

@JS()
@anonymous
extension type JsTrackInfo._(JSObject _) implements JSObject {
  external String get videoId;
  external String get title;
  external String get author;
  external double get duration;
}

@JS()
@anonymous
extension type JsProgressInfo._(JSObject _) implements JSObject {
  external double get currentTime;
  external double get duration;
}

// --- Options for Initialization ---

@JS()
@anonymous
extension type JsPlayerOptions._(JSObject _) implements JSObject {
  external factory JsPlayerOptions({
    JSFunction onReady,
    JSFunction onStateChange,
    JSFunction onTrackInfo,
    JSFunction onProgress,
  });
}

// --- Top-level JS functions exposed on the `window` object ---

@JS('initYouTubePlayer')
external void initVideoPlayer(JsPlayerOptions options);

/// Creates a new player instance. Returns a promise that resolves when the player is ready.
@JS('createPlayer')
external JSPromise createPlayer(String videoId);

@JS('playYouTubeVideo')
external void playVideo();

@JS('pauseYouTubeVideo')
external void pauseVideo();

@JS('seekYouTubeVideo')
external void seekVideo(double time);

/// Sets the player volume.
/// [volume] is a value between 0.0 and 1.0.
/// Note: The JS implementation scales this to the 0-100 range required by the YouTube API.
@JS('setYouTubeVolume')
external void setVideoVolume(double volume);

@JS('loadYouTubeVideo')
external void loadVideo(String videoId);

/// Destroys the player instance. Returns a promise that resolves when destruction is complete.
@JS('destroyYouTubePlayer')
external JSPromise destroyVideoPlayer();
