import 'package:flutter/material.dart';
import 'package:myapp/berita.dart';

class DetailSearchPage extends StatelessWidget {
  final Berita berita;

  const DetailSearchPage({required this.berita, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          berita.judul,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              berita.media!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://demo.amoratours.id/${berita.media}',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 2 / 5,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://media.istockphoto.com/id/1369150014/id/vektor/breaking-news-dengan-latar-belakang-peta-dunia-vektor.jpg?s=612x612&w=0&k=20&c=SpV6nFq1Zf7Gh7qPCESEP6h3eS4fdBc3IO71M5Of18Y=',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://media.istockphoto.com/id/1369150014/id/vektor/breaking-news-dengan-latar-belakang-peta-dunia-vektor.jpg?s=612x612&w=0&k=20&c=SpV6nFq1Zf7Gh7qPCESEP6h3eS4fdBc3IO71M5Of18Y=',
                        fit: BoxFit.cover,
                      ),
                    ),
              const SizedBox(height: 16),
              Text(berita.isi),
            ],
          ),
        ),
      ),
    );
  }
}
