import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/pages/lifestylescreen.dart';
import 'package:myapp/pages/morescreen.dart';
import 'dart:convert';
import 'berita.dart';
import 'detailsearch.dart';

class BeritaMainPage extends StatelessWidget {
  const BeritaMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BRRREEKING🥶 NEWS'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.deepPurple,
            // indicator: UnderlineTabIndicator(insets: EdgeInsets.all(5)),
            tabs: [
              Tab(text: 'Terbaru'),
              Tab(text: 'Lifestyle'),
              Tab(text: 'More'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BeritaPage(endpoint: 'http://demo.amoratours.id/api/newss/alfeeds',),
            LifestylePage(),
            MorePage(),
          ],
        ),
      ),
    );
  }
}



class CustomSearchDelegate extends SearchDelegate<String> {
  Future<List<Berita>> _searchBerita(String query) async {
    final response = await http.post(
      Uri.parse('https://demo.amoratours.id/api/newss/serc'),
      body: {'query': query},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Berita.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Berita>>(
      future: _searchBerita(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Tidak ada hasil pencarian.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final berita = snapshot.data![index];
              return ListTile(
                title: Text(berita.judul),
                subtitle: Text(berita.isi),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailSearchPage(berita: berita),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text('Masukkan kata kunci pencarian'));
  }
}


