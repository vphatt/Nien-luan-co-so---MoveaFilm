import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../models/movie.dart';
import '../../search/search.dart';
import '../../shared/app_drawer.dart';
import '../movie_grid_tile.dart';
import '../movies_manager.dart';

class MoviesByCategory extends StatefulWidget {
  const MoviesByCategory(this.category, {Key? key}) : super(key: key);
  static String routeName = '/movie-by-category';
  final String category;

  @override
  State<MoviesByCategory> createState() => _MoviesByCategoryState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _MoviesByCategoryState extends State<MoviesByCategory> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final movies = context.select<MoviesManager, List<Movie>>(
        (moviesManager) => moviesManager.items);

    final filter = movies
        .where((element) => element.category.contains(widget.category))
        .toList();

    // final filter = movies
    // .where((element) =>
    //     element.category.toLowerCase().contains(Pattern widget.category.toLowerCase(), [int startIndex = 0]))
    // .toList();

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color.fromARGB(255, 32, 26, 63),
        endDrawer: const AppDrawer(),
        appBar: AppBar(
          leading: const BackButton(color: Color.fromARGB(255, 255, 255, 255)),
          actions: [
            IconButton(
                onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                icon: Icon(
                  Icons.account_circle,
                  size: height * 1 / 35,
                ))
          ],
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: const Color.fromARGB(255, 8, 6, 29),
          toolbarHeight: height * 1 / 15,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.category,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: height * 1 / 30),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => showSearch(
                    context: context,
                    delegate: Search()), //Navigator.of(context)

                icon: const Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SizedBox(
          height: height,
          child: GridView.builder(
            padding: const EdgeInsets.all(10.0),
            scrollDirection: Axis.vertical,
            itemCount: filter.length,
            itemBuilder: (ctx, i) => MovieGridTile(filter[i]),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
          ),
        ));
  }
}
