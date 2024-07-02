import 'package:flutter/material.dart';
import 'package:myapp/berita.dart';
// import 'berita.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BeritaPage(endpoint: 'http://demo.amoratours.id/api/newss/nonlefst');
  }
}
