import 'package:fleymovieapp/view_models/new_movie_view_model.dart';
import 'package:fleymovieapp/view_models/slug_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BannerMovieWidget extends StatefulWidget {
  const BannerMovieWidget({super.key});

  @override
  State<BannerMovieWidget> createState() => _BannerMovieWidgetState();
}

class _BannerMovieWidgetState extends State<BannerMovieWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<NewMovieViewModel>(context, listen: false).fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewMovieViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const _BannerDefault();
        } else if (viewModel.newMovie?.items?.isEmpty ?? true) {
          return const _BannerDefault();
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
                  String slug = _returnSlugMovie(viewModel, originalIndex);
                  _updateSlugProvider(context, slug);

                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      imageUrl,
                      height: 550,
                      width: double.infinity,
                      fit: BoxFit.fill,
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

  void _updateSlugProvider(BuildContext context, String slug) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SlugProvider>(context, listen: false).setSlug(slug);
    });
  }

  String _returnSlugMovie(NewMovieViewModel viewModel, int index) {
    if (index >= 0 && index < viewModel.newMovie!.items!.length) {
      return viewModel.newMovie!.items![index].slug ?? '';
    }
    return '';
  }
}

class _BannerDefault extends StatelessWidget {
  const _BannerDefault();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 550,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.black),
        child: Center(
          child: Icon(
            Icons.movie_creation_outlined,
            color: Colors.white,
            size: 100,
          ),
        ),
      ),
    );
  }
}
