import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/settings_viewmodel.dart';
import '../../viewmodels/progress_viewmodel.dart';
import '../../viewmodels/history_viewmodel.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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

    final progressVM = Provider.of<ProgressViewModel>(context);

    final historyVM = Provider.of<HistoryViewModel>(context);

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Perfil")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Consumer<SettingsViewModel>(
              builder: (context, settingsVM, _) {
                return CircleAvatar(
                  radius: 50,
                  backgroundImage: settingsVM.profileImagePath.isNotEmpty
                      ? FileImage(File(settingsVM.profileImagePath))
                      : const AssetImage("assets/images/perfil.png")
                            as ImageProvider,
                );
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text("Cambiar foto"),
              onPressed: () async {
                final picker = ImagePicker();

                final pickedFile = await picker.pickImage(
                  source: ImageSource.gallery,
                );

                if (pickedFile != null) {
                  final settingsVM = Provider.of<SettingsViewModel>(
                    context,
                    listen: false,
                  );

                  await settingsVM.setProfileImage(pickedFile.path);
                }
              },
            ),

            const SizedBox(height: 15),

            Text(
              user == null
                  ? "Invitado"
                  : (settingsVM.username.isEmpty
                        ? user.email!.split("@")[0]
                        : settingsVM.username),

              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.email),

                    title: const Text("Correo"),

                    subtitle: Text(
                      user == null ? "No has iniciado sesión" : user.email!,
                    ),
                  ),

                  ListTile(
                    leading: const Icon(Icons.cake),

                    title: const Text("Edad"),

                    subtitle: Text(
                      settingsVM.age.isEmpty
                          ? "No definido"
                          : "${settingsVM.age} años",
                    ),
                  ),

                  ListTile(
                    leading: Text(
                      getFlag(settingsVM.country),

                      style: const TextStyle(fontSize: 24),
                    ),

                    title: const Text("País"),

                    subtitle: Text(
                      settingsVM.country.isEmpty
                          ? "No definido"
                          : settingsVM.country,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text("Editar perfil"),
              onPressed: () {
                final nameController = TextEditingController(
                  text: settingsVM.username,
                );
                final ageController = TextEditingController(
                  text: settingsVM.age,
                );
                final countryController = TextEditingController(
                  text: settingsVM.country,
                );

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Editar perfil"),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: "Nombre",
                            ),
                          ),
                          TextField(
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Edad",
                            ),
                          ),
                          TextField(
                            controller: countryController,
                            decoration: const InputDecoration(
                              labelText: "País",
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancelar"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (nameController.text.trim().isNotEmpty) {
                            settingsVM.username = nameController.text.trim();
                            await settingsVM.saveUsername(settingsVM.username);
                          }

                          if (ageController.text.trim().isNotEmpty) {
                            settingsVM.age = ageController.text.trim();
                            await settingsVM.saveAge(settingsVM.age);
                          }

                          if (countryController.text.trim().isNotEmpty) {
                            settingsVM.country = countryController.text.trim();
                            await settingsVM.saveCountry(settingsVM.country);
                          }
                          settingsVM.notifyListeners();
                          Navigator.pop(context);
                        },
                        child: const Text("Guardar"),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 30),

            ElevatedButton.icon(
              icon: const Icon(Icons.login),

              label: Text(user == null ? "Iniciar sesión" : "Cambiar cuenta"),

              onPressed: () {
                final emailController = TextEditingController();

                final passwordController = TextEditingController();

                showDialog(
                  context: context,

                  builder: (_) {
                    return AlertDialog(
                      title: const Text("Iniciar sesión"),

                      content: Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          TextField(
                            controller: emailController,

                            decoration: const InputDecoration(
                              labelText: "Correo",
                            ),
                          ),

                          const SizedBox(height: 10),

                          TextField(
                            controller: passwordController,

                            obscureText: true,

                            decoration: const InputDecoration(
                              labelText: "Contraseña",
                            ),
                          ),
                        ],
                      ),

                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancelar"),
                        ),

                        ElevatedButton(
                          child: const Text("Entrar"),

                          onPressed: () async {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );

                              final email = credential.user!.email!;

                              final settingsVM = Provider.of<SettingsViewModel>(
                                context,
                                listen: false,
                              );
                              settingsVM.setCurrentUser(email);

                              await progressVM.load(email);

                              await historyVM.load(email);

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Sesión iniciada"),
                                ),
                              );
                            } on FirebaseAuthException catch (e) {
                              String msg = "Error al iniciar sesión";

                              if (e.code == 'user-not-found') {
                                msg = "No existe una cuenta con ese correo";
                              }

                              if (e.code == 'wrong-password') {
                                msg = "Contraseña incorrecta";
                              }

                              if (e.code == 'invalid-email') {
                                msg = "Correo inválido";
                              }

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(msg)));
                            }
                          },
                        ),

                        ElevatedButton(
                          child: const Text("Crear cuenta"),

                          onPressed: () async {
                            try {
                              final email = emailController.text.trim();

                              final password = passwordController.text.trim();

                              if (email.isEmpty || password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Debes ingresar correo y contraseña",
                                    ),
                                  ),
                                );

                                return;
                              }

                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );

                              await progressVM.load(email);

                              await historyVM.load(email);

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Cuenta creada correctamente"),
                                ),
                              );
                            } on FirebaseAuthException catch (e) {
                              String msg = "No se pudo crear la cuenta";

                              if (e.code == 'email-already-in-use') {
                                msg = "Ese correo ya está registrado";
                              }

                              if (e.code == 'weak-password') {
                                msg =
                                    "La contraseña debe tener al menos 6 caracteres";
                              }

                              if (e.code == 'invalid-email') {
                                msg = "Correo inválido";
                              }

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(msg)));
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 20),

            if (user != null)
              ElevatedButton.icon(
                icon: const Icon(Icons.logout),

                label: const Text("Cerrar sesión"),

                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),

                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  final settingsVM = Provider.of<SettingsViewModel>(
                    context,
                    listen: false,
                  );
                  await settingsVM.clearUserData();

                  await progressVM.load("guest");

                  await historyVM.load("guest");
                  if (context.mounted) {
                    Navigator.pop(context);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Sesión cerrada")),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
