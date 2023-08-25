import 'package:comics_app/src/providers/comic_provider.dart';
import 'package:comics_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomModal extends StatelessWidget {
  const BottomModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comicProvider = Provider.of<ComicsProvider>(context);

    return DraggableScrollableSheet(
      snap: true,
      initialChildSize: 0.3,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.amber.shade800,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          // child: ItemsList(scrollController),
          child: ComicGridList(
            scrollController: scrollController,
            comics: comicProvider.gridComics,
            onNextPackage: () => comicProvider.getComicsGridList(),
          ),
        );
      },
    );
  }
}
