import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:myapp/detailnews.dart';

class Berita {
  final int id;
  final String namaWriter;
  final String judul;
  final String tag;
  final String isi;
  final String kategori;
  final String media;

  Berita({
    required this.id,
    required this.namaWriter,
    required this.judul,
    required this.tag,
    required this.isi,
    required this.kategori,
    required this.media,
  });

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      id: json['id'] as int,
      namaWriter: json['nama_writer'] as String,
      judul: json['judul'] as String,
      tag: json['tag'] as String,
      isi: json['isi'] as String,
      kategori: json['kategori'] as String,
      media: json['media'] as String,
    );
  }
}

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  late Future<List<Berita>> _beritasFuture;

  @override
  void initState() {
    super.initState();
    _beritasFuture = _fetchBerita();
  }

  Future<List<Berita>> _fetchBerita() async {
    final res =
        await http.get(Uri.parse('http://demo.amoratours.id/api/newss/feeds'));
    if (res.statusCode == 200) {
      final decodedData = jsonDecode(res.body) as List<dynamic>;
      return decodedData.map((e) => Berita.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load beritas');
    }
  }

  Future<void> _refreshBerita() async {
    setState(() {
      _beritasFuture = _fetchBerita();
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
              return const Center(
                  child:
                      CircularProgressIndicator()); // Tampilkan loading spinner
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
                    subtitle: Text(berita.isi),
                    leading: Image.network(
                        'https://demo.amoratours.id/${berita.media}'),
                    trailing: Text(berita.tag),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBeritaPage(berita: berita),
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
