// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'ui/movies/home/coming/movies_coming_manager.dart';
import 'ui/screens.dart';
import 'package:movies/ui/shared/bottom_navigator_bar.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthManager(),
          ),
          ChangeNotifierProxyProvider<AuthManager, MoviesManager>(
              create: (ctx) => MoviesManager(),
              update: (ctx, authManager, moviesManager) {
                moviesManager!.authToken = authManager.authToken;
                return moviesManager;
              }),
          ChangeNotifierProxyProvider<AuthManager, MoviesComingManager>(
              create: (ctx) => MoviesComingManager(),
              update: (ctx, authManager, moviesComingManager) {
                moviesComingManager!.authToken = authManager.authToken;
                return moviesComingManager;
              }),
        ],
        child: Consumer<AuthManager>(
          builder: (ctx, authManager, child) {
            return MaterialApp(
              title: 'MoveaFilm',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Quicksand',
                colorScheme: ColorScheme.light(
                  primary: const Color.fromARGB(255, 8, 6, 29),
                ).copyWith(
                  secondary: Colors.deepOrange,
                ),
              ),
              home: authManager.isAuth
                  ? const BottomNavigator()
                  : FutureBuilder(
                      future: authManager.tryAutoLogin(),
                      builder: (ctx, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? const SplashScreen()
                            : const AuthScreen();
                      },
                    ),
              onGenerateRoute: (settings) {
                if (settings.name == MovieDetailScreen.routeName) {
                  final movieId = settings.arguments as String;
                  return MaterialPageRoute(
                    builder: (ctx) {
                      return MovieDetailScreen(
                        ctx.read<MoviesManager>().findById(movieId),
                      );
                    },
                  );
                }

                if (settings.name == EditMovieScreen.routeName) {
                  final movieId = settings.arguments as String?;
                  return MaterialPageRoute(
                    builder: (ctx) {
                      return EditMovieScreen(
                        movieId != null
                            ? ctx.read<MoviesManager>().findById(movieId)
                            : null,
                      );
                    },
                  );
                }

                if (settings.name == EditMovieComingScreen.routeName) {
                  final movieComingId = settings.arguments as String?;
                  return MaterialPageRoute(
                    builder: (ctx) {
                      return EditMovieComingScreen(
                        movieComingId != null
                            ? ctx
                                .read<MoviesComingManager>()
                                .findById(movieComingId)
                            : null,
                      );
                    },
                  );
                }

                return null;
              },
            );
          },
        ));
  }
}
