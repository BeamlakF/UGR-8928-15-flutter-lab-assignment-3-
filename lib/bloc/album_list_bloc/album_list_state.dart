import 'package:equatable/equatable.dart';
import '../../model/album.dart';

abstract class AlbumListState extends Equatable {
  const AlbumListState();

  @override
  List<Object?> get props => [];
}

class AlbumListInitial extends AlbumListState {}

class AlbumListLoading extends AlbumListState {}

class AlbumListSuccess extends AlbumListState {
  final List<Album> albums;

  const AlbumListSuccess(this.albums);

  @override
  List<Object?> get props => [albums];
}

class AlbumListFailure extends AlbumListState {
  final String message;

  const AlbumListFailure(this.message);

  @override
  List<Object?> get props => [message];
}
