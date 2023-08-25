import 'package:flutter/material.dart';

import 'package:comics_app/src/models/models.dart';

class ComicGridList extends StatefulWidget {
  final ScrollController scrollController;
  final List<Comic> comics;
  final Function onNextPackage;
  const ComicGridList(
      {super.key,
      required this.comics,
      required this.scrollController,
      required this.onNextPackage});

  @override
  State<ComicGridList> createState() => _ComicGridListState();
}

class _ComicGridListState extends State<ComicGridList> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels >=
          widget.scrollController.position.maxScrollExtent - 500) {
        widget.onNextPackage();
      }
    });
  }

  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      controller: widget.scrollController,
      maxCrossAxisExtent: 160,
      childAspectRatio: 160 / 255,
      padding: const EdgeInsets.all(10),
      children: List.generate(
        widget.comics.length,
        (index) => _comicCard(context, index),
      ),
    );
  }

  Widget _comicCard(BuildContext context, int index) {
    final comic = widget.comics[index];
    comic.heroid = 'hero-${comic.title}-${comic.id}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'details', arguments: comic),
        child: Column(
          children: [
            Hero(
              tag: comic.heroid!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FadeInImage(
                  image: NetworkImage(comic.getpath),
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  fit: BoxFit.fill,
                  height: 160,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              comic.title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
