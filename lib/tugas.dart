import 'package:flutter/material.dart';

class TugasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.green.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Daftar Tugas',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildTaskButton(
                    icon: Icons.assignment_turned_in,
                    label: 'Tugas Matematika',
                    onTap: () => _showTaskDetails(context, 'Tugas Matematika'),
                  ),
                  _buildTaskButton(
                    icon: Icons.assignment,
                    label: 'Tugas Bahasa Inggris',
                    onTap: () => _showTaskDetails(context, 'Tugas Bahasa Inggris'),
                  ),
                  _buildTaskButton(
                    icon: Icons.assignment_late,
                    label: 'Tugas Fisika',
                    onTap: () => _showTaskDetails(context, 'Tugas Fisika'),
                  ),
                  _buildTaskButton(
                    icon: Icons.assignment_outlined,
                    label: 'Tugas Biologi',
                    onTap: () => _showTaskDetails(context, 'Tugas Biologi'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[300],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Colors.white),
            SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTaskDetails(BuildContext context, String taskName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(taskName),
          content: Text('Detail untuk $taskName'),
          actions: [
            TextButton(
              child: Text('Tutup'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
