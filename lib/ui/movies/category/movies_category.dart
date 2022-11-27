import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies/ui/movies/category/movies_by_category.dart';

import '../../search/search.dart';
import '../../shared/app_drawer.dart';
import 'category.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _CategoryPageState extends State<CategoryPage> {
  static List<Category> category = [
    Category('Lãng Mạn', 'https://wallpaperaccess.com/full/4676700.jpg'),
    Category('Hành Động', 'https://wallpaperaccess.com/full/983569.jpg'),
    Category('Âm Nhạc',
        'https://www.newstatesman.com/wp-content/uploads/sites/2/2021/11/202145-Film.jpg'),
    Category('Viễn Tưởng',
        'https://img.wallpapersafari.com/desktop/1680/1050/33/16/OmuTd2.jpg'),
    Category("Cổ Trang",
        'https://cdn.tgdd.vn/Files/2021/05/28/1355596/top-10-bo-phim-kiem-hiep-trung-quoc-hay-nhat-tu-truoc-den-nay-202105282248110338.jpg'),
    Category('Hoạt Hình', 'https://wallpapercave.com/wp/wp7153326.jpg'),
    Category('Chiến Tranh',
        'https://press.hulu.com/wp-content/uploads/2021/05/19170_program_tile_horizontal_.jpg?resize=792%2C469'),
    Category('LGBT',
        'https://vcdn1-giaitri.vnecdn.net/2018/01/09/settopcallmebyyourname-1515496469.jpg?w=500&h=300&q=100&dpr=1&fit=crop&s=tbKEV651ME8-K2qJ_rzpwg'),
    Category('Kinh Dị',
        'https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1500w,f_auto,q_auto:best/rockcms/2022-06/scariest-horror-movies-it-stephen-king-2x1-bn-220617-e38851.jpg'),
    Category('Tâm Lý',
        'https://6.vikiplatform.com/image/217498d448314981ba36e0280882c799/dummy.jpg?x=b&a=0x0&s=480x270&e=t&q=g'),
    Category('Siêu Anh Hùng',
        'https://8ternal.com.vn/wp-content/uploads/2018/04/15400_1920x1080.jpg')
  ];

  List<Category> display = List.from(category);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 32, 26, 63),
      endDrawer: const AppDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
              icon: Icon(
                Icons.account_circle,
                size: height * 1 / 35,
              ))
        ],
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: const Color.fromARGB(255, 8, 6, 29),
        toolbarHeight: height * 1 / 15,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Thể Loại',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: height * 1 / 30),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => showSearch(
                  context: context, delegate: Search()), //Navigator.of(context)
              //.push(MaterialPageRoute(builder: (_) => Search())),
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 5),
        itemCount: display.length,
        itemBuilder: (context, index) => GridTile(
            child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => MoviesByCategory(display[index].title)));
          },
          child: Stack(
            children: [
              Opacity(
                opacity: 0.3,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          display[index].image,
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    display[index].title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),

      // child: SafeArea(
      //   child: Column(
      //     children: [
      //       Container(
      //         width: double.infinity,
      //         child: Wrap(
      //           children: [
      //             Stack(
      //               children: [
      //                 Opacity(
      //                   opacity: 0.3,
      //                   child: Container(
      //                     height: 100,
      //                     width: 170,
      //                     margin: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       image: const DecorationImage(
      //                           image: NetworkImage(
      //                               "https://wallpaperaccess.com/full/4676700.jpg"),
      //                           fit: BoxFit.cover),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 100,
      //                   width: 170,
      //                   margin: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.0),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       "Tình Cảm",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Stack(
      //               children: [
      //                 Opacity(
      //                   opacity: 0.3,
      //                   child: Container(
      //                     height: 100,
      //                     width: 170,
      //                     margin: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       image: const DecorationImage(
      //                           image: NetworkImage(
      //                               "https://wallpaperaccess.com/full/983569.jpg"),
      //                           fit: BoxFit.cover),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 100,
      //                   width: 170,
      //                   margin: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.0),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       "Hành Động",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Stack(
      //               children: [
      //                 Opacity(
      //                   opacity: 0.3,
      //                   child: Container(
      //                     height: 100,
      //                     width: 170,
      //                     margin: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       image: const DecorationImage(
      //                           image: NetworkImage(
      //                               "https://www.newstatesman.com/wp-content/uploads/sites/2/2021/11/202145-Film.jpg"),
      //                           fit: BoxFit.cover),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 100,
      //                   width: 170,
      //                   margin: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.0),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       "Âm Nhạc",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Stack(
      //               children: [
      //                 Opacity(
      //                   opacity: 0.3,
      //                   child: Container(
      //                     height: 100,
      //                     width: 170,
      //                     margin: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       image: const DecorationImage(
      //                           image: NetworkImage(
      //                               "https://img.wallpapersafari.com/desktop/1680/1050/33/16/OmuTd2.jpg"),
      //                           fit: BoxFit.cover),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 100,
      //                   width: 170,
      //                   margin: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.0),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       "Khoa Học\nViễn Tưởng",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Stack(
      //               children: [
      //                 Opacity(
      //                   opacity: 0.3,
      //                   child: Container(
      //                     height: 100,
      //                     width: 170,
      //                     margin: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       image: const DecorationImage(
      //                           image: NetworkImage(
      //                               "https://cdn.tgdd.vn/Files/2021/05/28/1355596/top-10-bo-phim-kiem-hiep-trung-quoc-hay-nhat-tu-truoc-den-nay-202105282248110338.jpg"),
      //                           fit: BoxFit.cover),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 100,
      //                   width: 170,
      //                   margin: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.0),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       "Kiếm Hiệp",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Stack(
      //               children: [
      //                 Opacity(
      //                   opacity: 0.3,
      //                   child: Container(
      //                     height: 100,
      //                     width: 170,
      //                     margin: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       image: const DecorationImage(
      //                           image: NetworkImage(
      //                               "https://i.ytimg.com/vi/7hjPxUfV32Q/maxresdefault.jpg"),
      //                           fit: BoxFit.cover),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 100,
      //                   width: 170,
      //                   margin: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.0),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       "Trinh Thám",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Stack(
      //               children: [
      //                 Opacity(
      //                   opacity: 0.3,
      //                   child: Container(
      //                     height: 100,
      //                     width: 170,
      //                     margin: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       image: const DecorationImage(
      //                           image: NetworkImage(
      //                               "https://images5.alphacoders.com/606/606284.jpg"),
      //                           fit: BoxFit.cover),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 100,
      //                   width: 170,
      //                   margin: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.0),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       "Anime",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Stack(
      //               children: [
      //                 Opacity(
      //                   opacity: 0.3,
      //                   child: Container(
      //                     height: 100,
      //                     width: 170,
      //                     margin: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       image: const DecorationImage(
      //                           image: NetworkImage(
      //                               "https://wallpapercave.com/wp/wp7153326.jpg"),
      //                           fit: BoxFit.cover),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 100,
      //                   width: 170,
      //                   margin: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.0),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       "Cartoon",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Stack(
      //               children: [
      //                 Opacity(
      //                   opacity: 0.3,
      //                   child: Container(
      //                     height: 100,
      //                     width: 170,
      //                     margin: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       image: const DecorationImage(
      //                           image: NetworkImage(
      //                               "https://6.vikiplatform.com/image/217498d448314981ba36e0280882c799/dummy.jpg?x=b&a=0x0&s=480x270&e=t&q=g"),
      //                           fit: BoxFit.cover),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 100,
      //                   width: 170,
      //                   margin: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.0),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       "Tâm Lý",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Stack(
      //               children: [
      //                 Opacity(
      //                   opacity: 0.3,
      //                   child: Container(
      //                     height: 100,
      //                     width: 170,
      //                     margin: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       image: const DecorationImage(
      //                           image: NetworkImage(
      //                               "https://press.hulu.com/wp-content/uploads/2021/05/19170_program_tile_horizontal_.jpg?resize=792%2C469"),
      //                           fit: BoxFit.cover),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 100,
      //                   width: 170,
      //                   margin: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.0),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       "Chiến Tranh",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Stack(
      //               children: [
      //                 Opacity(
      //                   opacity: 0.3,
      //                   child: Container(
      //                     height: 100,
      //                     width: 170,
      //                     margin: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       image: const DecorationImage(
      //                           image: NetworkImage(
      //                               "https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1500w,f_auto,q_auto:best/rockcms/2022-06/scariest-horror-movies-it-stephen-king-2x1-bn-220617-e38851.jpg"),
      //                           fit: BoxFit.cover),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 100,
      //                   width: 170,
      //                   margin: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.0),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       "Kinh Dị",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Stack(
      //               children: [
      //                 Opacity(
      //                   opacity: 0.3,
      //                   child: Container(
      //                     height: 100,
      //                     width: 170,
      //                     margin: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       image: const DecorationImage(
      //                           image: NetworkImage(
      //                               "https://vcdn1-giaitri.vnecdn.net/2018/01/09/settopcallmebyyourname-1515496469.jpg?w=500&h=300&q=100&dpr=1&fit=crop&s=tbKEV651ME8-K2qJ_rzpwg"),
      //                           fit: BoxFit.cover),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 100,
      //                   width: 170,
      //                   margin: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.0),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       "LGBTQ+",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Stack(
      //               children: [
      //                 Opacity(
      //                   opacity: 0.3,
      //                   child: Container(
      //                     height: 100,
      //                     width: 170,
      //                     margin: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       image: const DecorationImage(
      //                           image: NetworkImage(
      //                               "https://8ternal.com.vn/wp-content/uploads/2018/04/15400_1920x1080.jpg"),
      //                           fit: BoxFit.cover),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 100,
      //                   width: 170,
      //                   margin: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.0),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       "Siêu Anh Hùng",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Stack(
      //               children: [
      //                 Opacity(
      //                   opacity: 0.3,
      //                   child: Container(
      //                     height: 100,
      //                     width: 170,
      //                     margin: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       image: const DecorationImage(
      //                           image: NetworkImage(
      //                               "https://s3.cloud.cmctelecom.vn/tinhte1/2017/10/4153018_C_Geostorm.jpg"),
      //                           fit: BoxFit.cover),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 100,
      //                   width: 170,
      //                   margin: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.0),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       "Thảm Hoạ",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Stack(
      //               children: [
      //                 Opacity(
      //                   opacity: 0.3,
      //                   child: Container(
      //                     height: 100,
      //                     width: 360,
      //                     margin: const EdgeInsets.all(10),
      //                     decoration: BoxDecoration(
      //                       image: const DecorationImage(
      //                           image: NetworkImage(
      //                               "https://s.studiobinder.com/wp-content/uploads/2019/09/Movie-Genres-Types-of-Movies-List-of-Genres-and-Categories-Header-StudioBinder.jpg"),
      //                           fit: BoxFit.cover),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 100,
      //                   width: 360,
      //                   margin: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10.0),
      //                   ),
      //                   child: const Center(
      //                     child: Text(
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       "Thể Loại Khác",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // )
    );
  }
}
