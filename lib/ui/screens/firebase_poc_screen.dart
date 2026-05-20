import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebasePocScreen extends StatefulWidget {
  const FirebasePocScreen({super.key});

  @override
  State<FirebasePocScreen> createState() => _FirebasePocScreenState();
}

class _FirebasePocScreenState extends State<FirebasePocScreen> {
  String statusMessage = 'Sin iniciar sesión';

  bool isLoading = false;

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInAnonymously();

      setState(() {
        statusMessage = 'Login exitoso con Firebase';
      });
    } catch (e) {
      setState(() {
        statusMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase PoC')),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Icon(Icons.cloud_done, size: 90, color: Colors.orange),

              const SizedBox(height: 25),

              const Text(
                'Prueba de Firebase Authentication',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: isLoading ? null : login,

                icon: const Icon(Icons.login),

                label: const Text('Login Firebase'),

                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 15,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              if (isLoading) const CircularProgressIndicator(),

              if (!isLoading)
                Text(
                  statusMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
