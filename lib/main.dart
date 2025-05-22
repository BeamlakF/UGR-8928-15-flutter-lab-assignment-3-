import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'repository/album_repository.dart';
import 'service/api_service.dart';
import 'bloc/album_list_bloc/album_list_bloc.dart';
import 'bloc/album_detail_bloc/album_detail_bloc.dart';
import 'bloc/album_list_bloc/album_list_event.dart';
import 'screens/album_list_screen.dart';
import 'screens/album_detail_screen.dart';

void main() {
  final repository = AlbumRepository(
    albumService: AlbumService(httpClient: http.Client()),
  );

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final AlbumRepository repository;

  const MyApp({required this.repository, super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AlbumListScreen(),
        ),
        GoRoute(
          path: '/album/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '');
            if (id == null) {
              return const Scaffold(
                body: Center(child: Text('Invalid album ID')),
              );
            }
            return AlbumDetailScreen(albumId: id);
          },
        ),
      ],
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
          AlbumListBloc(repository: repository)..add(AlbumListRequested()),
        ),
        BlocProvider(
          create: (_) => AlbumDetailBloc(repository),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Album Viewer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
