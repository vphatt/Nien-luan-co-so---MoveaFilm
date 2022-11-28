import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies/ui/movies/movies_manager.dart';
import 'package:movies/ui/movies/movies_showall.dart';

import 'package:movies/ui/shared/app_drawer.dart';

import 'package:provider/provider.dart';

import '../search/search.dart';
import 'home/coming/coming_grid.dart';
import 'home/coming/movies_coming_manager.dart';
import 'movies_coming_showall.dart';
import 'movies_grid.dart';
import 'home/update_new/movie_carousel.dart';

class MoviesOverviewScreen extends StatefulWidget {
  const MoviesOverviewScreen({super.key});

  @override
  State<MoviesOverviewScreen> createState() => _MoviesOverviewScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _MoviesOverviewScreenState extends State<MoviesOverviewScreen> {
  late Future<void> _fetchMovies;
  late Future<void> _fetchMoviesComing;

  @override
  void initState() {
    super.initState();
    _fetchMovies = context.read<MoviesManager>().fetchMovies();
    _fetchMoviesComing =
        context.read<MoviesComingManager>().fetchMoviesComing();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _scaffoldKey,
        endDrawer: const AppDrawer(),
        appBar: AppBar(
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
                'MoveaFilm',
                style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: height * 1 / 30),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => showSearch(
                  context: context,
                  delegate: Search(),
                ), //Navigator.of(context)
                //.push(MaterialPageRoute(builder: (_) => Search())),
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
        body: SingleChildScrollView(
            child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 8, 6, 29),
              Color.fromARGB(217, 35, 27, 110),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _headTitle(context, 'Mới Cập Nhật'),
              const MovieCarousel(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _headTitle(context, 'Gợi Ý'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const MoviesShowAll()));
                      },
                      child: const Text('Tất cả',
                          style: TextStyle(color: Colors.green, fontSize: 20)))
                ],
              ),
              const MoviesGrid(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _headTitle(context, 'Phim Sắp Chiếu'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const MoviesComingShowAll()));
                      },
                      child: const Text('Tất cả',
                          style: TextStyle(color: Colors.green, fontSize: 20)))
                ],
              ),
              const ComingGrid(),
            ],
          ),
        )));
    //MoviesGrid(false),
  }

  Widget _headTitle(
    BuildContext context,
    String ctx,
  ) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 1 / 25,
      margin: const EdgeInsets.only(top: 20, left: 10),
      child: Text(
        ctx,
        style: TextStyle(
            color: Colors.white,
            fontSize: height * 1 / 35,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
