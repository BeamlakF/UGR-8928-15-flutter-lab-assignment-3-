import 'package:go_router/go_router.dart';
import '../screens/album_list_screen.dart';
import '../screens/album_detail_screen.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AlbumListScreen(),
        routes: [
          GoRoute(
            path: 'details/:id',
            builder: (context, state) {
              final albumId = int.parse(state.pathParameters['id']!);
              return AlbumDetailScreen(albumId: albumId);
            },
          ),
        ],
      ),
    ],
  );
}
