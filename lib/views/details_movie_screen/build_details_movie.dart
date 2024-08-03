import 'package:fleymovieapp/models/kkphim/movie_details.dart';
import 'package:flutter/material.dart';

class BuildDetailsMovie extends StatelessWidget {
  final MovieDetails movieDetails;

  const BuildDetailsMovie(this.movieDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    final movie = movieDetails.movie;
    if (movie == null) {
      return Container(
        margin: const EdgeInsets.only(left: 10),
        child: const Text(
          'Thông tin phim không có sẵn',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }

    final actors = (movie.actor ?? []).take(4).join(' - ');

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
            movie.content ?? '',
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
              'Đạo diễn: ${movie.director ?? 'N/A'}',
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
              'Diễn viên: $actors',
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
