import 'package:flutter/material.dart';

class MateriScreen extends StatelessWidget {
  final List<Map<String, dynamic>> materiList = [
    {
      'title': 'Matematika',
      'icon': Icons.calculate,
      'color': Colors.blue,
      'topics': ['Aljabar', 'Geometri', 'Kalkulus', 'Statistika']
    },
    {
      'title': 'Bahasa Indonesia',
      'icon': Icons.book,
      'color': Colors.red,
      'topics': ['Tata Bahasa', 'Sastra', 'Menulis Kreatif', 'Pidato']
    },
    {
      'title': 'Ilmu Pengetahuan Alam',
      'icon': Icons.science,
      'color': Colors.green,
      'topics': ['Fisika', 'Kimia', 'Biologi', 'Astronomi']
    },
    {
      'title': 'Ilmu Pengetahuan Sosial',
      'icon': Icons.public,
      'color': Colors.orange,
      'topics': ['Sejarah', 'Geografi', 'Ekonomi', 'Sosiologi']
    },
    {
      'title': 'Bahasa Inggris',
      'icon': Icons.language,
      'color': Colors.purple,
      'topics': ['Grammar', 'Speaking', 'Listening', 'Writing']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Materi Pembelajaran'),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green.shade50, Colors.green.shade100],
          ),
        ),
        child: ListView.builder(
          itemCount: materiList.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: materiList[index]['color'],
                  child: Icon(materiList[index]['icon'], color: Colors.white),
                ),
                title: Text(
                  materiList[index]['title'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Topik Pembelajaran:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        ...materiList[index]['topics'].map((topic) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle,
                                      size: 16, color: Colors.green),
                                  SizedBox(width: 8),
                                  Text(topic),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
