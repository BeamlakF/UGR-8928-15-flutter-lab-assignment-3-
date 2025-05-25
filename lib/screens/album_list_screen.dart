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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: InkWell(
                      onTap: () => context.push('/album/${album.id}'),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            // 1/10 for image
                            Expanded(
                              flex: 1,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: album.thumbnailUrl != null && album.thumbnailUrl!.isNotEmpty
                                      ? Image.network(
                                    album.thumbnailUrl!,
                                    fit: BoxFit.cover,
                                  )
                                      : const Icon(Icons.image_not_supported),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // 9/10 for text
                            Expanded(
                              flex: 9,
                              child: Text(
                                album.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
