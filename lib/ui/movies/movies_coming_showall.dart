import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/movie_comingsoon.dart';
import '../search/search.dart';
import '../shared/app_drawer.dart';
import 'home/coming/coming_grid_tile.dart';
import 'home/coming/movies_coming_manager.dart';

class MoviesComingShowAll extends StatefulWidget {
  const MoviesComingShowAll({Key? key}) : super(key: key);

  @override
  State<MoviesComingShowAll> createState() => _MoviesComingShowAllState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _MoviesComingShowAllState extends State<MoviesComingShowAll> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final moviesComing =
        context.select<MoviesComingManager, List<MovieComingSoon>>(
            (moviesComingManager) => moviesComingManager.items);

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
                'Tất cả phim',
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
            itemCount: moviesComing.length,
            itemBuilder: (ctx, i) => ComingGridTile(moviesComing[i]),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
          ),
        ));
  }
}
