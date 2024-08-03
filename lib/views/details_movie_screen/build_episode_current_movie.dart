import 'package:flutter/material.dart';

import '../../models/kkphim/movie_details.dart';

class BuildEpisodeCurrentMovie extends StatelessWidget {
  final MovieDetails movieDetails;

  const BuildEpisodeCurrentMovie(this.movieDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    final episodeTotal = movieDetails.movie?.episodeTotal ?? 'N/A';
    final episodeCurrent = movieDetails.movie?.episodeCurrent ?? 'N/A';

    return Container(
      margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tổng số tập: $episodeTotal',
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
          ),
          Text(
            'Tập hiện tại: $episodeCurrent',
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
