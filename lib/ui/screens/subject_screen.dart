import 'package:flutter/material.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Materias')),

      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildSubject(
                context,
                title: 'Matemáticas',
                color: Colors.blue,
                icon: Icons.calculate,
              ),

              _buildSubject(
                context,
                title: 'Lenguaje',
                color: Colors.red,
                icon: Icons.menu_book,
              ),

              _buildSubject(
                context,
                title: 'Ciencias',
                color: Colors.green,
                icon: Icons.science,
              ),

              _buildSubject(
                context,
                title: 'Historia',
                color: Colors.orange,
                icon: Icons.account_balance,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubject(
    BuildContext context, {
    required String title,
    required Color color,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/quiz', arguments: {'subject': title});
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
