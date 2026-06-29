import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/settings_viewmodel.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsVM = Provider.of<SettingsViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Selector de Idioma (Única parte con lógica de internacionalización)
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Idioma'),
            trailing: DropdownButton<Locale>(
              value: settingsVM.currentLocale,
              items: const [
                DropdownMenuItem(value: Locale('es'), child: Text('Español')),
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
              ],
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  settingsVM.setLocale(newLocale);
                }
              },
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),

          // Resto de la pantalla original (sin cambios)
          SwitchListTile(
            title: const Text('Modo oscuro'),
            subtitle: const Text('Cambia el tema de la aplicación'),
            value: settingsVM.darkMode,
            onChanged: (value) async {
              await settingsVM.setDarkMode(value);
            },
          ),

          SwitchListTile(
            title: const Text('Notificaciones'),
            subtitle: const Text('Mostrar avisos en la app'),
            value: settingsVM.notifications,
            onChanged: (value) async {
              await settingsVM.setNotifications(value);
            },
          ),

          SwitchListTile(
            title: const Text('Sonido'),
            subtitle: const Text('Efectos de audio en la app'),
            value: settingsVM.sound,
            onChanged: (value) async {
              await settingsVM.setSound(value);
            },
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Configuración guardada')),
                );
              },
              icon: const Icon(Icons.save),
              label: const Text('Guardar cambios'),
            ),
          ),
        ],
      ),
    );
  }
}
