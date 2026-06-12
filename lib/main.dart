import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'ui/screens/menu_screen.dart';
import 'ui/screens/subject_screen.dart';
import 'ui/screens/quiz_screen.dart';
import 'ui/screens/history_screen.dart';
import 'ui/screens/profile_screen.dart';
import 'ui/screens/rewards_screen.dart';
import 'ui/screens/setting_screen.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/screens/about.dart';
import 'ui/screens/quality_screen.dart';

import 'data/math_questions.dart';
import 'data/language_questions.dart';
import 'data/science_questions.dart';
import 'data/history_questions.dart';

import 'package:provider/provider.dart';
import 'viewmodels/settings_viewmodel.dart';
import 'viewmodels/quality_viewmodel.dart';
import 'viewmodels/feedback_viewmodel.dart';
import 'viewmodels/history_viewmodel.dart';

import 'ui/screens/feedback_screen.dart';

import 'ui/screens/help_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print("PASO 1");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print("PASO 2");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),

        ChangeNotifierProvider(create: (_) => QualityViewModel()),

        ChangeNotifierProvider(create: (_) => FeedbackViewModel()),

        ChangeNotifierProvider(create: (_) => HistoryViewModel()),
      ],

      child: const MyApp(),
    ),
  );

  print("PASO 3");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, settings, _) {
        return MaterialApp(
          title: 'StudyPlay',

          theme: ThemeData(
            brightness: settings.darkMode ? Brightness.dark : Brightness.light,

            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: settings.darkMode
                  ? Brightness.dark
                  : Brightness.light,
            ),

            scaffoldBackgroundColor: settings.darkMode
                ? const Color(0xFF121212)
                : const Color.fromARGB(255, 230, 245, 255),

            useMaterial3: true,
          ),

          initialRoute: '/',

          routes: {
            '/': (context) => const SplashScreen(),
            '/menu': (context) => const MenuScreen(),
            '/subjects': (context) => const SubjectScreen(),
            '/quiz': (context) => QuizScreen(title: '', questions: const []),
            '/history': (context) => HistoryScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/rewards': (context) => const RewardsScreen(),
            '/settings': (context) => const SettingScreen(),
            '/quality': (context) => const QualityScreen(),
            '/feedback': (context) => const FeedbackScreen(),
            '/about': (context) => const AboutScreen(),
            '/help': (context) => const HelpScreen(),

            '/quiz_math': (_) =>
                QuizScreen(title: "Matemática", questions: MathQuestions.list),

            '/quiz_language': (_) => QuizScreen(
              title: "Lenguaje",
              questions: LanguageQuestions.list,
            ),

            '/quiz_science': (_) =>
                QuizScreen(title: "Ciencias", questions: ScienceQuestions.list),

            '/quiz_history': (_) =>
                QuizScreen(title: "Historia", questions: HistoryQuestions.list),
          },
        );
      },
    );
  }
}
