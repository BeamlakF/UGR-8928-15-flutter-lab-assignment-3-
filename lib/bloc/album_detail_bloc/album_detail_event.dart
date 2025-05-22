// bloc/album_detail_bloc/album_detail_event.dart
abstract class AlbumDetailEvent {}

class AlbumDetailRequested extends AlbumDetailEvent {
  final int albumId;
  AlbumDetailRequested(this.albumId);
}
