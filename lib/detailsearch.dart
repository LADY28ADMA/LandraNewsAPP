import 'package:flutter/material.dart';
import 'package:myapp/berita.dart';

class DetailSearchPage extends StatelessWidget {
  final Berita berita;

  const DetailSearchPage({required this.berita, super.key});

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
            Text(
              berita.judul,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Penulis: ${berita.namaWriter}'),
            const SizedBox(height: 8),
            Image.network('https://demo.amoratours.id/${berita.media}'),
            const SizedBox(height: 16),
            Text(berita.isi),
          ],
        ),
      ),
    );
  }
}