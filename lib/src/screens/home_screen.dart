import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:comics_app/src/widgets/widgets.dart';
import 'package:comics_app/src/providers/comic_provider.dart';
import 'package:comics_app/src/helpers/search_delegate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Marvel Comics'),
          shadowColor: Colors.amber.shade800,
          actions: [
            IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () => showSearch(context: context, delegate: ComicSearchDelegate()),
            )
          ],
        ),
        body: _orientationBuild());
  }

  Widget _orientationBuild() {
    final ScrollController scrollController = ScrollController();

    return OrientationBuilder(
      builder: (context, orientation) {
        final comicProvider = Provider.of<ComicsProvider>(context);

        return orientation == Orientation.landscape
            ? ComicGridList(
                comics: comicProvider.gridComics,
                scrollController: scrollController,
                onNextPackage: () => comicProvider.getComicsGridList(),
              )
            : Stack(
                children: [
                  ComicSwiper(comics: comicProvider.swiperComics),
                  const BottomModal()
                ],
              );
      },
    );
  }
}
