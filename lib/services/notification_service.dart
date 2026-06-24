import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(android: android);

    await _plugin.initialize(settings);
  }

  static Future<void> requestPermission() async {
    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.requestNotificationsPermission();
  }

  static Future<void> showTest() async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'quiz_channel',
        'Quiz Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await _plugin.show(
      0,
      '¡Es hora de estudiar! 📚',
      'Completa tu quiz diario',
      details,
    );
  }

  static Future<void> scheduleDaily() async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel',
        'Daily Reminder',
        importance: Importance.max,
      ),
    );

    await _plugin.periodicallyShow(
      0,
      'Tu racha te espera 🔥',
      'Haz al menos un quiz hoy',
      RepeatInterval.daily,
      details,
    );
  }

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
