import 'package:cached_network_image/cached_network_image.dart';
import 'package:fleymovieapp/view_models/more_movies_view_model.dart';
import 'package:fleymovieapp/views/more_movies_screen/build_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/kkphim/movie.dart';
import '../details_movie_screen/movie_details_screen.dart';

class MoreMoviesScreen extends StatefulWidget {
  final String typeList;
  final int page;

  const MoreMoviesScreen(this.typeList, this.page, {super.key});

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
      context.read<MoreMoviesViewModel>().fetchMovies(widget.typeList, widget.page);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      _loadMoreMovies();
    }
  }

  void _loadMoreMovies() {
    if (!context.read<MoreMoviesViewModel>().isLoading) {
      _currentPage++;
      context.read<MoreMoviesViewModel>().fetchMovies(widget.typeList, _currentPage, isLoadMore: true);
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
            Expanded(child: _buildMoreMovie(crossAxisCount)),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreMovie(int crossAxisCount) {
    return Consumer<MoreMoviesViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading && viewModel.moviesList.isEmpty) {
          return _buildLoading();
        } else if (viewModel.moviesList.isNotEmpty) {
          return GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.5,
            ),
            itemCount: viewModel.moviesList.length,
            itemBuilder: (context, index) {
              final appDomainCdnImage = viewModel.movie?.data?.appDomainCdnImage;
              final poster = viewModel.moviesList[index].posterUrl;
              final posterUrl = '$appDomainCdnImage/$poster';

              return _buildItemMovie(viewModel, index, posterUrl);
            },
          );
        } else {
          return const Center(
            child: Text(
              'Không tìm thấy phim, vui lòng thử lại sau',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      },
    );
  }

  Widget _buildItemMovie(MoreMoviesViewModel viewModel, int index, String posterUrl) {
    final movie = viewModel.moviesList[index];

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
                            child: MovieDetailsScreen(movie.slug!),
                          ),
                        ),
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: posterUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => _buildImageDefault(),
                      placeholder: (context, url) => _buildLoading(),
                    ),
                  ),
                ),
              ),
            ),
            _buildTitleMovie(movie),
          ],
        ),
        _buildLabelQualityAndLang(movie),
      ],
    );
  }

  Widget _buildLabelQualityAndLang(Items movie) {
    return Positioned(
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
            '${movie.quality}-${movie.lang}',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleMovie(Items movie) {
    return Container(
      width: 110,
      height: 50,
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        movie.name!,
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

  Widget _buildLoading() {
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

  Widget _buildImageDefault() {
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
