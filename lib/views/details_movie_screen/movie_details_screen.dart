import 'package:fleymovieapp/views/details_movie_screen/build_category_movie.dart';
import 'package:fleymovieapp/views/details_movie_screen/build_details_movie.dart';
import 'package:fleymovieapp/views/details_movie_screen/build_episode.dart';
import 'package:fleymovieapp/views/details_movie_screen/build_movie_error.dart';
import 'package:fleymovieapp/views/details_movie_screen/build_poster.dart';
import 'package:fleymovieapp/view_models/movie_details_screen_view_model.dart';
import 'package:fleymovieapp/views/details_movie_screen/build_episode_current_movie.dart';
import 'package:fleymovieapp/views/details_movie_screen/build_title_movie.dart';
import 'package:fleymovieapp/views/details_movie_screen/build_watch_a_movie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String slug;

  const MovieDetailsScreen(this.slug, {super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late final MovieDetailsScreenViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = MovieDetailsScreenViewModel();
    viewModel.fetchMovieDetails(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieDetailsScreenViewModel>.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Consumer<MovieDetailsScreenViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else if (viewModel.movieDetails != null &&
                  viewModel.movieDetails!.status != false) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              BuildPoster(viewModel.movieDetails!),
                              Positioned(
                                bottom: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BuildTitleMovie(viewModel.movieDetails!),
                                    BuildCategoryMovie(viewModel.movieDetails!),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const BuildWatchAMovie(),
                          BuildEpisodeCurrentMovie(viewModel.movieDetails!),
                          BuildEpisode(viewModel.movieDetails!),
                          BuildDetailsMovie(viewModel.movieDetails!),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Stack(
                  children: [
                    const BuildMovieError(),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
