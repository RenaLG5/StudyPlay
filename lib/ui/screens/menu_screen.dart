import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/settings_viewmodel.dart';
import 'package:share_plus/share_plus.dart';
import '../../viewmodels/progress_viewmodel.dart';
import '../../viewmodels/history_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && user.email != null) {
        await Provider.of<ProgressViewModel>(
          context,
          listen: false,
        ).load(user.email!);

        await Provider.of<HistoryViewModel>(
          context,
          listen: false,
        ).load(user.email!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsVM = Provider.of<SettingsViewModel>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: theme.colorScheme.primary),
              child: Consumer<SettingsViewModel>(
                builder: (context, settingsVM, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: settingsVM.profileImagePath.isNotEmpty
                            ? FileImage(File(settingsVM.profileImagePath))
                            : const AssetImage('assets/images/perfil.png'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        settingsVM.displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),

            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Ayuda y soporte'),
              onTap: () => Navigator.pushNamed(context, '/help'),
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Cerrar sesión'),
                    content: const Text('¿Estás seguro?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () async {
                          final settingsVM = Provider.of<SettingsViewModel>(
                            context,
                            listen: false,
                          );

                          await FirebaseAuth.instance.signOut();
                          await settingsVM.clearUserData();

                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MenuScreen(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        child: const Text('Salir'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        title: const Text('StudyPlay'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share('Estoy usando StudyPlay');
            },
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/perrito1.png', width: 200, height: 200),

            const SizedBox(height: 10),

            const Text(
              'Aprende jugando',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/subjects');
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('JUGAR'),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/rewards');
        },
        child: const Icon(Icons.emoji_events),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () => Navigator.pushNamed(context, '/history'),
            ),

            const SizedBox(width: 40),

            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => Navigator.pushNamed(context, '/profile'),
            ),
          ],
        ),
      ),
    );
  }
}
