// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_new, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:movies/models/movie_comingsoon.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieComingDetailScreen extends StatelessWidget {
  static const routeName = '/movie-detail-coming';
  const MovieComingDetailScreen(
    this.movieComing, {
    super.key,
  });

  final MovieComingSoon movieComing;

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
                    movieComing.imageUrl,
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
                              text: movieComing.title,
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                            TextSpan(
                              text:
                                  '\n\nNgày công chiếu: ${movieComing.premiere}',
                              style: TextStyle(
                                color: Colors.yellow,
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
          Column(children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Quốc gia: ${movieComing.nation}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Text(
            movieComing.category,
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
            'Diễn viên: ${movieComing.cast}',
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
            'Đạo diễn: ${movieComing.director}',
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
          SizedBox(
            height: 40,
            child: Text(
              '━',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () async {
                var url = movieComing.trailerUrl;
                final Uri _url = Uri.parse(url);
                await launchUrl(_url, mode: LaunchMode.externalApplication);
              },
              child: Text(
                'Xem Trailer',
                style: TextStyle(fontSize: 30),
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              movieComing.description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
            ),
          )
        ],
      )),
    );
  }
}
