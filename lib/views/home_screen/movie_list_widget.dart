import 'package:cached_network_image/cached_network_image.dart';
import 'package:fleymovieapp/views/more_movies_screen/more_movies_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import '../../models/kkphim/movie.dart';
import '../../view_models/home_screen_view_model.dart';
import '../details_movie_screen/movie_details_screen.dart';

class MovieListWidget extends StatelessWidget {
  final Movie movie;

  const MovieListWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          margin: const EdgeInsets.only(top: 10, left: 8),
          child: Column(
            children: [
              buildTitlePage(context, movie.data!.typeList),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: movie.data?.items?.map((item) {
                        final url = item.posterUrl;
                        const appDomainCdnImage = 'https://img.phimapi.com/';
                        final posterUrl = '${appDomainCdnImage!}/${url!}';
                        return InkWell(
                          child: FutureBuilder<bool>(
                            future: viewModel.checkImageUrl(posterUrl),
                            builder: (context, snapshot)
                            {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return buildPosterAndTitleMovieWaiting(
                                    item, context);
                              } else {
                                if (snapshot.hasData && snapshot.data!) {
                                  return buildPosterAndMovieDataTrue(
                                      item, posterUrl, context);
                                } else {
                                  return buildPosterAndTitleMovie(
                                      item, context);
                                }
                              }
                            },
                          ),
                          onTap: () {
                            String? slugMovie = item.slug;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailsScreen(slugMovie!),
                              ),
                            );
                          },
                        );
                      }).toList() ??
                      [],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Build Title Page
  Widget buildTitlePage(context, String? typeList) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            movie.data!.titlePage!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            child: const Text(
              'Xem thêm',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MoreMoviesScreen('$typeList', 1)));
            },
          ),
        ],
      ),
    );
  }

  // Widget Image Default
  Widget buildImageDefault() {
    return Image.asset(
      'assets/images/default_poster.jpg',
      fit: BoxFit.cover,
    );
  }

  // Build Title Movie
  Widget buildTitleMovie(Items item) {
    return Container(
      width: 110,
      height: 50,
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        item.name!,
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }

// Build Poster And Title Movie (Poster error)
  Widget buildPosterAndTitleMovie(Items item, context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 120,
          height: 180,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: buildImageDefault(),
            ),
          ),
        ),
        buildTitleMovie(item),
      ],
    );
  }

  // Build poster and title waiting
  Widget buildPosterAndTitleMovieWaiting(Items item, context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(right: 10),
            width: 120,
            height: 180,
            child: const SizedBox(
              width: 5,
              height: 5,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )),
        buildTitleMovie(item),
      ],
    );
  }

  // Build Poster And Title (Data true)
  Widget buildPosterAndMovieDataTrue(Items item, String posterUrl, context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 120,
          height: 180,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: posterUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              errorWidget: (context, url, error) =>
                  buildPosterAndTitleMovie(item, context),
            ),
          ),
        ),
        buildTitleMovie(item),
      ],
    );
  }
}
