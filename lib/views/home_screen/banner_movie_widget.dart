import 'package:fleymovieapp/view_models/new_movie_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../view_models/home_screen_view_model.dart';

class BannerMovieWidget extends StatefulWidget {
  const BannerMovieWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BannerMovieWidgetState();
  }
}

class _BannerMovieWidgetState extends State<BannerMovieWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<NewMovieViewModel>(context, listen: false).fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewMovieViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return SizedBox(
            height: 500,
            width: double.infinity,
            child: Image.asset(
              'assets/images/default_poster.jpg',
              fit: BoxFit.cover,
            ),
          );
        } else if (viewModel.newMovie == null ||
            viewModel.newMovie!.items == null ||
            viewModel.newMovie!.items!.isEmpty) {
          return SizedBox(
            height: 500,
            width: double.infinity,
            child: Image.asset(
              'assets/images/default_poster.jpg',
              fit: BoxFit.cover,
            ),
          );
        } else {
          List<String> imageBannerUrls = viewModel.newMovie!.items!
              .map((item) => item.posterUrl ?? '')
              .where((url) => url.isNotEmpty)
              .toList();

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              height: 500,
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
        }
      },
    );
  }
}

Widget buildBannerDefault() {
  return SizedBox(
    height: 500,
    width: double.infinity,
    child: Image.asset(
      'assets/images/default_poster.jpg',
      fit: BoxFit.cover,
    ),
  );
}
