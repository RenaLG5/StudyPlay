import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/settings_viewmodel.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsVM = Provider.of<SettingsViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Preferencias')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text: settingsVM.username),

              decoration: const InputDecoration(
                labelText: 'Nombre de usuario',
                border: OutlineInputBorder(),
              ),

              onChanged: settingsVM.setUsername,
            ),

            const SizedBox(height: 30),

            DropdownButtonFormField<String>(
              value: settingsVM.difficulty,

              decoration: const InputDecoration(
                labelText: 'Dificultad',
                border: OutlineInputBorder(),
              ),

              items: const [
                DropdownMenuItem(value: 'Fácil', child: Text('Fácil')),

                DropdownMenuItem(value: 'Medio', child: Text('Medio')),

                DropdownMenuItem(value: 'Difícil', child: Text('Difícil')),
              ],

              onChanged: (value) {
                settingsVM.setDifficulty(value!);
              },
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () async {
                  await settingsVM.saveSettings();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preferencias guardadas')),
                  );
                },

                child: const Text('Guardar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
