import 'dart:ui';

import 'package:fleymovieapp/data_sources/kkphim/api_services_single_movie.dart';
import 'package:fleymovieapp/models/kkphim/single_movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imageBannerUrls = [
    'https://cinema.momocdn.net/img/51864595072123353-wEXCCYzbslBJoym4aeiIV2V7cGz.jpg',
    'https://static2.vieon.vn/vieplay-image/poster_v4/2022/08/25/0snqk97o_660x946-tiemcapheluat.jpg',
    'https://images2.thanhnien.vn/528068263637045248/2024/2/20/special-poster-2-mai-17084211313531000860296.jpg',
  ];

  // Variable
  late SingleMovie? _singleMovie;

  @override
  void initState() {
    super.initState();
    _fetchSingleMovie(1);
  } //Fetch Data

  Future<SingleMovie?> _fetchSingleMovie(int page) async {
    ApiServicesSingleMovie apiService = ApiServicesSingleMovie(page);
    try {
      SingleMovie singleMovie = await apiService.fetchMovie();
      if (singleMovie.data != null && singleMovie.data!.items != null) {
        setState(() {
          _singleMovie = singleMovie;
        });
      } else {
        setState(() {
          _singleMovie = null;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _singleMovie = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                children: [
                  buildBannerMovie(),
                  buildLogo(),
                ],
              ),
              const SizedBox(
                // cách lề 10
                height: 10,
              ),
              buildListMovie(_singleMovie!),
            ],
          ),
        ),
      ),
    );
  }

  // Header - Logo
  Widget buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset('assets/images/logo64px.png'),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Fley',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Movie',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  print('Đã bấm');
                  ApiServicesSingleMovie apiService = ApiServicesSingleMovie(2);
                  try {
                    SingleMovie singleMovie = await apiService.fetchMovie();
                    if (singleMovie.data != null && singleMovie.data!.items != null) {
                      singleMovie.data!.items!.forEach((item) {
                        print(singleMovie.data?.appDomainCdnImage);
                      });
                    }
                  } catch (e) {
                    print('Error: $e');
                  }
                  print('Đã bấm Xong');
                  print('${_singleMovie!.data!.titlePage!}');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(60, 38),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Premium'),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Banner Movie
  Widget buildBannerMovie() {
    return SizedBox(
      height: 550,
      child: PageView.builder(
        itemCount: imageBannerUrls.length, // Số lượng hình ảnh trong danh sách
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Image.network(
                  imageBannerUrls[index],
                  height: 550,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // List Movie

  Widget buildListMovie(SingleMovie singleMovie) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 5),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  singleMovie.data!.titlePage!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const Text(
                  'Xem thêm',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: singleMovie.data?.items?.map((item) {
                final url = item.posterUrl;
                final appDomainCdnImage = singleMovie.data!.appDomainCdnImage;
                final posterUrl = appDomainCdnImage! + '/' + url!;
                    return Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 180,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                // Poster Movie
                                image: NetworkImage(posterUrl),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            height: 42,
                            // Name Movie
                            child: Text(
                              item.name ?? '',
                              style: const TextStyle(color: Colors.white),
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList() ??
                  [], // Handle null case or empty list
            ),
          ),
        ],
      ),
    );
  }
}
