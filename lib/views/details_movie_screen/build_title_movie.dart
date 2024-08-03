import 'package:flutter/material.dart';
import '../../models/kkphim/movie_details.dart';

class BuildTitleMovie extends StatelessWidget {
  final MovieDetails movieDetails;

  const BuildTitleMovie(this.movieDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              movieDetails.movie?.name ?? 'N/A',
              softWrap: true,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          Text(
            movieDetails.movie?.originName ?? 'N/A',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
