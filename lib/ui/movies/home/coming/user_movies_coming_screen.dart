// // ignore_for_file: avoid_print
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:movies/ui/screens.dart';
// import 'package:provider/provider.dart';

// import '../../models/movie.dart';
// import '../search/search_for_admin.dart';
// import 'user_movie_list_tile.dart';

// class UserMoviesScreen extends StatelessWidget {
//   const UserMoviesScreen({Key? key}) : super(key: key);

//   Future<void> _refreshMovies(BuildContext context) async {
//     await context.read<MoviesManager>().fetchMovies(true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final movies = context.select<MoviesManager, List<Movie>>(
//         (moviesManager) => moviesManager.items);

//     return Scaffold(
//         floatingActionButton: FloatingActionButton.extended(
//           onPressed: () {
//             Navigator.of(context).pushNamed(
//               EditMovieScreen.routeName,
//             );
//           },
//           label: RichText(
//             text: const TextSpan(children: [
//               WidgetSpan(
//                   child: Icon(
//                 Icons.add,
//                 color: Colors.white,
//                 size: 20,
//               )),
//               TextSpan(
//                   text: ' Thêm phim mới',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontFamily: 'Quicksand',
//                   ))
//             ]),
//           ),
//         ),
//         backgroundColor: const Color.fromARGB(255, 8, 6, 29),
//         appBar: AppBar(
//           systemOverlayStyle: SystemUiOverlayStyle.light,
//           backgroundColor: const Color.fromARGB(255, 8, 6, 29),
//           toolbarHeight: height * 1 / 15,
//           title: Text(
//             'Quản Lý Phim',
//             style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: height * 1 / 50),
//           ),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: Container(
//           child: Column(
//             children: [
//               Container(
//                   decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                     colors: [
//                       Color.fromARGB(255, 8, 6, 29),
//                       Color.fromARGB(217, 35, 27, 110),
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   )),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         InkWell(
//                           onTap: () => showSearch(
//                               context: context, delegate: SearchForAdmin()),
//                           child: Container(
//                               width: double.infinity,
//                               height: height * 1 / 15,
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               decoration: BoxDecoration(
//                                   color: const Color.fromARGB(255, 22, 36, 70),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Center(
//                                 child: TextField(
//                                   enabled: false,
//                                   style: const TextStyle(
//                                     color: Color.fromARGB(255, 180, 180, 180),
//                                     fontWeight: FontWeight.bold,
//                                     fontStyle: FontStyle.italic,
//                                     fontSize: 15,
//                                   ),
//                                   decoration: InputDecoration(
//                                       border: InputBorder.none,
//                                       prefixIcon: const Icon(
//                                         Icons.search,
//                                         color: Colors.white,
//                                       ),
//                                       suffixIcon: IconButton(
//                                         icon: const Icon(
//                                           Icons.clear,
//                                           color: Colors.white,
//                                         ),
//                                         onPressed: () {},
//                                         //onPressed: widget.clearText,
//                                       ),
//                                       hintText: "Tìm kiếm phim",
//                                       hintStyle: const TextStyle(
//                                         color:
//                                             Color.fromARGB(161, 180, 180, 180),
//                                         fontWeight: FontWeight.bold,
//                                         fontStyle: FontStyle.italic,
//                                         fontSize: 15,
//                                       )),
//                                   //controller: widget.fieldText,
//                                 ),
//                               )),
//                         ),
//                       ])),
//               FutureBuilder(
//                 future: _refreshMovies(context),
//                 builder: (ctx, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   return RefreshIndicator(
//                       onRefresh: () => _refreshMovies(context),
//                       child: Consumer<MoviesManager>(
//                           builder: (ctx, moviesManager, child) {
//                         return ListView.builder(
//                             itemCount: movies.length,
//                             itemBuilder: (context, i) =>
//                                 UserMovieListTile(movies[i]));
//                       }));
//                 },
//               )
//             ],
//           ),
//         ));
//   }
// }

// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies/ui/screens.dart';
import 'package:provider/provider.dart';

import '../../../search/search_for_admin.dart';
import 'movies_coming_manager.dart';
import 'user_movie_coming_list_tile.dart';

class UserMoviesComingScreen extends StatelessWidget {
  static const routeName = '/user-movies-coming';
  const UserMoviesComingScreen({super.key});

  Future<void> _refreshMoviesComing(BuildContext context) async {
    await context.read<MoviesComingManager>().fetchMoviesComing(true);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final movies = context.select<MoviesManager, List<Movie>>(
    //     (moviesManager) => moviesManager.items);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 8, 6, 29),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed(
              EditMovieComingScreen.routeName,
            );
          },
          label: RichText(
            text: const TextSpan(children: [
              WidgetSpan(
                  child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              )),
              TextSpan(
                  text: ' Thêm phim mới',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Quicksand',
                  ))
            ]),
          ),
        ),
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: const Color.fromARGB(255, 8, 6, 29),
          toolbarHeight: height * 1 / 15,
          title: Text(
            'Quản Lý Phim sắp chiếu',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: height * 1 / 50),
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => showSearch(
                              context: context,
                              delegate: SearchForAdminComing()),
                          child: Container(
                              width: double.infinity,
                              height: height * 1 / 20,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 22, 36, 70),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: TextField(
                                  enabled: false,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 180, 180, 180),
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15,
                                  ),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: const Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {},
                                        //onPressed: widget.clearText,
                                      ),
                                      hintText: "Tìm kiếm phim",
                                      hintStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(161, 180, 180, 180),
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15,
                                      )),
                                  //controller: widget.fieldText,
                                ),
                              )),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 10, top: 20),
                            child: const Text(
                              'Danh sách phim sắp chiếu:',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                      ])),
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: FutureBuilder(
                    future: _refreshMoviesComing(context),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () => _refreshMoviesComing(context),
                        child: buildUserMovieListView(),
                      );
                    }),
              )
            ],
          ),
        ));
  }

  Widget buildUserMovieListView() {
    return Consumer<MoviesComingManager>(
      builder: (ctx, moviesComingManager, child) {
        return ListView.builder(
          itemCount: moviesComingManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserMovieComingListTile(
                moviesComingManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}
