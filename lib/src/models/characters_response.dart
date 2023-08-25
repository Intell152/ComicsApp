import 'dart:convert';

class CharactersResponse {
  CharacterData data;

  CharactersResponse({
    required this.data,
  });

  factory CharactersResponse.fromJson(String str) =>
      CharactersResponse.fromMap(json.decode(str));

  factory CharactersResponse.fromMap(Map<String, dynamic> json) =>
      CharactersResponse(
        data: CharacterData.fromMap(json["data"]),
      );
}

class CharacterData {
  List<Character> results;

  CharacterData({
    required this.results,
  });

  factory CharacterData.fromJson(String str) => CharacterData.fromMap(json.decode(str));

  factory CharacterData.fromMap(Map<String, dynamic> json) => CharacterData(
        results: List<Character>.from(
            json["results"].map((x) => Character.fromMap(x))),
      );
}

class Character {
  int id;
  String name;
  String description;
  String modified;
  CThumbnail thumbnail;
  String resourceUri;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.modified,
    required this.thumbnail,
    required this.resourceUri,
  });

  get getCharacterPath {
    late String path;

    try {
      path = '${thumbnail.path}/detail.${thumbnail.extension}';
    } catch (e) {
      path =
          'http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/detail.jpg';
    }

    return path;
  }

  factory Character.fromJson(String str) => Character.fromMap(json.decode(str));

  factory Character.fromMap(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        modified: json["modified"],
        thumbnail: CThumbnail.fromMap(json["thumbnail"]),
        resourceUri: json["resourceURI"],
      );
}

class CThumbnail {
  String path;
  CExtension extension;

  CThumbnail({
    required this.path,
    required this.extension,
  });

  factory CThumbnail.fromJson(String str) => CThumbnail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CThumbnail.fromMap(Map<String, dynamic> json) => CThumbnail(
        path: json["path"],
        extension: cextensionValues.map[json["extension"]]!,
      );

  Map<String, dynamic> toMap() => {
        "path": path,
        "extension": cextensionValues.reverse[extension],
      };
}

// ignore: constant_identifier_names
enum CExtension { JPG }

final cextensionValues = CEnumValues({"jpg": CExtension.JPG});

class CEnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  CEnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
