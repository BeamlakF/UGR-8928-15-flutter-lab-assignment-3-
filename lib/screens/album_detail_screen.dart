// screens/album_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/album_detail_bloc/album_detail_bloc.dart';
import '../bloc/album_detail_bloc/album_detail_event.dart';
import '../bloc/album_detail_bloc/album_detail_state.dart';

class AlbumDetailScreen extends StatelessWidget {
  final int albumId;

  const AlbumDetailScreen({required this.albumId, super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AlbumDetailBloc>().add(AlbumDetailRequested(albumId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(), // GoRouter back navigation
        ),
      ),
      body: BlocBuilder<AlbumDetailBloc, AlbumDetailState>(
        builder: (context, state) {
          if (state is AlbumDetailLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumDetailLoadSuccess) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.album.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: state.photos.length,
                    itemBuilder: (context, index) {
                      final photo = state.photos[index];
                      return GestureDetector(
                        onTap: () {
                          // Optional: Show full photo in a dialog or new page
                        },
                        child: Image.network(photo.thumbnailUrl, fit: BoxFit.cover),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is AlbumDetailLoadFailure) {
            return const Center(child: Text('Failed to load album details.'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
