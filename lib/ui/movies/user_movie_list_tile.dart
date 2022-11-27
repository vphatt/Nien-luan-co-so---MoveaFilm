import 'package:flutter/material.dart';
import 'package:movies/ui/screens.dart';
import '../../models/movie.dart';
import 'package:provider/provider.dart';

class UserMovieListTile extends StatelessWidget {
  final Movie movie;

  const UserMovieListTile(
    this.movie, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        movie.title,
        style: const TextStyle(color: Colors.white),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(movie.imageUrl),
      ),
      trailing: SizedBox(
          width: 140,
          child: RichText(
            text: TextSpan(children: [
              WidgetSpan(
                  child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    EditMovieScreen.routeName,
                    arguments: movie.id,
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
                            title: const Text(
                              'Xoá Phim?',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 81, 76, 132),
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
                                        text: movie.title,
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
                                      .read<MoviesManager>()
                                      .deleteMovie(movie.id!);

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
