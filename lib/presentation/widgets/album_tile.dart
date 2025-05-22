import 'package:flutter/material.dart';
import '../../data/models/album_model.dart';

class AlbumTile extends StatelessWidget {
  final Album album;
  final String thumbnailUrl;
  final VoidCallback onTap;

  const AlbumTile({
    super.key,
    required this.album,
    required this.thumbnailUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        thumbnailUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const SizedBox(
            width: 50,
            height: 50,
            child: Icon(Icons.broken_image, color: Colors.grey),
          );
        },
      ),
      title: Text(album.title),
      onTap: onTap,
    );
  }
}
