import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String source;
  final String url;

  const MyCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.source,
    required this.url,
  });

  void _launchURL(BuildContext context) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal membuka link')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _launchURL(context),
        child: Column(
          children: [
            // Gambar
            imageUrl.isNotEmpty
                ? Image.network(
              imageUrl,
              height: 127,
              width: double.infinity,
              fit: BoxFit.cover,
            ) : Container(
              height: 127,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Icon(Icons.image_not_supported, size: 48),
            ),
            // Konten teks
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
