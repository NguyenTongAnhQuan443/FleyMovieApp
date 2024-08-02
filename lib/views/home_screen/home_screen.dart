import 'package:fleymovieapp/view_models/slug_provider.dart';
import 'package:fleymovieapp/views/details_movie_screen/movie_details_screen.dart';
import 'package:fleymovieapp/views/home_screen/banner_movie_widget.dart';
import 'package:fleymovieapp/views/home_screen/movie_list_widget.dart';
import 'package:fleymovieapp/views/home_screen/logo_widget.dart';
import 'package:fleymovieapp/views/home_screen/source_list_modal.dart';
import 'package:fleymovieapp/views/home_screen/watch_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:fleymovieapp/view_models/home_screen_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  Stack(
                    children: [
                      const BannerMovieWidget(),
                      const LogoWidget(),
                      _buildButtonWatchAMovie(context),
                    ],
                  ),
                  Consumer<HomeScreenViewModel>(
                    builder: (context, viewModel, child) {
                      if (viewModel.isLoading) {
                        return const SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
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
                  const WatchHistoryWidget(),
                ],
              ),
            ),
            const SourceListModal(),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.grey,
      title: const Text("Thông báo"),
      content: const SizedBox(
        width: 200,
        height: 30,
        child: Text("Vui lòng đợi trong giây lát"),
      ),
      actions: [cancelButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _buildButtonWatchAMovie(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: MediaQuery.of(context).size.width / 2 - 100,
      child: ElevatedButton(
        onPressed: () {
          String slug = Provider.of<SlugProvider>(context, listen: false).slug;
          if (slug.isEmpty) {
            _showAlertDialog(context);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(slug),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          minimumSize: const Size(200, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.play_arrow),
            Text('Xem phim'),
          ],
        ),
      ),
    );
  }
}
