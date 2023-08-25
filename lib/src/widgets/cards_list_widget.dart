import 'package:comics_app/src/models/creators_response.dart';
import 'package:comics_app/src/models/models.dart';
import 'package:comics_app/src/providers/comic_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardsList extends StatelessWidget {
  final int comicId;
  final bool selectGeter;
  const CardsList(
      {super.key, required this.comicId, required this.selectGeter});

  @override
  Widget build(BuildContext context) {
    final comicsProvider = Provider.of<ComicsProvider>(context, listen: false);

    return _selectFuture(comicsProvider);
  }

  Widget _selectFuture(ComicsProvider comicsProvider) {
    if (selectGeter) {
      return FutureBuilder(
        future: comicsProvider.getComicCharacters(comicId),
        builder: (_, AsyncSnapshot<List<Character>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Character> character = snapshot.data!;

          return Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: character.length,
              itemBuilder: (context, index) =>
                  _comicCard(context, character[index]),
            ),
          );
        },
      );
    } else {
      return FutureBuilder(
        future: comicsProvider.getComicCreator(comicId),
        builder: (_, AsyncSnapshot<List<Creator>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Creator> creator = snapshot.data!;

          return Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: creator.length,
              itemBuilder: (context, index) =>
                  _comicCard(context, creator[index]),
            ),
          );
        },
      );
    }
  }
  
  Widget _comicCard(BuildContext context, object) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, 'details', arguments: 'ComicInfo'),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: FadeInImage(
                image: NetworkImage('${object.thumbnail.path}/detail.jpg'),
                placeholder: const AssetImage('assets/no-image.jpg'),
                fit: BoxFit.fill,
                height: 160,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              object.name,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
