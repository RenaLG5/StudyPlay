import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../viewmodels/settings_viewmodel.dart';
import '../../viewmodels/progress_viewmodel.dart';
import '../../viewmodels/history_viewmodel.dart';

class CourseSelectionScreen extends StatelessWidget {
  const CourseSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsVM = Provider.of<SettingsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("¿En qué curso vas?"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 6,
        itemBuilder: (context, index) {
          final course = index + 1;

          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text("$course°")),
              title: Text("$course° básico"),
              trailing: settingsVM.selectedCourse == course
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.arrow_forward_ios),
              onTap: () async {
                await settingsVM.setSelectedCourse(course);

                final user = FirebaseAuth.instance.currentUser;
                final email = user?.email ?? "guest";

                await Provider.of<ProgressViewModel>(
                  context,
                  listen: false,
                ).load(email, course: course);

                await Provider.of<HistoryViewModel>(
                  context,
                  listen: false,
                ).load(email);

                if (context.mounted) {
                  Navigator.pushNamed(context, '/subjects');
                }
              },
            ),
          );
        },
      ),
    );
  }
}
