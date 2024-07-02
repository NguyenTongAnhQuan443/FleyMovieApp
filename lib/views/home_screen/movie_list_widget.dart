import 'package:flutter/material.dart';
import '../../models/kkphim/movie.dart';

class MovieListWidget extends StatelessWidget {
  final Movie movie;

  const MovieListWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 5),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  movie.data!.titlePage!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'Xem thêm',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: movie.data?.items?.map((item) {
                final url = item.posterUrl;
                final appDomainCdnImage = movie.data!.appDomainCdnImage;
                final posterUrl = '${appDomainCdnImage!}/${url!}';
                return Container(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(posterUrl),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Container(
                        width: 120,
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          item.name!,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList() ??
                  [],
            ),
          ),
        ],
      ),
    );
  }
}
