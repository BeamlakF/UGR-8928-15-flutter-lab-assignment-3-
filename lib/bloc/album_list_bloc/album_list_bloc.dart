import 'package:flutter_bloc/flutter_bloc.dart';
import 'album_list_event.dart';
import 'album_list_state.dart';
import '../../repository/album_repository.dart';

class AlbumListBloc extends Bloc<AlbumListEvent, AlbumListState> {
  final AlbumRepository repository;

  AlbumListBloc({required this.repository}) : super(AlbumListInitial()) {
    on<AlbumListRequested>(_onRequested);
  }

  Future<void> _onRequested(
      AlbumListRequested event,
      Emitter<AlbumListState> emit,
      ) async {
    emit(AlbumListLoading());
    try {
      final albums = await repository.getAlbums();
      emit(AlbumListSuccess(albums));
    } catch (e) {
      emit(AlbumListFailure(e.toString()));
    }
  }
}
