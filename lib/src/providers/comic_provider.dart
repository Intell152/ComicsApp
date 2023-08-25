import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:comics_app/src/helpers/debouncer.dart';
import 'package:comics_app/src/models/creators_response.dart';
import 'package:comics_app/src/models/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ComicsProvider extends ChangeNotifier {
  List<Comic> swiperComics = [];
  List<Comic> gridComics = [];
  Map<int, List<Character>> comicCharacters = {};
  Map<int, List<Creator>> comicCreators = {};

  int _comicsLimit = 0;

  final debouncer = Debouncer(
    duration: const Duration( milliseconds: 500 ),
  );

  final StreamController<List<Comic>> _suggestionStreamContoller =
      StreamController.broadcast();
  Stream<List<Comic>> get suggestionStream => _suggestionStreamContoller.stream;

  ComicsProvider() {
    getComicsSwiperList();
    getComicsGridList();
  }

  Future<String> _getJsonData(
      {String endPath = '', int limit = 20, int offset = 0}) async {
    final dio = Dio();
    final ts = DateTime.now().toString();
    final path = endPath.isEmpty
        ? dotenv.env['COMICSURL'].toString()
        : dotenv.env['COMICSURL'].toString() + endPath;

    var hash = ts +
        dotenv.env['PRIVATEKEY'].toString() +
        dotenv.env['PUBLICKEY'].toString();

    List<int> inputBytes = utf8.encode(hash);
    Digest md5Digest = md5.convert(inputBytes);
    hash = hex.encode(md5Digest.bytes);

    Response response = await dio.get(
      path,
      queryParameters: {
        'ts': ts,
        'apikey': dotenv.env['PUBLICKEY'].toString(),
        'hash': hash,
        'limit': '$limit',
        'offset': '$offset',
      },
    );

    return response.toString();
  }

  getComicsSwiperList() async {
    Random random = Random();
    int randomOffsetr = random.nextInt(2001);
    final jsonData = await _getJsonData(offset: randomOffsetr);
    final comicData = ComicsResponse.fromJson(jsonData);

    swiperComics = comicData.data.comic;
    notifyListeners();
  }

  getComicsGridList() async {
    final jsonData = await _getJsonData(limit: 100, offset: _comicsLimit);
    _comicsLimit += 100;
    final comicData = ComicsResponse.fromJson(jsonData);

    gridComics = [...gridComics, ...comicData.data.comic];
    notifyListeners();
  }

  Future<List<Character>> getComicCharacters(int comicId) async {
    if (comicCharacters.containsKey(comicId)) return comicCharacters[comicId]!;

    final jsonData =
        await _getJsonData(limit: 100, endPath: '/$comicId/characters');
    final comicResponse = CharactersResponse.fromJson(jsonData);

    comicCharacters[comicId] = comicResponse.data.results;
    return comicResponse.data.results;
  }

  Future<List<Creator>> getComicCreator(int comicId) async {
    if (comicCreators.containsKey(comicId)) return comicCreators[comicId]!;

    final jsonData =
        await _getJsonData(limit: 100, endPath: '/$comicId/creators');
    final comicResponse = CreatorsResponse.fromJson(jsonData);

    comicCreators[comicId] = comicResponse.data.results;
    return comicResponse.data.results;
  }

  Future<List<Comic>> searchComic(String query) async {
    final dio = Dio();
    final ts = DateTime.now().toString();
    final path = dotenv.env['COMICSURL'].toString();

    var hash = ts +
        dotenv.env['PRIVATEKEY'].toString() +
        dotenv.env['PUBLICKEY'].toString();

    List<int> inputBytes = utf8.encode(hash);
    Digest md5Digest = md5.convert(inputBytes);
    hash = hex.encode(md5Digest.bytes);

    Response response = await dio.get(
      path,
      queryParameters: {
        'ts': ts,
        'apikey': dotenv.env['PUBLICKEY'].toString(),
        'hash': hash,
        'limit': 100,
        'title': query
      },
    );

    final comicData = ComicsResponse.fromJson(response.toString());
    return comicData.data.comic;
  }

  void getSuggestions( String query ) {
    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      // print('Tenemos valor a buscar: $value');
      final results = await searchComic(value);
      _suggestionStreamContoller.add( results );
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), ( _ ) { 
      debouncer.value = query;
    });

    Future.delayed(const Duration( milliseconds: 301)).then(( _ ) => timer.cancel());
  }
}
