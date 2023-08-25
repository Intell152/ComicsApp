import 'dart:convert';

class Comic {
  int id;
  String? heroid;
  int digitalId;
  String title;
  int issueNumber;
  String variantDescription;
  String? description;
  String modified;
  // Isbn isbn;
  String upc;
  // DiamondCode diamondCode;
  String ean;
  String issn;
  // Format format;
  int pageCount;
  List<TextObject> textObjects;
  String resourceUri;
  List<Url> urls;
  List<Date> dates;
  List<Price> prices;
  Thumbnail thumbnail;
  List<Thumbnail> images;
  Creators creators;
  Characters characters;

  Comic({
    required this.id,
    this.heroid,
    required this.digitalId,
    required this.title,
    required this.issueNumber,
    required this.variantDescription,
    this.description,
    required this.modified,
    required this.upc,
    required this.ean,
    required this.issn,
    required this.pageCount,
    required this.textObjects,
    required this.resourceUri,
    required this.urls,
    required this.dates,
    required this.prices,
    required this.thumbnail,
    required this.images,
    required this.creators,
    required this.characters,
  });

  get getpath {
    late String path;

    try {
      path = '${images[0].path}/detail.${images[0].extension}';
    } catch (e) {
      path =
          'http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/detail.jpg';
    }

    return path;
  }

  get getThumbnailPath {
    late String path;

    try {
      path = '${thumbnail.path}/detail.${thumbnail.extension}';
    } catch (e) {
      path =
          'http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/detail.jpg';
    }

    return path;
  }

  factory Comic.fromJson(String str) => Comic.fromMap(json.decode(str));

  factory Comic.fromMap(Map<String, dynamic> json) => Comic(
        id: json["id"],
        digitalId: json["digitalId"],
        title: json["title"],
        issueNumber: json["issueNumber"],
        variantDescription: json["variantDescription"],
        description: json["description"],
        modified: json["modified"],
        upc: json["upc"],
        ean: json["ean"],
        issn: json["issn"],
        pageCount: json["pageCount"],
        textObjects: List<TextObject>.from(
            json["textObjects"].map((x) => TextObject.fromMap(x))),
        resourceUri: json["resourceURI"],
        urls: List<Url>.from(json["urls"].map((x) => Url.fromMap(x))),
        dates: List<Date>.from(json["dates"].map((x) => Date.fromMap(x))),
        prices: List<Price>.from(json["prices"].map((x) => Price.fromMap(x))),
        thumbnail: Thumbnail.fromMap(json["thumbnail"]),
        images: List<Thumbnail>.from(
            json["images"].map((x) => Thumbnail.fromMap(x))),
        creators: Creators.fromMap(json["creators"]),
        characters: Characters.fromMap(json["characters"]),
      );
}

class Characters {
  int available;
  String collectionUri;
  int returned;

  Characters({
    required this.available,
    required this.collectionUri,
    required this.returned,
  });

  factory Characters.fromJson(String str) =>
      Characters.fromMap(json.decode(str));

  factory Characters.fromMap(Map<String, dynamic> json) => Characters(
        available: json["available"],
        collectionUri: json["collectionURI"],
        returned: json["returned"],
      );
}

class Creators {
  int available;
  String collectionUri;
  List<CreatorsItem> items;
  int returned;

  Creators({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  factory Creators.fromJson(String str) => Creators.fromMap(json.decode(str));

  factory Creators.fromMap(Map<String, dynamic> json) => Creators(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<CreatorsItem>.from(
            json["items"].map((x) => CreatorsItem.fromMap(x))),
        returned: json["returned"],
      );
}

class CreatorsItem {
  String resourceUri;
  String name;

  CreatorsItem({
    required this.resourceUri,
    required this.name,
  });

  factory CreatorsItem.fromJson(String str) =>
      CreatorsItem.fromMap(json.decode(str));

  factory CreatorsItem.fromMap(Map<String, dynamic> json) => CreatorsItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
      );
}

class Date {
  String date;

  Date({
    required this.date,
  });

  factory Date.fromJson(String str) => Date.fromMap(json.decode(str));

  factory Date.fromMap(Map<String, dynamic> json) => Date(
        date: json["date"],
      );
}

class Thumbnail {
  String path;
  String extension;

  Thumbnail({
    required this.path,
    required this.extension,
  });

  factory Thumbnail.fromJson(String str) => Thumbnail.fromMap(json.decode(str));

  factory Thumbnail.fromMap(Map<String, dynamic> json) => Thumbnail(
        path: json["path"],
        extension: json["extension"],
      );
}

// ignore: constant_identifier_names
enum Extension { JPG }

final extensionValues = EnumValues({"jpg": Extension.JPG});

class Price {
  double price;

  Price({
    required this.price,
  });

  factory Price.fromJson(String str) => Price.fromMap(json.decode(str));

  factory Price.fromMap(Map<String, dynamic> json) => Price(
        price: json["price"]?.toDouble(),
      );
}

class TextObject {
  String text;

  TextObject({
    required this.text,
  });

  factory TextObject.fromJson(String str) =>
      TextObject.fromMap(json.decode(str));

  factory TextObject.fromMap(Map<String, dynamic> json) => TextObject(
        text: json["text"],
      );
}

class Url {
  String url;

  Url({
    required this.url,
  });

  factory Url.fromJson(String str) => Url.fromMap(json.decode(str));

  factory Url.fromMap(Map<String, dynamic> json) => Url(
        url: json["url"],
      );
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
