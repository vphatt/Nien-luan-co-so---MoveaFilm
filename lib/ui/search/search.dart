import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/movie.dart';
import '../movies/movie_detail_screen.dart';
import '../movies/movies_manager.dart';

class Search extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: Theme.of(context).appBarTheme.copyWith(toolbarHeight: 80),
      scaffoldBackgroundColor: const Color.fromARGB(255, 8, 6, 29),
      inputDecorationTheme: const InputDecorationTheme(
          filled: true, fillColor: Color.fromARGB(255, 58, 56, 96)),
      textTheme: const TextTheme(
        subtitle1: TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      hintColor: Colors.white,
    );
  }

  @override
  String get searchFieldLabel => 'Nhập tên phim (ví dụ: "avatar")';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_sharp),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final movies = context.select<MoviesManager, List<Movie>>(
        (moviesManager) => moviesManager.items);
    final suggestions = movies
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              MovieDetailScreen.routeName,
              arguments: suggestions[index].id,
            );
          },
          child: Container(
            height: height * 1 / 8,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 69, 66, 99),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    width: width * 1 / 3,
                    child: Image.network(
                      suggestions[index].imageUrl,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        suggestions[index].title,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: 'Quicksand'),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: '${suggestions[index].imdb}',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 214, 161, 2),
                                fontSize: 15,
                                fontStyle: FontStyle.italic)),
                        const WidgetSpan(
                          child: Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 214, 161, 2),
                            size: 25,
                          ),
                        )
                      ]),
                    ))
              ],
            ),
          ),
        );
        //
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final movies = context.select<MoviesManager, List<Movie>>(
        (moviesManager) => moviesManager.items);
    final suggestions = movies
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              MovieDetailScreen.routeName,
              arguments: suggestions[index].id,
            );
          },
          child: Container(
            height: height * 1 / 8,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 69, 66, 99),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    width: width * 1 / 3,
                    child: Image.network(
                      suggestions[index].imageUrl,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        suggestions[index].title,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: 'Quicksand'),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: '${suggestions[index].imdb} ',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 214, 161, 2),
                                fontSize: 15,
                                fontStyle: FontStyle.italic)),
                        const WidgetSpan(
                          child: Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 214, 161, 2),
                            size: 25,
                          ),
                        )
                      ]),
                    ))
              ],
            ),
          ),
        );
        //
      },
    );
  }
  //return Container();
}

// class Search extends StatefulWidget {
//   Search({Key? key}) : super(key: key);
//   final fieldText = TextEditingController();

//   void clearText() {
//     fieldText.clear();
//   }

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   late Future<void> _fetchMovies;
//   @override
//   void initState() {
//     super.initState();
//     _fetchMovies = context.read<MoviesManager>().fetchMovies();
//   }
//   //Hàm lọc danh sách phim

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;

//     var movies = context.select<MoviesManager, List<Movie>>(
//         (moviesManager) => moviesManager.items);

//     var display = List.from(movies);

//     void updateList(String value) {
//       setState(() {
//         display = movies
//             .where((element) =>
//                 element.title.toLowerCase().contains(value.toLowerCase()))
//             .toList();
//       });
//     }

//     return Scaffold(
//         backgroundColor: const Color.fromARGB(255, 8, 6, 29),
//         appBar: AppBar(
//           systemOverlayStyle: SystemUiOverlayStyle.light,
//           backgroundColor: const Color.fromARGB(255, 8, 6, 29),
//           toolbarHeight: height * 1 / 15,
//           title: Text(
//             'Tìm kiếm Phim',
//             style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: height * 1 / 50),
//           ),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: Container(
//             decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//               colors: [
//                 Color.fromARGB(255, 8, 6, 29),
//                 Color.fromARGB(217, 35, 27, 110),
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             )),
//             child: Column(
//               children: [
//                 Container(
//                     width: double.infinity,
//                     height: height * 1 / 15,
//                     margin: const EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 22, 36, 70),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Center(
//                       child: TextField(
//                         onChanged: (value) => updateList(value),
//                         style: const TextStyle(
//                           color: Color.fromARGB(255, 180, 180, 180),
//                           fontWeight: FontWeight.bold,
//                           fontStyle: FontStyle.italic,
//                           fontSize: 15,
//                         ),
//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             prefixIcon: const Icon(
//                               Icons.search,
//                               color: Colors.white,
//                             ),
//                             suffixIcon: IconButton(
//                               icon: const Icon(
//                                 Icons.clear,
//                                 color: Colors.white,
//                               ),
//                               onPressed: widget.clearText,
//                             ),
//                             hintText: "ví dụ: the greatest showman",
//                             hintStyle: const TextStyle(
//                               color: Color.fromARGB(161, 180, 180, 180),
//                               fontWeight: FontWeight.bold,
//                               fontStyle: FontStyle.italic,
//                               fontSize: 15,
//                             )),
//                         controller: widget.fieldText,
//                       ),
//                     )),
//                 SizedBox(
//                   height: height * 1 / 20,
//                 ),
//                 Expanded(
//                     child: ListView.builder(
//                         itemCount: display.length,
//                         itemBuilder: (context, i) => Container(
//                             height: height * 1 / 10,
//                             decoration: BoxDecoration(
//                                 color: const Color.fromARGB(255, 8, 6, 29),
//                                 borderRadius: BorderRadius.circular(10)),
//                             margin: const EdgeInsets.symmetric(
//                                 vertical: 10, horizontal: 5),
//                             child: Center(
//                               child: ListTile(
//                                   title: Text(
//                                     display[i].title,
//                                     style: const TextStyle(
//                                         color: Colors.white, fontSize: 25),
//                                   ),
//                                   subtitle: Text(
//                                     '${display[i].year} '
//                                     '|'
//                                     ' ${display[i].duration}',
//                                     style:
//                                         const TextStyle(color: Colors.yellow),
//                                   ),
//                                   leading: Image.network(
//                                     display[i].imageUrl,
//                                     fit: BoxFit.cover,
//                                   ),
//                                   trailing: RichText(
//                                     text: TextSpan(children: [
//                                       TextSpan(
//                                           text: '${display[i].imdb} ',
//                                           style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 214, 161, 2),
//                                               fontSize: 15,
//                                               fontStyle: FontStyle.italic)),
//                                       const WidgetSpan(
//                                         child: Icon(
//                                           Icons.star,
//                                           color:
//                                               Color.fromARGB(255, 214, 161, 2),
//                                           size: 25,
//                                         ),
//                                       )
//                                     ]),
//                                   )),
//                             ))))
//               ],
//             )));
//   }
// }
