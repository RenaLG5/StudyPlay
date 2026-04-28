import 'package:flutter/material.dart';

import 'ui/screens/menu_screen.dart';
import 'ui/screens/subject_screen.dart';
import 'ui/screens/quiz_screen.dart';
import 'ui/screens/history_screen.dart';
import 'ui/screens/profile_screen.dart';
import 'ui/screens/rewards_screen.dart';
import 'ui/screens/setting_screen.dart';
import 'ui/screens/about.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyPlay',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.lightBlueAccent,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 230, 245, 255),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        useMaterial3: true,
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const MenuScreen(),
        '/subjects': (context) => const SubjectScreen(),
        '/quiz': (context) => const QuizScreen(),
        '/history': (context) => HistoryScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/rewards': (context) => const RewardsScreen(),
        '/settings': (context) => const SettingScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
