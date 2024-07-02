import 'package:fleymovieapp/data_sources/kkphim/api_services_single_movie.dart';
import 'package:flutter/material.dart';
import 'package:fleymovieapp/view_models/home_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../models/kkphim/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  // Variable
  String nameSource = 'KK Phim';

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    viewModel.fetchSingleMovie(1);
    viewModel.fetchSeriesMovie(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Stack(
                    children: [
                      buildBannerMovie(),
                      buildLogo(),
                    ],
                  ),
                  Consumer<HomeScreenViewModel>(
                    builder: (context, viewModel, child) {
                      if (viewModel.singleMovie != null) {
                        return buildListMovie(viewModel.singleMovie!);
                      } else {
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        );
                      }
                    },
                  ),
                  Consumer<HomeScreenViewModel>(
                    builder: (context, viewModel, child) {
                      if (viewModel.singleMovie != null) {
                        return buildListMovie(viewModel.seriesMovie!);
                      } else {
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            buildButtonSourceMovie(nameSource),
          ],
        ),
      ),
    );
  }


  void _showSourceList(BuildContext context) {
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    List<String> sourceMovie = viewModel.getSourceMovie();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black87,
          height: 400,
          child: ListView.builder(
            itemCount: sourceMovie.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  sourceMovie[index],
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  setState(() {
                    if (index == 0) {
                      nameSource = viewModel.sourceMovie[index];
                      // load data phim ở đây
                    } else {
                      final snackBar = SnackBar(
                        content: const Text(
                            'Nguồn phim đang được cập nhập !\nChúc bạn xem phim vui vẻ'),
                        duration: const Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
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
                onPressed: () {},
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
    return Consumer<HomeScreenViewModel>(
      builder: (context, viewModel, child) {
        List<String> imageBannerUrls = viewModel.getImageBannerUrls();

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            height: 550,
            child: PageView.builder(
              itemCount: imageBannerUrls.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
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
          ),
        );
      },
    );
  }

// List Movie

  Widget buildListMovie(Movie movie) {
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
                  movie.data!.titlePage!,
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
              children: movie.data?.items?.map((item) {
                    final url = item.posterUrl;
                    final appDomainCdnImage = movie.data!.appDomainCdnImage;
                    final posterUrl = '${appDomainCdnImage!}/${url!}';
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

//   Buid Button Source Movie
  Widget buildButtonSourceMovie(String nameSource) {
    return Consumer<HomeScreenViewModel>(builder: (context, viewModel, child) {
      return Positioned(
        right: 16,
        bottom: 16,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            _showSourceList(context);
          },
          child: Row(
            children: [
              const Icon(Icons.shuffle),
              const SizedBox(
                width: 10,
              ),
              Text(
                nameSource,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    });
  }
}
