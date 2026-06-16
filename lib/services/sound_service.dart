import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class SoundService {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> play(String file) async {
    await _player.stop();
    await _player.play(AssetSource('sounds/$file'));
  }

  static Future<void> correct() => play('correct.mp3');
  static Future<void> wrong() => play('wrong.mp3');
}

class HapticsService {
  static Future<void> correct() async {
    final hasVibrator = await Vibration.hasVibrator();

    if (!hasVibrator) return;

    Vibration.vibrate(duration: 200, amplitude: 255);
  }

  static Future<void> wrong() async {
    final hasVibrator = await Vibration.hasVibrator();

    if (!hasVibrator) return;

    Vibration.vibrate(pattern: [0, 100, 50, 200]);
  }
}
