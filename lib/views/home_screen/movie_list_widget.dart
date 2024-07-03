import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../models/kkphim/movie.dart';
import '../details_movie_screen/details_movie_screen.dart';
import 'package:http/http.dart' as http;

class MovieListWidget extends StatefulWidget {
  final Movie movie;

  const MovieListWidget({super.key, required this.movie});

  @override
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  Future<bool> _isImageValid(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

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
                  widget.movie.data!.titlePage!,
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
              children: widget.movie.data?.items?.map((item) {
                    final url = item.posterUrl;
                    final appDomainCdnImage =
                        widget.movie.data!.appDomainCdnImage;
                    final posterUrl = '${appDomainCdnImage!}/${url!}';
                    return Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: Column(
                        children: [
                          InkWell(
                            child: Container(
                              width: 120,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FutureBuilder<bool>(
                                future: _isImageValid(posterUrl),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text("");
                                  } else if (snapshot.hasError ||
                                      !snapshot.hasData ||
                                      snapshot.data == false) {
                                    return Image.asset(
                                        'assets/images/default_poster.jpg');
                                  } else {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: posterUrl,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                'assets/images/default_poster.jpg'),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DetailsMovieScreen(),
                                ),
                              );
                            },
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
