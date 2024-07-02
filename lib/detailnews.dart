import 'package:flutter/material.dart';
import 'berita.dart'; // Import kelas Berita

class DetailBeritaPage extends StatelessWidget {
  final Berita berita;

  const DetailBeritaPage({required this.berita, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(berita.judul),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   berita.judul,
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: 8),
            Text('Penulis: ${berita.namaWriter}'),
            SizedBox(height: 8),
            Image.network('https://demo.amoratours.id/${berita.media}',
                height: 200, width: 200),
            SizedBox(height: 16),
            Text(berita.isi),
            SizedBox(height: 16),
            Text('Kategori: ${berita.kategori}'),
            SizedBox(height: 16),
            Text('Tag: ${berita.tag}'),
            
          ],
        ),
      ),
    );
  }
}
