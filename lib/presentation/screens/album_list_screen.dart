import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/album_bloc.dart';
import '../blocs/album_event.dart';
import '../blocs/album_state.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Albums',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 78, 42, 141),
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AlbumBloc>().add(FetchAlbums());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text("Retry"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 78, 42, 141),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is AlbumLoaded) {
            if (state.albums.isEmpty) {
              return const Center(
                child: Text(
                  "No albums available.",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                itemCount: state.albums.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final album = state.albums[index];
                  final photo = state.photos.firstWhere(
                    (p) => p.albumId == album.id,
                    orElse: () => state.photos[index],
                  );

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          photo.thumbnailUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.image),
                        ),
                      ),
                      title: Text(
                        album.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onTap: () {
                        context.push(
                          '/album-detail',
                          extra: {'album': album, 'photoUrl': photo.url},
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
