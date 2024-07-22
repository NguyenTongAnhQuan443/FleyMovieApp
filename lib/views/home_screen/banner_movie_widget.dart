import 'package:fleymovieapp/view_models/new_movie_view_model.dart';
import 'package:fleymovieapp/view_models/slug_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BannerMovieWidget extends StatefulWidget {
  const BannerMovieWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BannerMovieWidgetState();
  }
}

class _BannerMovieWidgetState extends State<BannerMovieWidget> {
  static String slug = '';

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
          return buildBannerDefault();
        } else if (viewModel.newMovie == null ||
            viewModel.newMovie!.items == null ||
            viewModel.newMovie!.items!.isEmpty) {
          return buildBannerDefault();
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
                  String imageUrl = imageBannerUrls[index];
                  int originalIndex = viewModel.newMovie!.items!
                      .indexWhere((item) => item.posterUrl == imageUrl);
                   slug = returnSlugMovie(viewModel, originalIndex);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Provider.of<SlugProvider>(context, listen: false).setSlug(slug);
                  });
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Image.network(
                          imageUrl,
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

String returnSlugMovie(NewMovieViewModel viewModel, int index) {
  if (viewModel.newMovie != null &&
      viewModel.newMovie!.items != null &&
      index >= 0 &&
      index < viewModel.newMovie!.items!.length) {
    return viewModel.newMovie!.items![index].slug ?? '';
  }
  return '';
}
