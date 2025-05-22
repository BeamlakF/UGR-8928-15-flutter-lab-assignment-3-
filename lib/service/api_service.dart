// service/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/album.dart';
import '../model/photo.dart';

class AlbumService {
  final http.Client httpClient;

  AlbumService({required this.httpClient});

  Future<List<Album>> fetchAlbums() async {
    final response = await httpClient.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<Album> fetchAlbumById(int id) async {
    final response = await httpClient.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    );

    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Photo>> fetchPhotosByAlbumId(int albumId) async {
    final response = await httpClient.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos?albumId=$albumId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
