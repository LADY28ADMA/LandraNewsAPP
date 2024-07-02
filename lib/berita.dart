import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

import 'package:myapp/detailnews.dart';
import 'package:myapp/service/api_service.dart';

class Berita {
  final int id;
  final String namaWriter;
  final String judul;
  final String tag;
  final String isi;
  final String kategori;
  final String created_at;
  final String? media;

  Berita({
    required this.id,
    required this.namaWriter,
    required this.judul,
    required this.tag,
    required this.isi,
    required this.kategori,
    required this.created_at,
    this.media,
  });

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      id: json['id'] as int,
      namaWriter: json['nama_writer'] as String,
      judul: json['judul'] as String,
      tag: json['tag'] as String,
      isi: json['isi'] as String,
      kategori: json['kategori'] as String,
      created_at: json['created_at'] as String,
      media: json['media'] as String?,
    );
  }
}

class BeritaPage extends StatefulWidget {
  final String endpoint;

  const BeritaPage({required this.endpoint, super.key});

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  late Future<List<Berita>> _beritasFuture;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _beritasFuture = apiService.fetchBerita(widget.endpoint);
  }

  Future<void> _refreshBerita() async {
    setState(() {
      _beritasFuture = apiService.fetchBerita(widget.endpoint);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshBerita,
        child: FutureBuilder<List<Berita>>(
          future: _beritasFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada berita.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final berita = snapshot.data![index];
                  return ListTile(
                    title: Text(berita.judul),
                    subtitle: Text(berita.created_at),
                    leading: berita.media != null && berita.media!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                                'https://demo.amoratours.id/${berita.media}',
                                width: 100,
                                height: 130,
                                fit: BoxFit.fitHeight))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                                'https://media.istockphoto.com/id/1369150014/id/vektor/breaking-news-dengan-latar-belakang-peta-dunia-vektor.jpg?s=612x612&w=0&k=20&c=SpV6nFq1Zf7Gh7qPCESEP6h3eS4fdBc3IO71M5Of18Y=',
                                width: 100,
                                height: 130,
                                fit: BoxFit.cover)),
                    trailing: const Icon(Icons.read_more_outlined),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailBeritaPage(berita: berita),
                        ),
                      );
                    },
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
