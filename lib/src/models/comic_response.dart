import 'dart:convert';
import 'package:comics_app/src/models/models.dart';

class ComicsResponse {
    Data data;

    ComicsResponse({
        required this.data,
    });

    factory ComicsResponse.fromJson(String str) => ComicsResponse.fromMap(json.decode(str));

    factory ComicsResponse.fromMap(Map<String, dynamic> json) => ComicsResponse(
        data: Data.fromMap(json["data"]),
    );
}

class Data {
    List<Comic> comic;

    Data({
        required this.comic,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        comic: List<Comic>.from(json["results"].map((x) => Comic.fromMap(x))),
    );
}