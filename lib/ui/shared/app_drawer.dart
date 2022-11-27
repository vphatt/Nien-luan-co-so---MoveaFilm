import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../auth/auth_manager.dart';
import '../movies/home/coming/user_movies_coming_screen.dart';
import '../movies/user_movies_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Drawer(
        child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 58, 52, 130),
          Color.fromARGB(255, 15, 3, 45),
        ],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      )),
      child: Column(
        children: <Widget>[
          const Spacer(),
          const Spacer(),
          const Divider(),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const UserMoviesScreen()));
              },
              child: const Text(
                'Quản lý Phim',
                style: TextStyle(
                    color: Colors.white, fontSize: 15, fontFamily: 'Quicksand'),
              )),
          const Divider(),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const UserMoviesComingScreen()));
              },
              child: const Text(
                'Quản lý Phim sắp chiếu',
                style: TextStyle(
                    color: Colors.white, fontSize: 15, fontFamily: 'Quicksand'),
              )),
          const Spacer(),
          const Divider(),
          TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: const Text(
                          'Đăng xuất?',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: const Color.fromARGB(255, 81, 76, 132),
                        content: const Text(
                          'Bạn có chắc muốn đăng xuất?',
                          style: TextStyle(
                              fontFamily: 'Quicksand', color: Colors.white),
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
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.of(ctx).pop(true);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  context.read<AuthManager>().logout();

                                  return const MyApp();
                                }));
                              });
                            },
                          ),
                        ],
                      ));
            },
            child: RichText(
              text: TextSpan(children: [
                const WidgetSpan(
                    child: Icon(
                  Icons.logout,
                  color: Color.fromARGB(255, 255, 181, 181),
                )),
                TextSpan(
                    text: '  Đăng xuất',
                    style: TextStyle(
                        fontSize: height * 1 / 40,
                        color: const Color.fromARGB(255, 255, 181, 181),
                        fontFamily: 'Quicksand')),
              ]),
            ),
          ),
          const Spacer()
        ],
      ),
    ));
  }
}
