import 'package:flutter_bloc/flutter_bloc.dart';
import 'album_list_event.dart';
import 'album_list_state.dart';
import '../../repository/album_repository.dart';
import '../../model/photo.dart';


class AlbumListBloc extends Bloc<AlbumListEvent, AlbumListState> {
  final AlbumRepository repository;

  AlbumListBloc({required this.repository}) : super(AlbumListInitial()) {
    on<AlbumListRequested>(_onRequested);
  }

  Future<void> _onRequested(
      AlbumListRequested event, Emitter<AlbumListState> emit) async {
    emit(AlbumListLoading());
    try {
      final albums = await repository.getAlbums();
      final photos = await repository.getPhotos();

      // Map the first photo for each album
      final Map<int, Photo> albumPhotoMap = {};
      for (var photo in photos) {
        if (!albumPhotoMap.containsKey(photo.albumId)) {
          albumPhotoMap[photo.albumId] = photo;
        }
      }

      // Attach the thumbnailUrl to the album (assuming you modify Album model accordingly)
      final enrichedAlbums = albums.map((album) {
        final photo = albumPhotoMap[album.id];
        return album.copyWith(thumbnailUrl: photo?.thumbnailUrl ?? '');
      }).toList();

      emit(AlbumListSuccess(enrichedAlbums));
    } catch (e) {
      emit(AlbumListFailure(e.toString()));
    }
  }
}
