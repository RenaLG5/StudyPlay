import 'package:flutter/material.dart';

void showAchievementBanner(BuildContext context, String title) {
  final overlay = Overlay.of(context);

  final entry = OverlayEntry(
    builder: (context) => Positioned(
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
            boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black45)],
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

  overlay.insert(entry);

  Future.delayed(const Duration(seconds: 2), () {
    entry.remove();
  });
}
