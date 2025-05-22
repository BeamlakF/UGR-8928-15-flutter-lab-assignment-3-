// bloc/album_detail_bloc/album_detail_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/album_repository.dart';
import 'album_detail_event.dart';
import 'album_detail_state.dart';

class AlbumDetailBloc extends Bloc<AlbumDetailEvent, AlbumDetailState> {
  final AlbumRepository repository;

  AlbumDetailBloc(this.repository) : super(AlbumDetailInitial()) {
    on<AlbumDetailRequested>((event, emit) async {
      emit(AlbumDetailLoadInProgress());
      try {
        final album = await repository.getAlbumById(event.albumId);
        final photos = await repository.getPhotosByAlbumId(event.albumId);
        emit(AlbumDetailLoadSuccess(album, photos));
      } catch (_) {
        emit(AlbumDetailLoadFailure());
      }
    });
  }
}
