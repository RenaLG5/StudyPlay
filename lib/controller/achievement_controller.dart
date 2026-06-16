import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AchievementController {
  static final Set<String> _shown = {};
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> check({
    required BuildContext context,
    required List<Map<String, dynamic>> achievements,
    required String subject,
    required int subjectWins,
  }) async {
    bool hasVictory = false;
    bool hasReward = false;

    for (final a in achievements) {
      final title = a["title"].toString();
      final unlocked = a["unlocked"] == true;

      if (unlocked && !_shown.contains(title)) {
        _shown.add(title);

        _showBanner(context, title);

        hasReward = true;
      }
    }

    if (subjectWins == 5) {
      hasVictory = true;
    }

    await _playSound(hasVictory, hasReward);
  }

  static Future<void> _playSound(bool victory, bool reward) async {
    await _player.stop();

    if (victory) {
      await _player.play(AssetSource('sounds/victory1.mp3'));
      return;
    }

    if (reward) {
      await _player.play(AssetSource('sounds/reward.mp3'));
    }
  }

  static void _showBanner(BuildContext context, String title) {
    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder: (_) => Positioned(
        top: 60,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const Icon(Icons.emoji_events, color: Colors.amber),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Logro desbloqueado: $title",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 2), () {
      entry.remove();
    });
  }
}
