import 'package:fleymovieapp/views/details_movie_screen/build_category_movie.dart';
import 'package:fleymovieapp/views/details_movie_screen/build_details_movie.dart';
import 'package:fleymovieapp/views/details_movie_screen/build_poster.dart';
import 'package:fleymovieapp/models/kkphim/movie_details.dart';
import 'package:fleymovieapp/view_models/movie_details_screen_view_model.dart';
import 'package:fleymovieapp/views/details_movie_screen/build_source_movie.dart';
import 'package:fleymovieapp/views/details_movie_screen/build_title_movie.dart';
import 'package:fleymovieapp/views/details_movie_screen/build_watch_a_movie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  String slug;

  MovieDetailsScreen(this.slug, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _DetailsMovieScreenState(slug);
  }
}

class _DetailsMovieScreenState extends State<MovieDetailsScreen> {
  String slug;

  _DetailsMovieScreenState(this.slug);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailsScreenViewModel()..fetchMovieDetails(slug),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Consumer<MovieDetailsScreenViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              } else if (viewModel.movieDetails != null) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          // Đè tên phim - thể loại lên poster
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

                          const BuildSourceMovie(),

                          BuildDetailsMovie(viewModel.movieDetails!),

                          // buildEpisode(items), FIX SAU
                        ],
                      ),
                    ),
                    onTapArrow(),
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    'Chúng mình đang cố gắn khắc phục\nbạn hãy quay lại thử lại sau nhé <3',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // OnTap Button Arrow
  Widget onTapArrow() {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
    );
  }

// Widget Episode
  Widget buildEpisode(List<int> items) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, top: 20),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Full HD - Danh sách tập',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          child: GridView.builder(
            shrinkWrap: true,
            // cho phép gridView điều chỉnh theo nội dung
            physics: const NeverScrollableScrollPhysics(),
            // không cho phép gridView cuộn
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Số lượng phần tử trên 1 hàng
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.4),
            // chiều rộng gắp 2.5 lần chiều cao
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '${items[index]}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
