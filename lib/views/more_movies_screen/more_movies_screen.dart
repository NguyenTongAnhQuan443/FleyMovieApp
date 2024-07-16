import 'package:cached_network_image/cached_network_image.dart';
import 'package:fleymovieapp/view_models/more_movies_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/kkphim/movie.dart';

class MoreMoviesScreen extends StatefulWidget {
  String typeList;
  int page;

  MoreMoviesScreen(this.typeList, this.page, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _MoreMoviesScreenState();
  }
}

class _MoreMoviesScreenState extends State<MoreMoviesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<MoreMoviesViewModel>()
          .fetchMovies(widget.typeList, widget.page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Khám phá
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Khám phá',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            // Tìm kiếm
            Container(
              height: 40,
              margin: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 30),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  hintText: 'Nhập tên phim cần tìm ...',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                ),
              ),
            ),
            // build phim container
            Expanded(
              child: Consumer<MoreMoviesViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading) {
                    return buildLoading();
                  } else if (viewModel.movie != null) {
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.5,
                        ),
                        itemCount: viewModel.movie!.data!.items!.length,
                        itemBuilder: (context, index) {
                          final url =
                              viewModel.movie!.data!.items![index].posterUrl;

                          final appDomainCdnImage =
                              viewModel.movie!.data!.appDomainCdnImage;

                          final posterUrl = '${appDomainCdnImage!}/${url!}';

                          return Column(
                            children: [
                              Flexible(
                                child: Container(
                                  // margin: const EdgeInsets.only(right: 10),
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: ClipRRect(
                                    // borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: posterUrl,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      // errorWidget: (context, url, error) =>
                                      //     buildPosterAndTitleMovie(item, context),
                                    ),
                                  ),
                                ),
                              ),
                              buildTitleMovie(
                                  viewModel.movie!.data!.items![index]),
                            ],
                          );
                        });
                  } else {
                    return const Center(
                        child: Text('Không tìm thấy phim',
                            style: TextStyle(color: Colors.white)));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build Title Movie
  Widget buildTitleMovie(Items item) {
    return Container(
      width: 110,
      height: 50,
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
    );
  }

  // build widget loading
  Widget buildLoading() {
    return const SizedBox(
      width: 30,
      height: 30,
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
