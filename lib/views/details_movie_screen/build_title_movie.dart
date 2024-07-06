import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/kkphim/movie_details.dart';

class BuildTitleMovie extends StatelessWidget {
  MovieDetails movieDetails;

  BuildTitleMovie(this.movieDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movieDetails.movie?.name ?? 'Phi Vụ Triệu Đô (Mùa 1)',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              Text(
                movieDetails.movie?.originName ?? 'Phi Vụ Triệu Đô (Mùa 1)',
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
