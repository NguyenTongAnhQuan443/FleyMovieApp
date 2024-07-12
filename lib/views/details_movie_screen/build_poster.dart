import 'package:cached_network_image/cached_network_image.dart';
import 'package:fleymovieapp/models/kkphim/movie_details.dart';
import 'package:flutter/material.dart';

class BuildPoster extends StatelessWidget {
  MovieDetails movieDetails;

  BuildPoster(this.movieDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CachedNetworkImage(
        imageUrl: movieDetails.movie!.thumbUrl ??
            'https://kenh14cdn.com/2020/8/1/mv5bzdcxogi0mdytntc5ns00nduzlwfkotitndixzji0otllntljxkeyxkfqcgdeqxvymtmxodk2otuv1-1592454662484458613488-15962494366901991849797.jpg',
        width: double.infinity,
        height: 300,
        fit: BoxFit.cover,
        placeholder: (context, url) => const SizedBox(
          width: 20,
          height: 20,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
        errorWidget: (context, error, child) => Image.asset(
          'assets/images/default_poster.jpg',
          fit: BoxFit.cover,
        ),
      ),
      onTap: () {},
    );
  }
}
