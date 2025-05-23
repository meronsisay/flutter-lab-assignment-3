import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/screens/album_list_screen.dart';
import '../presentation/screens/album_detail_screen.dart';
import '../data/models/album_model.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AlbumListScreen()),
    GoRoute(
      path: '/album-detail',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        final Album album = args['album'];
        final String photoUrl = args['photoUrl'];

        return AlbumDetailScreen(album: album, photoUrl: photoUrl);
      },
    ),
  ],
);
