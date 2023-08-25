import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import 'package:comics_app/src/models/models.dart';

class ComicSwiper extends StatelessWidget {
  final List<Comic> comics;
  const ComicSwiper({super.key, required this.comics});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final CardSwiperController controller = CardSwiperController();

    if (comics.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
          width: double.infinity,
          height: size.height * 0.6,
          child: CardSwiper(
            padding: EdgeInsets.symmetric(
                vertical: 50, horizontal: size.width * 0.17),
            controller: controller,
            cardsCount: comics.length,
            numberOfCardsDisplayed: 4,
            maxAngle: 90,
            // allowedSwipeDirection:
            //     AllowedSwipeDirection.symmetric(horizontal: true),
            backCardOffset: const Offset(-30, 0),
            cardBuilder: (_, int index, horizontalOffsetPercentage,
                    verticalOffsetPercentage) =>
                _comicCard(context, index),
          )),
    );
  }

  Widget _comicCard(BuildContext context, int index) {
    final comic = comics[index];
    comic.heroid = 'hero-${comic.id}';

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'details', arguments: comic),
      child: Hero(
        tag: comic.heroid!,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            image: NetworkImage(comic.getpath),
            placeholder: const AssetImage('assets/no-image.jpg'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
