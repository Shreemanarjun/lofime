import 'dart:js_interop';

// This file defines the Dart interface for the optimized JavaScript functions in `yt_player_api.js`.

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

// --- Namespaced JS functions ---

@JS('LofimePlayer.init')
external JSPromise initVideoPlayer(JsPlayerOptions options);

@JS('LofimePlayer.create')
external JSPromise createPlayer(String videoId);

@JS('LofimePlayer.play')
external void playVideo();

@JS('LofimePlayer.pause')
external void pauseVideo();

@JS('LofimePlayer.seek')
external void seekVideo(double time);

@JS('LofimePlayer.setVolume')
external void setVideoVolume(double volume);

@JS('LofimePlayer.load')
external void loadVideo(String videoId);

@JS('LofimePlayer.destroy')
external JSPromise destroyVideoPlayer();
