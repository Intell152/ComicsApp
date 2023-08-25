import 'package:comics_app/src/models/comic.dart';
import 'package:comics_app/src/providers/comic_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComicSearchDelegate extends SearchDelegate {
  String selccion = '';
  final comicsProvider = ComicsProvider();

  @override
  String get searchFieldLabel => 'Buscar Comic';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.transparent,
        child: Text(selccion),
      ),
    );
  }

  Widget _emptyContainer() {
    return const Center(
      child: Icon(
        Icons.movie_creation_outlined,
        color: Colors.black38,
        size: 130,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return _emptyContainer();

    final comicsProvider = Provider.of<ComicsProvider>(context, listen: false);
    comicsProvider.getSuggestions(query);

    return StreamBuilder(
      stream: comicsProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Comic>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index) => _ComicItem(movies[index]));
      },
    );
  }
}

class _ComicItem extends StatelessWidget {
  final Comic comic;

  const _ComicItem(this.comic);

  @override
  Widget build(BuildContext context) {
    comic.heroid = 'search-${comic.id}';

    return ListTile(
      leading: Hero(
        tag: comic.heroid!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(comic.getpath),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(comic.title),
      subtitle: Text(comic.variantDescription),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: comic);
      },
    );
  }
}
