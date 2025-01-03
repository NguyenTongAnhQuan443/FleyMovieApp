import 'package:cached_network_image/cached_network_image.dart';
import 'package:fleymovieapp/view_models/find_movies_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/kkphim/movie.dart';
import '../details_movie_screen/movie_details_screen.dart';
import '../more_movies_screen/build_header.dart';

class FindMoviesScreen extends StatefulWidget {
  const FindMoviesScreen({super.key});

  @override
  State<FindMoviesScreen> createState() => _FindMoviesScreenState();
}

class _FindMoviesScreenState extends State<FindMoviesScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final bool _isInitialLoading = true;
  bool _isLoading = false;
  bool _isMounted = true;
  int _currentPage = 1;
  String defaultSearch = '';

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMovies(defaultSearch);
    });
  }

  @override
  void dispose() {
    _isMounted = false;
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      defaultSearch = _textEditingController.text;
      _isLoading = true;
    });
    _fetchMovies(defaultSearch);
  }

  void _fetchMovies(String query) {
    context.read<FindMoviesViewModel>().fetchMovies(query).then((_) {
      if (_isMounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      _loadMoreMovies();
    }
  }

  void _loadMoreMovies() {
    if (!context.read<FindMoviesViewModel>().isLoading) {
      _currentPage++;
      context
          .read<FindMoviesViewModel>()
          .fetchMovies(defaultSearch, isLoadMore: true);
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
            _buildFunctionSearch(),
            !_isInitialLoading
                ? const Center()
                : _buildMoreMovie(crossAxisCount),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreMovie(int crossAxisCount) {
    return Expanded(
      child: Consumer<FindMoviesViewModel>(
        builder: (context, viewModel, child) {
          if (_isLoading) {
            return _buildLoading();
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
                const appDomainCdnImage = 'https://img.phimapi.com/';
                final poster = viewModel.moviesList[index].posterUrl;
                final posterUrl = '$appDomainCdnImage/$poster';

                return _buildItemMovie(viewModel, index, posterUrl);
              },
            );
          } else {
            return _buildNoMoviesFound();
          }
        },
      ),
    );
  }

  Widget _buildItemMovie(
      FindMoviesViewModel viewModel, int indexImagePoster, String posterUrl) {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsScreen(
                              viewModel.moviesList[indexImagePoster].slug!),
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
                      errorWidget: (context, url, error) =>
                          _buildImageDefault(),
                      placeholder: (context, url) => _buildLoading(),
                    ),
                  ),
                ),
              ),
            ),
            _buildTitleMovie(viewModel.moviesList[indexImagePoster]),
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
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleMovie(Items item) {
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
        child:
            Icon(Icons.movie_creation_outlined, color: Colors.white, size: 40),
      ),
    );
  }

  Widget _buildFunctionSearch() {
    return Container(
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
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.3),
        ),
        style: const TextStyle(color: Colors.white),
        controller: _textEditingController,
      ),
    );
  }

  Widget _buildNoMoviesFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo64px.png'),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              'Không tìm thấy phim này\nBạn thử tìm phim khác nhé !',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
