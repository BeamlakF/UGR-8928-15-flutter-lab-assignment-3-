// repository/album_repository.dart
import '../model/album.dart';
import '../model/photo.dart';
import '../service/api_service.dart';

class AlbumRepository {
  final AlbumService albumService;

  AlbumRepository({required this.albumService});

  Future<List<Album>> getAlbums() {
    return albumService.fetchAlbums();
  }

  Future<Album> getAlbumById(int id) {
    return albumService.fetchAlbumById(id);
  }

  Future<List<Photo>> getPhotosByAlbumId(int albumId) {
    return albumService.fetchPhotosByAlbumId(albumId);
  }
}
