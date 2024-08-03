import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/kkphim/movie_details.dart';
import '../play_video_screen/play_video_screen.dart';

class BuildEpisode extends StatelessWidget {
  final MovieDetails movieDetails;

  const BuildEpisode(this.movieDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildQuantity(),
        _buildEpisode(context),
      ],
    );
  }

  // Widget quantity
  Widget _buildQuantity() {
    final quality = movieDetails.movie?.quality ?? '';
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$quality - Danh sách tập',
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // Build episode
  Widget _buildEpisode(BuildContext context) {
    final episodes = movieDetails.episodes?.first.serverData ?? [];
    return Container(
      margin: const EdgeInsets.all(20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2.5,
        ),
        itemCount: episodes.length,
        itemBuilder: (context, index) {
          final episode = episodes[index];
          return InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  episode.name ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            onTap: () {
              final url = episode.linkM3U8 ?? '';
              final movie = movieDetails.movie!;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlayVideoScreen(
                    movieUrl: url,
                    slug: movie.slug!,
                    episode: index,
                    posterUrl: movie.posterUrl!,
                    name: movie.name!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
