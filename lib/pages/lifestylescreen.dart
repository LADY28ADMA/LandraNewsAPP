import 'package:flutter/material.dart';
import 'package:myapp/berita.dart';
// import 'berita.dart';

class LifestylePage extends StatelessWidget {
  const LifestylePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BeritaPage(endpoint: 'http://demo.amoratours.id/api/newss/lefstel');
  }
}
