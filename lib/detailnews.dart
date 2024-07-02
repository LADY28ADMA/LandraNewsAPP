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
            berita.media != null && berita.media!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                        'https://demo.amoratours.id/${berita.media}',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 2 / 5,
                        fit: BoxFit.fitHeight))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                        'https://media.istockphoto.com/id/1369150014/id/vektor/breaking-news-dengan-latar-belakang-peta-dunia-vektor.jpg?s=612x612&w=0&k=20&c=SpV6nFq1Zf7Gh7qPCESEP6h3eS4fdBc3IO71M5Of18Y=',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 2 / 5,
                        fit: BoxFit.cover)),
            SizedBox(height: 16),
            Text(berita.created_at),
            SizedBox(height: 16),
            Text(berita.isi),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.category, size: 16),
                    SizedBox(width: 4),
                    Text(berita.kategori),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.tag, size: 16),
                    SizedBox(width: 4),
                    Text(berita.tag),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
