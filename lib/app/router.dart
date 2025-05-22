import 'package:flutter/material.dart';
import '../presentation/screens/album_list_screen.dart';
import '../presentation/screens/album_detail_screen.dart';
import '../data/models/album_model.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const AlbumListScreen());

    case '/album-detail':
      final args = settings.arguments as Map<String, dynamic>;
      final album = args['album'] as Album;
      final photoUrl = args['photoUrl'] as String;

      return MaterialPageRoute(
        builder: (_) => AlbumDetailScreen(album: album, photoUrl: photoUrl),
      );

    default:
      return MaterialPageRoute(
        builder:
            (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
      );
  }
}
