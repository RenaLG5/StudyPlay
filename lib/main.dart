import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';

// UI Screens
import 'ui/screens/menu_screen.dart';
import 'ui/screens/subject_screen.dart';
import 'ui/screens/quiz_screen.dart';
import 'ui/screens/history_screen.dart';
import 'ui/screens/profile_screen.dart';
import 'ui/screens/rewards_screen.dart';
import 'ui/screens/setting_screen.dart';
import 'ui/screens/about.dart';
import 'ui/screens/quality_screen.dart';
import 'ui/screens/feedback_screen.dart';
import 'ui/screens/help_screen.dart';
import 'ui/screens/course_selection_screen.dart';

// Services
import 'services/notification_service.dart';

// ViewModels
import 'viewmodels/settings_viewmodel.dart';
import 'viewmodels/quality_viewmodel.dart';
import 'viewmodels/feedback_viewmodel.dart';
import 'viewmodels/history_viewmodel.dart';
import 'viewmodels/progress_viewmodel.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/quiz_questions_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService.init();
  await NotificationService.requestPermission();

  final settingsVM = SettingsViewModel();
  await settingsVM.loadCurrentUser();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settingsVM),
        ChangeNotifierProvider(create: (_) => QualityViewModel()),
        ChangeNotifierProvider(create: (_) => FeedbackViewModel()),
        ChangeNotifierProvider(create: (_) => HistoryViewModel()),
        ChangeNotifierProvider(create: (_) => ProgressViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => QuizQuestionsViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, settings, _) {
        return MaterialApp(
          title: 'StudyPlay',
          debugShowCheckedModeBanner: false,

          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: settings.currentLocale,

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

          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              return const MenuScreen();
            },
          ),

          routes: {
            '/menu': (context) => const MenuScreen(),
            '/courses': (context) => const CourseSelectionScreen(),
            '/subjects': (context) => const SubjectScreen(),
            '/quiz': (context) =>
                QuizScreen(title: '', questions: const [], level: 1),
            '/history': (context) => HistoryScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/rewards': (context) => const RewardsScreen(),
            '/settings': (context) => const SettingScreen(),
            '/quality': (context) => const QualityScreen(),
            '/feedback': (context) => const FeedbackScreen(),
            '/about': (context) => const AboutScreen(),
            '/help': (context) => const HelpScreen(),
          },
        );
      },
    );
  }
}
