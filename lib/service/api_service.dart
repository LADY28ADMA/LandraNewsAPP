import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:myapp/berita.dart';
// import 'berita.dart';

class ApiService {
  Future<List<Berita>> fetchBerita(String endpoint) async {
    final res = await http.get(Uri.parse(endpoint));
    if (res.statusCode == 200) {
      final decodedData = jsonDecode(res.body) as List<dynamic>;
      return decodedData.map((e) => Berita.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load beritas');
    }
  }
}
