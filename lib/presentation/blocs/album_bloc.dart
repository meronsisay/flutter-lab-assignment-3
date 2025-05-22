import 'package:flutter_bloc/flutter_bloc.dart';
import 'album_event.dart';
import 'album_state.dart';
import '../../domain/album_repository.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;

  AlbumBloc(this.repository) : super(AlbumInitial()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumLoading());

      try {
        final albums = await repository.getAlbums();
        final photos = await repository.getPhotos();

        emit(AlbumLoaded(albums: albums, photos: photos));
      } catch (e) {
        emit(AlbumError("Failed to fetch albums: ${e.toString()}"));
      }
    });
  }
}
