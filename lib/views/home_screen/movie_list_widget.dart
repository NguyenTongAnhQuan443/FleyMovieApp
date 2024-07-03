import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import '../../models/kkphim/movie.dart';
import '../../view_models/home_screen_view_model.dart';
import '../details_movie_screen/details_movie_screen.dart';

class MovieListWidget extends StatelessWidget {
  final Movie movie;

  const MovieListWidget({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenViewModel>(
      builder: (context, viewModel, child) {
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
                    return FutureBuilder<bool>(
                      future: viewModel.checkImageUrl(posterUrl),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: 120,
                            height: 180,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                          );
                        } else {
                          if (snapshot.hasData && snapshot.data!) {
                            return InkWell(
                              child: Container(
                                width: 120,
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    posterUrl,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.grey.withOpacity(0.5),
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) =>
                                        Image.asset(
                                          'assets/images/default_poster.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                  ),
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
                            );
                          } else {
                            return Container(
                              width: 120,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    );
                  }).toList() ??
                      [],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
