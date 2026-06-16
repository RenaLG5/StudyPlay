import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class SoundService {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> correct() async {
    await _player.play(AssetSource('sounds/correct.mp3'));
  }

  static Future<void> wrong() async {
    await _player.play(AssetSource('sounds/wrong.mp3'));
  }
}

class HapticsService {
  static void correct() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 80);
    }
  }

  static void wrong() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(pattern: [0, 100, 50, 200]);
    }
  }
}
