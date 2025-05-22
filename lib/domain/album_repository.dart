import '../../data/models/album_model.dart';
import '../../data/models/photo_model.dart';

abstract class AlbumRepository {
  Future<List<Album>> getAlbums();
  Future<List<Photo>> getPhotos();
}
