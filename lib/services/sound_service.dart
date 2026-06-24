import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class SoundService {
  static final AudioPlayer _player = AudioPlayer();

  static bool _enabled = true;

  static void setEnabled(bool value) {
    _enabled = value;
  }

  static Future<void> play(String file) async {
    if (!_enabled) return;

    await _player.stop();
    await _player.play(AssetSource('sounds/$file'));
  }

  static Future<void> correct() => play('correct.mp3');
  static Future<void> wrong() => play('wrong.mp3');
  static Future<void> victory() => play('victory1.mp3');
  static Future<void> reward() => play('reward.mp3');
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

  static Future<void> victory() async {
    final hasVibrator = await Vibration.hasVibrator();

    if (!hasVibrator) return;

    Vibration.vibrate(pattern: [0, 200, 100, 200, 100, 300]);
  }
}
