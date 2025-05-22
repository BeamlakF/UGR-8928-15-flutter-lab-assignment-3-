import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/album_list_bloc/album_list_bloc.dart';
import '../bloc/album_list_bloc/album_list_event.dart';
import '../bloc/album_list_bloc/album_list_state.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocBuilder<AlbumListBloc, AlbumListState>(
        builder: (context, state) {
          if (state is AlbumListInitial) {
            context.read<AlbumListBloc>().add(AlbumListRequested());
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumListSuccess) {
            final albums = state.albums;
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return ListTile(
                  title: Text(album.title),
                  onTap: () {
                    // Push the detail screen onto the stack
                    context.push('/album/${album.id}');
                  },
                );
              },
            );
          } else if (state is AlbumListFailure) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
