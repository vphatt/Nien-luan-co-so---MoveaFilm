// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:movies/models/movie_comingsoon.dart';
import 'movie_coming_detail.dart';

class ComingGridTile extends StatelessWidget {
  const ComingGridTile(
    this.movieComing, {
    super.key,
  });

  final MovieComingSoon movieComing;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => MovieComingDetailScreen(movieComing)));
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5.0,
                    offset: Offset(0, 1),
                    spreadRadius: 0.8,
                  )
                ]),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GridTile(
                    footer: SizedBox(
                      height: height * 1 / 15,
                      child: buildGridFooterBar(context),
                    ),
                    child: GestureDetector(
                        child: Image.network(
                      movieComing.imageUrl,
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
                Container(
                  height: height * 1 / 30,
                  width: width * 1 / 5,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(10)),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: const [
                        Color.fromARGB(200, 144, 10, 140),
                        Color.fromARGB(200, 66, 18, 155),
                      ],
                    ),
                  ),
                  child: Center(
                      child: Text(
                    movieComing.premiere,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                )
              ],
            )));
  }

  Widget buildGridFooterBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const [
            Color.fromARGB(153, 18, 187, 13),
            Color.fromARGB(153, 120, 136, 14),
          ],
        ),
      ),
      child: GridTileBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movieComing.title,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
