import 'package:cached_network_image/cached_network_image.dart';
import 'package:fleymovieapp/view_models/more_movies_view_model.dart';
import 'package:fleymovieapp/views/more_movies_screen/build_header.dart';
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
            const BuildHeader(),
            buildMoreMovie(crossAxisCount),
          ],
        ),
      ),
    );
  }

  // build more movie
  Widget buildMoreMovie(int crossAxisCount) {
    return Expanded(
      child: Consumer<MoreMoviesViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.moviesList.isEmpty) {
            return buildLoading();
          } else if (viewModel.moviesList.isNotEmpty) {
            return GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.5,
              ),
              itemCount: viewModel.moviesList.length,
              itemBuilder: (context, index) {
                final appDomainCdnImage =
                    viewModel.movie!.data!.appDomainCdnImage;

                final poster = viewModel.moviesList[index].posterUrl;
                final thumb = viewModel.moviesList[index].thumbUrl;

                final posterUrl = '${appDomainCdnImage!}/${poster!}';
                final thumbUrl = '$appDomainCdnImage/${thumb!}';

                return buildItemMovie(
                    viewModel, index, posterUrl, thumbUrl, true);
              },
            );
          } else {
            return const Center(
                child: Text('Không tìm thấy phim, vui lòng thử lại sau',
                    style: TextStyle(color: Colors.white)));
          }
        },
      ),
    );
  }

  // build Item Movie (true => poster, false => thumb)
  Widget buildItemMovie(MoreMoviesViewModel viewModel, int indexImagePoster,
      String posterUrl, String thumbUrl, bool boolPoster) {
    return Stack(
      children: [
        Column(
          children: [
            Flexible(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (_) => MoreMoviesViewModel(),
                            // Dispose current MoreMoviesViewModel
                            child: MovieDetailsScreen(
                                viewModel.moviesList[indexImagePoster].slug!),
                          ),
                        ),
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: boolPoster ? posterUrl : thumbUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      //
                      errorWidget: (context, url, error) => buildImageDefault(),
                      //
                      // placeholder: (context, url) => buildLoading(),
                    ),
                  ),
                ),
              ),
            ),
            buildTitleMovie(viewModel.moviesList[indexImagePoster]),
          ],
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
            width: 95,
            height: 18,
            child: Center(
                child: Text(
              '${viewModel.moviesList[indexImagePoster].quality}-${viewModel.moviesList[indexImagePoster].lang}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            )),
          ),
        ),
      ],
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

  // Widget Image Default
  Widget buildImageDefault() {
    return Container(
      color: Colors.black,
      child: const Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
