import 'package:flutter_tts/flutter_tts.dart';


class AudioController {
  static final FlutterTts _flutterTts = FlutterTts();

  static Future playAudio(String text) async {
    if (text != null) {
      if (text.isNotEmpty) {
        var result = await _flutterTts.speak(text);
      }
    }
  }

  static Future stopAudio(String text) async {
    var result = await _flutterTts.stop();
  }
}