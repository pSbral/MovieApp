// credits_model.dart
import 'dart:convert';

class Credits {
  int id;
  List<Cast> cast;
  List<Crew> crew;

  Credits({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory Credits.fromRawJson(String str) => Credits.fromJson(json.decode(str));

  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
      );
}

class Cast {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Cast({
    required this.castId,
    required this.character,
    required this.creditId,
    required this.gender,
    required this.id,
    required this.name,
    required this.order,
    required this.profilePath,
  });

  factory Cast.fromRawJson(String str) => Cast.fromJson(json.decode(str));

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        castId: json["cast_id"] ?? 0,
        character: json["character"] ?? '',
        creditId: json["credit_id"] ?? '',
        gender: json["gender"] ?? 0,
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        order: json["order"] ?? 0,
        profilePath: json["profile_path"] ?? '',
      );
}

class Crew {
  String creditId;
  String department;
  int gender;
  int id;
  String job;
  String name;
  String profilePath;

  Crew({
    required this.creditId,
    required this.department,
    required this.gender,
    required this.id,
    required this.job,
    required this.name,
    required this.profilePath,
  });

  factory Crew.fromRawJson(String str) => Crew.fromJson(json.decode(str));

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        creditId: json["credit_id"] ?? '',
        department: json["department"] ?? '',
        gender: json["gender"] ?? 0,
        id: json["id"] ?? 0,
        job: json["job"] ?? '',
        name: json["name"] ?? '',
        profilePath: json["profile_path"] ?? '',
      );
}
