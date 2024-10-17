import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GaleryScreen extends StatefulWidget {
  const GaleryScreen({super.key});

  @override
  _GaleryScreenState createState() => _GaleryScreenState();
}

class _GaleryScreenState extends State<GaleryScreen> {
  List<dynamic> galeryData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGaleryData();
  }

  Future<void> fetchGaleryData() async {
    final response = await http.get(Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=galery'));
    if (response.statusCode == 200) {
      setState(() {
        galeryData = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load galery data');
    }
  }

  void _addData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String judul = '';
        String isi = '';
        
        return AlertDialog(
          title: Text('Tambah Data', style: TextStyle(color: Colors.green[800])),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Judul Galeri',
                  labelStyle: TextStyle(color: Colors.green[800]),
                ),
                onChanged: (value) => judul = value,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'URL Gambar',
                  labelStyle: TextStyle(color: Colors.green[800]),
                ),
                onChanged: (value) => isi = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Batal', style: TextStyle(color: Colors.green[800])),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Simpan', style: TextStyle(color: Colors.green[800])),
              onPressed: () async {
                if (judul.isNotEmpty && isi.isNotEmpty) {
                  final response = await http.post(
                    Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=galery'),
                    body: {
                      'judul_galery': judul,
                      'isi_galery': isi,
                    },
                  );
                  if (response.statusCode == 200) {
                    Navigator.of(context).pop();
                    fetchGaleryData(); // Refresh data setelah menambah
                  } else {
                    // Tampilkan pesan error jika gagal
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal menambah data')),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Galery',
            style: TextStyle(
              color: Colors.green[800],
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.green[800]),
                onPressed: _addData,
              ),
            ),
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.green))
            : GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: galeryData.length,
                itemBuilder: (context, index) {
                  final item = galeryData[index];
                  return Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                          child: Image.network(
                            item['isi_galery'] ?? '',
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error, color: Colors.green),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['judul_galery'] ?? 'No Title',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.green[800],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
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