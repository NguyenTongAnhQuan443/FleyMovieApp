import 'package:fleymovieapp/models/kkphim/movie_details.dart';
import 'package:flutter/material.dart';

class BuildCategoryMovie extends StatelessWidget {
  MovieDetails movieDetails;

  BuildCategoryMovie(this.movieDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    final category1 = movieDetails.movie!.category!.isNotEmpty
        ? movieDetails.movie!.category![0].name
        : '';
    final category2 = movieDetails.movie!.category!.length > 1
        ? movieDetails.movie!.category![1].name
        : '';
    final category3 = movieDetails.movie!.category!.length > 2
        ? movieDetails.movie!.category![2].name
        : '';
    final category4 = movieDetails.movie!.category!.length > 3
        ? movieDetails.movie!.category![3].name
        : '';
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Text(
        '${movieDetails.movie!.quality} - ${movieDetails.movie!.lang} - $category1 - $category2 - $category3 - $category4',
        style: const TextStyle(
            color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
