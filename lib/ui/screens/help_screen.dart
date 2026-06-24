import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda y Soporte'),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const Text(
            'Preguntas Frecuentes',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          _buildFAQ(
            icon: Icons.play_arrow,
            question: '¿Cómo comienzo un quiz?',
            answer:
                'Presiona el botón "JUGAR" en el menú principal y selecciona una materia.',
          ),

          _buildFAQ(
            icon: Icons.category,
            question: '¿Qué materias puedo estudiar?',
            answer:
                'Puedes elegir entre Matemáticas, Lenguaje, Ciencias e Historia.',
          ),

          _buildFAQ(
            icon: Icons.timer,
            question: '¿Se guarda mi progreso?',
            answer:
                'Sí, cada partida se guarda en el historial con tus resultados.',
          ),

          _buildFAQ(
            icon: Icons.emoji_events,
            question: '¿Cómo gano puntos?',
            answer: 'Respondiendo correctamente las preguntas del quiz.',
          ),

          _buildFAQ(
            icon: Icons.history,
            question: '¿Dónde veo mis partidas anteriores?',
            answer: 'En la sección "Historial" desde el menú principal.',
          ),

          const SizedBox(height: 20),

          const Text(
            'Soporte',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Card(
            child: ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Contacto'),
              subtitle: const Text('soporte@studyplay.com'),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Versión'),
              subtitle: const Text('StudyPlay v1.0'),
            ),
          ),
          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/feedback');
            },
            icon: const Icon(Icons.star_rate),
            label: const Text('Valorar aplicación'),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQ({
    required IconData icon,
    required String question,
    required String answer,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(question),
        children: [
          Padding(padding: const EdgeInsets.all(15), child: Text(answer)),
        ],
      ),
    );
  }
}
