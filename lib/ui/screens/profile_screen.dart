import 'package:flutter/material.dart';
import 'firebase_poc_screen.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/settings_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  String getFlag(String country) {
    switch (country.toLowerCase()) {
      case 'chile':
        return '🇨🇱';
      case 'argentina':
        return '🇦🇷';
      case 'peru':
        return '🇵🇪';
      case 'mexico':
        return '🇲🇽';
      case 'colombia':
        return '🇨🇴';
      default:
        return '🌍';
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsVM = Provider.of<SettingsViewModel>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/perfil.png'),
            ),

            const SizedBox(height: 15),

            Text(
              settingsVM.username.isEmpty ? 'Usuario' : settingsVM.username,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Correo'),
                      subtitle: Text(
                        settingsVM.email.isEmpty
                            ? 'No definido'
                            : settingsVM.email,
                      ),
                    ),

                    ListTile(
                      leading: const Icon(Icons.cake),
                      title: const Text('Edad'),
                      subtitle: Text(
                        settingsVM.age.isEmpty
                            ? 'No definido'
                            : settingsVM.age + ' años',
                      ),
                    ),

                    ListTile(
                      leading: Text(
                        getFlag(settingsVM.country),
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: const Text('País'),
                      subtitle: Text(
                        settingsVM.country.isEmpty
                            ? 'No definido'
                            : settingsVM.country,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final nameController = TextEditingController(
                      text: settingsVM.username,
                    );

                    final emailController = TextEditingController(
                      text: settingsVM.email,
                    );

                    final ageController = TextEditingController(
                      text: settingsVM.age,
                    );

                    final countryController = TextEditingController(
                      text: settingsVM.country,
                    );

                    return AlertDialog(
                      title: const Text('Editar perfil'),

                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                labelText: 'Nombre',
                              ),
                            ),

                            TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: 'Correo',
                              ),
                            ),

                            TextField(
                              controller: ageController,
                              decoration: const InputDecoration(
                                labelText: 'Edad',
                              ),
                            ),

                            TextField(
                              controller: countryController,
                              decoration: const InputDecoration(
                                labelText: 'País',
                              ),
                            ),
                          ],
                        ),
                      ),

                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),

                        ElevatedButton(
                          onPressed: () async {
                            settingsVM.setUsername(nameController.text);

                            settingsVM.setEmail(emailController.text);

                            settingsVM.setAge(ageController.text);

                            settingsVM.setCountry(countryController.text);

                            await settingsVM.saveSettings();

                            Navigator.pop(context);
                          },

                          child: const Text('Guardar'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text('Editar perfil'),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FirebasePocScreen()),
                );
              },

              icon: const Icon(Icons.cloud),

              label: const Text('Firebase PoC'),
            ),
          ],
        ),
      ),
    );
  }
}
