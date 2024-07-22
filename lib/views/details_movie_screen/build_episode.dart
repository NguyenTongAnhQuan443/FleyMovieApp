import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/kkphim/movie_details.dart';
import '../play_video_screen/play_video_screen.dart';

class BuildEpisode extends StatelessWidget {
  MovieDetails movieDetails;

  BuildEpisode(this.movieDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildQuantity(movieDetails),
        buildEpisode(movieDetails),
      ],
    );
  }

  // Widget quantity
  Widget buildQuantity(MovieDetails movieDetails) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${movieDetails.movie?.quality ?? ''} - Danh sách tập',
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // build episode
  Widget buildEpisode(MovieDetails movieDetails) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: GridView.builder(
        shrinkWrap: true,
        // cho phép gridView điều chỉnh theo nội dung
        physics: const NeverScrollableScrollPhysics(),
        // không cho phép gridView cuộn
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Số lượng phần tử trên 1 hàng
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.5),
        // chiều rộng gắp 2.5 lần chiều cao
        itemCount: movieDetails.episodes!.first.serverData!.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  '${movieDetails.episodes!.first.serverData![index].name}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            onTap: () {
              String? url = movieDetails.episodes!.first.serverData![index].linkM3U8;
              Navigator.push(context, MaterialPageRoute(builder: (_) => PlayVideoScreen(url!)));
            },
          );
        },
      ),
    );
  }
}
