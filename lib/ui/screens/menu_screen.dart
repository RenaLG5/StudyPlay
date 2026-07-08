import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_plus/share_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../l10n/app_localizations.dart';
import '../../viewmodels/settings_viewmodel.dart';
import '../../viewmodels/progress_viewmodel.dart';
import '../../viewmodels/history_viewmodel.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _wasOffline = false;

  @override
  void initState() {
    super.initState();

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      final hasInternet = !results.contains(ConnectivityResult.none);

      if (!mounted) return;

      if (!hasInternet) {
        _wasOffline = true;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Sin conexión. Se utilizará la copia local."),
            backgroundColor: Colors.orange,
          ),
        );
      } else if (_wasOffline) {
        _wasOffline = false;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Vuelves a tener conexión."),
            backgroundColor: Colors.green,
          ),
        );
      }
    });

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
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

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
                            : const AssetImage('assets/images/perfil.png')
                                  as ImageProvider,
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
              title: Text(l10n.profile),
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(l10n.settings),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),

            ListTile(
              leading: const Icon(Icons.help),
              title: Text(l10n.helpAndSupport),
              onTap: () => Navigator.pushNamed(context, '/help'),
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(l10n.logout),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(l10n.logout),
                    content: Text(l10n.areYouSure),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(l10n.cancel),
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
                        child: Text(l10n.exit),
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
              Share.share(l10n.shareMessage);
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

            Text(
              l10n.learnWhilePlaying,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/subjects');
              },
              icon: const Icon(Icons.play_arrow),
              label: Text(l10n.play),
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
