import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/settings_viewmodel.dart';
import '../../viewmodels/progress_viewmodel.dart';
import '../../viewmodels/history_viewmodel.dart';

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
            const CircleAvatar(
              radius: 50,

              backgroundImage: AssetImage("assets/images/perfil.png"),
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

                  await progressVM.load("guest");

                  await historyVM.load("guest");

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Sesión cerrada")),
                  );
                },
              ),

            if (user != null)
              ElevatedButton.icon(
                icon: const Icon(Icons.edit),

                label: const Text("Cambiar nombre"),

                onPressed: () {
                  final controller = TextEditingController(
                    text: settingsVM.username,
                  );

                  showDialog(
                    context: context,

                    builder: (_) => AlertDialog(
                      title: const Text("Cambiar nombre"),

                      content: TextField(
                        controller: controller,

                        decoration: const InputDecoration(labelText: "Nombre"),
                      ),

                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          child: const Text("Cancelar"),
                        ),

                        ElevatedButton(
                          onPressed: () async {
                            if (controller.text.trim().isEmpty) {
                              return;
                            }

                            settingsVM.setUsername(controller.text.trim());

                            await settingsVM.saveSettings();

                            Navigator.pop(context);
                          },

                          child: const Text("Guardar"),
                        ),
                      ],
                    ),
                  );
                },
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
