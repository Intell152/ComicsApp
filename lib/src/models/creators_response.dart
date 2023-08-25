import 'dart:convert';

class CreatorsResponse {
  CreatorData data;

  CreatorsResponse({
    required this.data,
  });

  factory CreatorsResponse.fromJson(String str) =>
      CreatorsResponse.fromMap(json.decode(str));

  factory CreatorsResponse.fromMap(Map<String, dynamic> json) =>
      CreatorsResponse(
        data: CreatorData.fromMap(json["data"]),
      );
}

class CreatorData {
  List<Creator> results;

  CreatorData({
    required this.results,
  });

  factory CreatorData.fromJson(String str) =>
      CreatorData.fromMap(json.decode(str));

  factory CreatorData.fromMap(Map<String, dynamic> json) => CreatorData(
        results:
            List<Creator>.from(json["results"].map((x) => Creator.fromMap(x))),
      );
}

class Creator {
  String name;
  CreatorThumbnail thumbnail;

  Creator({
    required this.name,
    required this.thumbnail,
  });

  get getCreatorPath {
    late String path;

    try {
      path = '${thumbnail.path}/detail.${thumbnail.extension}';
    } catch (e) {
      path =
          'http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/detail.jpg';
    }

    return path;
  }

  factory Creator.fromJson(String str) => Creator.fromMap(json.decode(str));

  factory Creator.fromMap(Map<String, dynamic> json) => Creator(
        name: json["fullName"],
        thumbnail: CreatorThumbnail.fromMap(json["thumbnail"]),
      );
}

class CreatorThumbnail {
  String path;
  String extension;

  CreatorThumbnail({
    required this.path,
    required this.extension,
  });

  factory CreatorThumbnail.fromJson(String str) =>
      CreatorThumbnail.fromMap(json.decode(str));

  factory CreatorThumbnail.fromMap(Map<String, dynamic> json) =>
      CreatorThumbnail(
        path: json["path"],
        extension: json["extension"],
      );
}
