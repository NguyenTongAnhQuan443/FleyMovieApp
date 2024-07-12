import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../models/kkphim/movie.dart';
import '../../view_models/home_screen_view_model.dart';

class MoreMoviesScreen extends StatefulWidget {
  Movie movie;
  int page;


  MoreMoviesScreen(this.movie, this.page);

  @override
  State<StatefulWidget> createState() {
    return _MoreMoviesScreenState(movie, page);
  }
}

class _MoreMoviesScreenState extends State<MoreMoviesScreen> {
  Movie movie;
  int page;


  _MoreMoviesScreenState(this.movie, this.page);

  Future<void> _fetchData() async {
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: false);

    // Dùng SchedulerBinding để đợi build widget hoàn tất mới lắng nghe notifyListeners từ viewModel
    String type = getLastSegment(movie.data!.seoOnPage!.ogUrl!);
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        await viewModel.fetchMovie(type, page);
        // if (!viewModel.isLoading) {
        //   // Navigator.pushReplacement(context,
        //   //     MaterialPageRoute(builder: (context) => const HomeScreen()));
        // }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // final Movie movies = movie.data!.params.pagination.currentPage;
    final viewModel = Provider.of<HomeScreenViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Khám phá
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Khám phá',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            // Tìm kiếm
            Container(
              height: 40,
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  hintText: 'Nhập tên phim cần tìm ...',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 10, right: 10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    // crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.70,
                  ),
                  // itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 120,
                          height: 160,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://live.staticflickr.com/1545/25121444381_2864ed0da9_b.jpg',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const SizedBox(
                                width: 20,
                                height: 20,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // errorWidget: (context, url, error) =>
                              //     buildPosterAndTitleMovie(item, context),
                            ),
                          ),
                        ),
                        // buildTitleMovie(item),
                      ],
                    );
                  },
                ),
              ),
            ),

            // Next page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

//     // Widget Image Default
//     Widget buildImageDefault() {
//       return Image.asset(
//         'assets/images/default_poster.jpg',
//         fit: BoxFit.cover,
//       );
//     }
//
//     // Build Title Movie
//     Widget buildTitleMovie(Items item) {
//       return Container(
//         width: 110,
//         height: 50,
//         padding: const EdgeInsets.only(top: 5),
//         child: Text(
//           item.name!,
//           maxLines: 2,
//           textAlign: TextAlign.center,
//           overflow: TextOverflow.ellipsis,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 12,
//           ),
//         ),
//       );
//     }
//
// // Build Poster And Title Movie (Poster error or waiting)
//     Widget buildPosterAndTitleMovie(Items item, context) {
//       return Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.only(right: 10),
//             width: 120,
//             height: 180,
//             child: Center(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: buildImageDefault(),
//               ),
//             ),
//           ),
//           buildTitleMovie(item),
//         ],
//       );
//     }
  }

  // cắt slug
  String getLastSegment(String url) {
    int lastSlashIndex = url.lastIndexOf('/');
    return url.substring(lastSlashIndex + 1);
  }
}
