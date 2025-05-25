class Album {
  final int id;
  final int userId;
  final String title;
  final String? thumbnailUrl;

  Album({
    required this.id,
    required this.userId,
    required this.title,
    this.thumbnailUrl,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
    );
  }

  Album copyWith({
    int? id,
    int? userId,
    String? title,
    String? thumbnailUrl,
  }) {
    return Album(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }
}
