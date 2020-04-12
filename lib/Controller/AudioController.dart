import 'package:flutter_tts/flutter_tts.dart';

/// Controller class for audio
/// @author  Team Superman
/// @version 1.0
/// @since   2020-04-08
class AudioController {
  static final FlutterTts _flutterTts = FlutterTts();

  /// Plays the audio of the text
  /// @param text String extracted from image
  static Future playAudio(String text) async {
    if (text != null) {
      if (text.isNotEmpty) {
        var result = await _flutterTts.speak(text);
      }
    }
  }

  /// Stops the audio from playing
  /// @param text String extracted from image
  static Future stopAudio(String text) async {
    var result = await _flutterTts.stop();
  }
}