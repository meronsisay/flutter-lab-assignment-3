import '../../domain/album_repository.dart';
import '../models/album_model.dart';
import '../models/photo_model.dart';
import '../datasource/api_service.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final ApiService apiService;

  AlbumRepositoryImpl(this.apiService);

  @override
  Future<List<Album>> getAlbums() {
    return apiService.fetchAlbums();
  }

  @override
  Future<List<Photo>> getPhotos() {
    return apiService.fetchPhotos();
  }
}
