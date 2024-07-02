import 'package:flutter/material.dart';
import 'berita.dart';

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
              // Tampilkan kotak pencarian di sini
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Terbaru'),
              Tab(text: 'Lifestyle'),
              Tab(text: 'More'),
            ],
          ),
        ),
        
        body: const TabBarView(
          children: [
            BeritaPage(), // Halaman Terbaru
            LifestylePage(), // Halaman Lifestyle
            MorePage(), // Halaman >
          ],
        ),
      ),
    );
  }
}

class LifestylePage extends StatelessWidget {
  const LifestylePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Lifestyle Page'),
    );
  }
}

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('More Page'),
    );
  }
}


class CustomSearchDelegate extends SearchDelegate<String> {
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
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implementasi hasil pencarian di sini
    return Center(
      child: Text('Hasil Pencarian: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implementasi saran pencarian di sini
    return Center(
      child: Text('Saran Pencarian'),
    );
  }
}