// models/video_model.dart
import 'dart:convert';

class VideoResult {
  int id;
  List<Video> videos;

  VideoResult({
    required this.id,
    required this.videos,
  });

  factory VideoResult.fromRawJson(String str) =>
      VideoResult.fromJson(json.decode(str));

  factory VideoResult.fromJson(Map<String, dynamic> json) => VideoResult(
        id: json["id"],
        videos: List<Video>.from(json["results"].map((x) => Video.fromJson(x))),
      );
}

class Video {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;
  bool official;
  DateTime publishedAt;

  Video({
    required this.id,
    required this.iso6391,
    required this.iso31661,
    required this.key,
    required this.name,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
  });

  factory Video.fromRawJson(String str) => Video.fromJson(json.decode(str));

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"] ?? '',
        iso6391: json["iso_639_1"] ?? '',
        iso31661: json["iso_3166_1"] ?? '',
        key: json["key"] ?? '',
        name: json["name"] ?? '',
        site: json["site"] ?? '',
        size: json["size"] ?? 0,
        type: json["type"] ?? '',
        official: json["official"] ?? false,
        publishedAt: json["published_at"] != null
            ? DateTime.parse(json["published_at"])
            : DateTime.now(),
      );
}
