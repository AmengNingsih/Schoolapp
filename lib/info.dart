import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  // Fungsi untuk mengambil data dari API
  Future<List<dynamic>> fetchInfo() async {
    final response = await http.get(
        Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=informasi'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal memuat informasi');
    }
  }

  // Fungsi untuk menambah data
  void _addData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String judul = '';
        String isi = '';
        String tanggal = '';
        
        return AlertDialog(
          title: Text('Tambah Data', style: TextStyle(color: Colors.green[800])),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Judul Informasi',
                  labelStyle: TextStyle(color: Colors.green[800]),
                ),
                onChanged: (value) => judul = value,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Isi Informasi',
                  labelStyle: TextStyle(color: Colors.green[800]),
                ),
                onChanged: (value) => isi = value,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Tanggal Post',
                  labelStyle: TextStyle(color: Colors.green[800]),
                ),
                onChanged: (value) => tanggal = value,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal', style: TextStyle(color: Colors.green[800])),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Simpan', style: TextStyle(color: Colors.green[800])),
              onPressed: () async {
                final response = await http.post(
                  Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=informasi'),
                  body: json.encode({
                    'judul_info': judul,
                    'isi_info': isi,
                    'tgl_post_info': tanggal,
                    'status_info': '1',
                    'kd_petugas': '1'
                  }),
                  headers: {'Content-Type': 'application/json'},
                );
                
                if (response.statusCode == 200) {
                  Navigator.of(context).pop();
                  setState(() {});
                } else {
                  // Tampilkan pesan error
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk mengupdate data
  void _updateData(Map<String, dynamic> info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String judul = info['judul_info'];
        String isi = info['isi_info'];
        String tanggal = info['tgl_post_info'];
        
        return AlertDialog(
          title: Text('Update Data', style: TextStyle(color: Colors.green[800])),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Judul Informasi',
                  labelStyle: TextStyle(color: Colors.green[800]),
                ),
                onChanged: (value) => judul = value,
                controller: TextEditingController(text: judul),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Isi Informasi',
                  labelStyle: TextStyle(color: Colors.green[800]),
                ),
                onChanged: (value) => isi = value,
                controller: TextEditingController(text: isi),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Tanggal Post',
                  labelStyle: TextStyle(color: Colors.green[800]),
                ),
                onChanged: (value) => tanggal = value,
                controller: TextEditingController(text: tanggal),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal', style: TextStyle(color: Colors.green[800])),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Simpan', style: TextStyle(color: Colors.green[800])),
              onPressed: () async {
                final response = await http.put(
                  Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=informasi'),
                  body: json.encode({
                    'kd_info': info['kd_info'],
                    'judul_info': judul,
                    'isi_info': isi,
                    'tgl_post_info': tanggal,
                    'status_info': info['status_info'],
                    'kd_petugas': info['kd_petugas']
                  }),
                  headers: {'Content-Type': 'application/json'},
                );
                
                if (response.statusCode == 200) {
                  Navigator.of(context).pop();
                  setState(() {});
                } else {
                  // Tampilkan pesan error
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menghapus data
  void _deleteData(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Data', style: TextStyle(color: Colors.green[800])),
          content: Text('Apakah Anda yakin ingin menghapus data ini?', style: TextStyle(color: Colors.green[800])),
          actions: <Widget>[
            TextButton(
              child: Text('Batal', style: TextStyle(color: Colors.green[800])),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Hapus', style: TextStyle(color: Colors.green[800])),
              onPressed: () async {
                final response = await http.delete(
                  Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=informasi&kd_info=$id'),
                );
                
                if (response.statusCode == 200) {
                  Navigator.of(context).pop();
                  setState(() {});
                } else {
                  // Tampilkan pesan error
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menampilkan detail informasi
  void _showInfoDetail(Map<String, dynamic> info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(info['judul_info'], style: TextStyle(color: Colors.green[800])),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Deskripsi:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[800])),
              Text(info['isi_info'], style: TextStyle(color: Colors.green[800])),
              SizedBox(height: 10),
              Text('Tanggal Post:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[800])),
              Text(info['tgl_post_info'], style: TextStyle(color: Colors.green[800])),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tutup', style: TextStyle(color: Colors.green[800])),
              onPressed: () => Navigator.of(context).pop(),
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
          title: Text('Informasi', style: TextStyle(color: Colors.green[800])),
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
        body: FutureBuilder<List<dynamic>>(
          future: fetchInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: Colors.green[800]));
            } else if (snapshot.hasError) {
              return Center(child: Text('Gagal memuat data', style: TextStyle(color: Colors.green[800])));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Tidak ada data', style: TextStyle(color: Colors.green[800])));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var info = snapshot.data![index];
                  return ListTile(
                    title: Text(info['judul_info'], style: TextStyle(color: Colors.green[800])),
                    subtitle: Text(info['tgl_post_info'], style: TextStyle(color: Colors.green[800])),
                    onTap: () => _showInfoDetail(info),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green[800]),
                          onPressed: () => _updateData(info),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.green[800]),
                          onPressed: () => _deleteData(info['kd_info']),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}