import 'package:cached_network_image/cached_network_image.dart';
import 'package:fleymovieapp/view_models/more_movies_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/kkphim/movie.dart';
import '../details_movie_screen/movie_details_screen.dart';

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
  late ScrollController _scrollController;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<MoreMoviesViewModel>()
          .fetchMovies(widget.typeList, widget.page);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      _loadMoreMovies();
    }
  }

  void _loadMoreMovies() {
    if (!context.read<MoreMoviesViewModel>().isLoading) {
      _currentPage++;
      context
          .read<MoreMoviesViewModel>()
          .fetchMovies(widget.typeList, _currentPage, isLoadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    int crossAxisCount = orientation == Orientation.portrait ? 3 : 5;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
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
            Container(
              height: 40,
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
            Expanded(
              child: Consumer<MoreMoviesViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading && viewModel.moviesList.isEmpty) {
                    return buildLoading();
                  } else if (viewModel.moviesList.isNotEmpty) {
                    return GridView.builder(
                        controller: _scrollController,
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 20),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.5,
                        ),
                        itemCount: viewModel.moviesList.length,
                        itemBuilder: (context, index) {
                          final url = viewModel.moviesList[index].posterUrl;

                          final appDomainCdnImage =
                              viewModel.movie!.data!.appDomainCdnImage;

                          final posterUrl = '${appDomainCdnImage!}/${url!}';

                          return Column(
                            children: [
                              Flexible(
                                child: SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
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
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/default_poster.jpg'),
                                            // Đường dẫn đến ảnh mặc định
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              buildTitleMovie(viewModel.moviesList[index]),
                            ],
                          );
                        });
                  } else {
                    return const Center(
                        child: Text('Không tìm thấy phim, vui lòng thử lại sau',
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

  // Build Poster And Title Movie (Poster error)
  Widget buildPosterAndTitleMovie(Items item, context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 120,
          height: 180,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: buildImageDefault(),
            ),
          ),
        ),
        buildTitleMovie(item),
      ],
    );
  }

  // Widget Image Default
  Widget buildImageDefault() {
    return Image.asset(
      'assets/images/default_poster.jpg',
      fit: BoxFit.cover,
    );
  }
}
