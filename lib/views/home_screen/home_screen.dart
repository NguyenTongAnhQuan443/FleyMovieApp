import 'package:fleymovieapp/views/home_screen/banner_movie_widget.dart';
import 'package:fleymovieapp/views/home_screen/movie_list_widget.dart';
import 'package:fleymovieapp/views/home_screen/logo_widget.dart';
import 'package:fleymovieapp/views/home_screen/source_list_modal.dart';
import 'package:flutter/material.dart';
import 'package:fleymovieapp/view_models/home_screen_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String nameSource = 'KK Phim';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final viewModel =
          Provider.of<HomeScreenViewModel>(context, listen: false);
      viewModel.fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const Stack(
                    children: [
                      BannerMovieWidget(),
                      LogoWidget(),
                    ],
                  ),
                  Consumer<HomeScreenViewModel>(
                    builder: (context, viewModel, child) {
                      if (viewModel.isLoading) {
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        );
                      } else {
                        return Column(
                          children: [
                            if (viewModel.singleMovie != null)
                              MovieListWidget(movie: viewModel.singleMovie!),
                            if (viewModel.seriesMovie != null)
                              MovieListWidget(movie: viewModel.seriesMovie!),
                            if (viewModel.cartoonMovie != null)
                              MovieListWidget(movie: viewModel.cartoonMovie!),
                            if (viewModel.tiviShows != null)
                              MovieListWidget(movie: viewModel.tiviShows!),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const SourceListModal(),
          ],
        ),
      ),
    );
  }
}
