import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'berita.dart'; // Import kelas Berita

class DetailBeritaPage extends StatelessWidget {
  final Berita berita;

  const DetailBeritaPage({required this.berita, super.key});

  @override
  Widget build(BuildContext context) {
    String formatTanggal(String dateString) {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(dateTime);
    }

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 2 / 5,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                // title: Text(berita.judul ?? ""),
                background: berita.media != null && berita.media!.isNotEmpty
                    ? Image.network(
                        'https://demo.amoratours.id/${berita.media}',
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        'https://media.istockphoto.com/id/1369150014/id/vektor/breaking-news-dengan-latar-belakang-peta-dunia-vektor.jpg?s=612x612&w=0&k=20&c=SpV6nFq1Zf7Gh7qPCESEP6h3eS4fdBc3IO71M5Of18Y=',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),             
                Row(
                  children: [
                    Icon(Icons.person, size: 12),
                    SizedBox(width: 4),
                    Text('by: ${berita.namaWriter}', style: TextStyle(fontSize: 12),),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12),
                    SizedBox(width: 4),
                    Text(formatTanggal(berita.created_at),style: TextStyle(fontSize: 12),),
                  ],
                ),
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
        ),
      ),
    );
  }
}
