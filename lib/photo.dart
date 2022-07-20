class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl']);
  }
}

class Album {
  final List<Photo> photos;

  Album({required this.photos});

  factory Album.fromJson(List<dynamic> parseJson) {
    List<Photo> _photos = <Photo>[];
    _photos = parseJson.map((i) => Photo.fromJson(i)).toList();
    return Album(photos: _photos);
  }
}
