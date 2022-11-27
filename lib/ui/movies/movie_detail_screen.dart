// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_new, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:movies/models/sample_player.dart';
import 'package:movies/ui/movies/movies_manager.dart';
import 'package:provider/provider.dart';
import '../../models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  static const routeName = '/movie-detail';
  const MovieDetailScreen(
    this.movie, {
    super.key,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 32, 26, 63),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Color.fromARGB(255, 255, 255, 255)),
        centerTitle: true,
        toolbarHeight: 70,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 2 / 3,
              child: Stack(
                children: [
                  SizedBox(
                    height: height * 2 / 3,
                    width: double.infinity,
                    child: Image.network(
                      movie.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromARGB(255, 32, 26, 63),
                      Color.fromARGB(0, 0, 0, 0),
                    ],
                  ))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                text: movie.title,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                              TextSpan(
                                text: '\n${movie.year}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                            ])),
                      )
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: SamplePlayer(movie.videoUrl),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: '${movie.duration}    •    ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  WidgetSpan(
                      child: Icon(
                    Icons.star,
                    color: Colors.yellow,
                  )),
                  TextSpan(
                    text: '${movie.imdb}    •    ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  TextSpan(
                    text: movie.nation,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ])),
                SizedBox(
                  height: 10,
                ),
                Text(
                  movie.category,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Diễn viên: ${movie.cast}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Đạo diễn: ${movie.director}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 4,
                        child: ValueListenableBuilder<bool>(
                          valueListenable: movie.isFavoriteListenable,
                          builder: (ctx, isFavorite, child) {
                            return Container(
                              margin: EdgeInsets.only(right: 5),
                              height: 50,
                              decoration: BoxDecoration(
                                  color: isFavorite
                                      ? Color.fromARGB(255, 197, 36, 36)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: TextButton(
                                  onPressed: () {
                                    ctx
                                        .read<MoviesManager>()
                                        .toggleFavoriteStatus(movie);
                                  },
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(children: [
                                        WidgetSpan(
                                            child: Icon(
                                          isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFavorite
                                              ? Colors.white
                                              : Color.fromARGB(
                                                  255, 197, 36, 36),
                                          size: height * 1 / 55,
                                        )),
                                        TextSpan(
                                          text: isFavorite
                                              ? ' Đã Yêu Thích'
                                              : ' Thêm Yêu Thích',
                                          style: TextStyle(
                                              color: isFavorite
                                                  ? Colors.white
                                                  : Color.fromARGB(
                                                      255, 197, 36, 36),
                                              fontWeight: FontWeight.bold,
                                              fontSize: height * 1 / 60),
                                        )
                                      ]),
                                    ),
                                  )),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(15)),
                          child: IconButton(
                            icon: Icon(
                              Icons.download,
                              size: 30,
                            ),
                            color: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Text(
                    '━',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    movie.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
