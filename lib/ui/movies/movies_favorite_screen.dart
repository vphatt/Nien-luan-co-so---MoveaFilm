import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../search/search.dart';
import '../shared/app_drawer.dart';
import 'movies_favorite_list.dart';
import 'movies_manager.dart';

class MoviesFavoriteScreen extends StatefulWidget {
  const MoviesFavoriteScreen({super.key});

  @override
  State<MoviesFavoriteScreen> createState() => _MoviesFavoriteScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _MoviesFavoriteScreenState extends State<MoviesFavoriteScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshMovies(BuildContext context) async {
    await context.read<MoviesManager>().fetchMovies(true);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
                'Yêu Thích',
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
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 8, 6, 29),
                    Color.fromARGB(217, 35, 27, 110),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
              ),
              FutureBuilder(
                  future: _refreshMovies(context),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                    return RefreshIndicator(
                        onRefresh: () => _refreshMovies(context),
                        child: Consumer<MoviesManager>(
                            builder: (ctx, moviesManager, child) {
                          return const MoviesFavoriteList();
                        }));
                  })
            ],
          ),
        ));
    //const MoviesFavoriteList());
  }
}
