import 'package:fleymovieapp/models/kkphim/movie_details.dart';
import 'package:flutter/material.dart';

class BuildDetailsMovie extends StatelessWidget {
  MovieDetails movieDetails;

  BuildDetailsMovie(this.movieDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    final actor1 = movieDetails.movie!.actor!.isNotEmpty
        ? movieDetails.movie!.actor![0]
        : '';
    final actor2 = movieDetails.movie!.actor!.length > 1
        ? movieDetails.movie!.actor![1]
        : '';
    final actor3 = movieDetails.movie!.actor!.length > 2
        ? movieDetails.movie!.actor![2]
        : '';
    final actor4 = movieDetails.movie!.actor!.length > 3
        ? movieDetails.movie!.actor![3]
        : '';
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Nội dung phim',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          Text(
            movieDetails.movie!.content ?? '',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              'Đạo diễn: ${movieDetails.movie!.director}',
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              'Diễn viên: $actor1 - $actor2 - $actor3 - $actor4',
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
