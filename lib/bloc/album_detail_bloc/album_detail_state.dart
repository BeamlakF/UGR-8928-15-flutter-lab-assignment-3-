// bloc/album_detail_bloc/album_detail_state.dart
import '../../model/album.dart';
import '../../model/photo.dart';

abstract class AlbumDetailState {}

class AlbumDetailInitial extends AlbumDetailState {}

class AlbumDetailLoadInProgress extends AlbumDetailState {}

class AlbumDetailLoadSuccess extends AlbumDetailState {
  final Album album;
  final List<Photo> photos;

  AlbumDetailLoadSuccess(this.album, this.photos);
}

class AlbumDetailLoadFailure extends AlbumDetailState {}
