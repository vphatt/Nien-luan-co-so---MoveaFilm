import 'package:flutter/material.dart';
import 'package:movies/models/movie_comingsoon.dart';
import 'package:movies/ui/screens.dart';
import 'package:provider/provider.dart';

import 'movies_coming_manager.dart';

class UserMovieComingListTile extends StatelessWidget {
  final MovieComingSoon movieComing;

  const UserMovieComingListTile(
    this.movieComing, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        movieComing.title,
        style: const TextStyle(color: Colors.white),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(movieComing.imageUrl),
      ),
      trailing: SizedBox(
          width: 140,
          child: RichText(
            text: TextSpan(children: [
              WidgetSpan(
                  child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    EditMovieComingScreen.routeName,
                    arguments: movieComing.id,
                  );
                },
                child: const Text(
                  'Cập nhật',
                  style: TextStyle(color: Colors.yellow),
                ),
              )),
              WidgetSpan(
                  child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            backgroundColor:
                                const Color.fromARGB(255, 81, 76, 132),
                            title: const Text('Xoá Phim?',
                                style: TextStyle(color: Colors.white)),
                            content: RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Colors.white),
                                  children: [
                                    const TextSpan(
                                      text: 'Xoá ',
                                    ),
                                    TextSpan(
                                        text: movieComing.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                    const TextSpan(
                                      text: ' khỏi Cơ sở dữ liệu?',
                                    ),
                                  ]),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text(
                                  'Không',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  'Có',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  context
                                      .read<MoviesComingManager>()
                                      .deleteMovieComing(movieComing.id!);

                                  Navigator.of(ctx).pop(true);
                                },
                              ),
                            ],
                          ));
                },
                child: const Text(
                  'Xoá',
                  style: TextStyle(color: Colors.red),
                ),
              ))
            ]),
          )),
    );
  }
}
