import 'package:flutter/material.dart';
import '/services/sound_service.dart';

class AchievementService {
  static final Set<String> _shown = {};
  static final List<OverlayEntry> _active = [];

  static void show(BuildContext context, String title) {
    if (_shown.contains(title)) return;
    _shown.add(title);

    final overlay = Overlay.of(context);
    final index = _active.length;

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => Positioned(
        top: 60.0 + (index * 70),
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(color: Colors.black45, blurRadius: 10),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.emoji_events, color: Colors.amber),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Logro desbloqueado: $title",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    _active.add(entry);
    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 2), () {
      entry.remove();
      _active.remove(entry);
    });
  }
}
