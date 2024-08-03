import 'package:fleymovieapp/models/kkphim/movie_details.dart';
import 'package:flutter/material.dart';

class BuildCategoryMovie extends StatelessWidget {
  final MovieDetails movieDetails;

  const BuildCategoryMovie(this.movieDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    List<String?> categories = movieDetails.movie!.category!
        .map((category) => category.name)
        .take(4)
        .toList();
    String categoryString = categories.join(' - ');

    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Text(
        '${movieDetails.movie!.quality} - ${movieDetails.movie!.lang} - $categoryString',
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
