import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../movies/category/movies_category.dart';
import '../movies/movie_overview_screen.dart';
import '../movies/movies_favorite_screen.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final List<Widget> _items = [
    const MoviesOverviewScreen(),
    const CategoryPage(),
    const MoviesFavoriteScreen(),
  ];
  int cIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(child: _items[cIndex]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: DotNavigationBar(
          backgroundColor: const Color.fromARGB(255, 8, 6, 29),
          currentIndex: cIndex,
          dotIndicatorColor: Colors.white,
          paddingR: const EdgeInsets.all(20),
          unselectedItemColor: Colors.grey[300],
          // enableFloatingNavBar: false,
          onTap: (index) {
            setState(() {
              cIndex = index;
            });
          },
          items: [
            /// Home
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: const Color.fromARGB(255, 189, 29, 135),
            ),

            /// Likes
            DotNavigationBarItem(
              icon: const Icon(Icons.category),
              selectedColor: const Color.fromARGB(255, 189, 29, 135),
            ),

            /// Search
            DotNavigationBarItem(
              icon: const Icon(Icons.favorite),
              selectedColor: const Color.fromARGB(255, 189, 29, 135),
            )

            /// Profile
          ],
        ),
      ),
    );
  }
}
