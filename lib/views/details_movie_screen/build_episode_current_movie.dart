import 'package:flutter/material.dart';

import '../../models/kkphim/movie_details.dart';

class BuildEpisodeCurrentMovie extends StatelessWidget {
  MovieDetails movieDetails;

  BuildEpisodeCurrentMovie(this.movieDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tổng số tập: ${movieDetails.movie!.episodeTotal ?? 'N/A'}',
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
          ),

          Text(
            'Tập hiện tại: ${movieDetails.movie!.episodeCurrent ?? 'N/A'}',
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
