import 'package:flutter/material.dart';
import 'firebase_poc_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

            const Text(
              'Renato León',
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
                      subtitle: const Text('rleon23@alumnos.utalca.cl'),
                    ),

                    ListTile(
                      leading: const Icon(Icons.cake),
                      title: const Text('Edad'),
                      subtitle: const Text('21 años'),
                    ),

                    ListTile(
                      leading: const Text(
                        '🇨🇱',
                        style: TextStyle(fontSize: 24),
                      ),
                      title: const Text('País'),
                      subtitle: const Text('Chile'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {},
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
