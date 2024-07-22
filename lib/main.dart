import 'package:fleymovieapp/view_models/find_movies_view_model.dart';
import 'package:fleymovieapp/view_models/home_screen_view_model.dart';
import 'package:fleymovieapp/view_models/more_movies_view_model.dart';
import 'package:fleymovieapp/view_models/new_movie_view_model.dart';
import 'package:fleymovieapp/view_models/slug_provider.dart';
import 'package:fleymovieapp/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() async {
  runApp(const FleyMovieApp());
}

class FleyMovieApp extends StatelessWidget {
  const FleyMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenViewModel()),
        ChangeNotifierProvider(create: (context) => MoreMoviesViewModel()),
        ChangeNotifierProvider(create: (context) => NewMovieViewModel()),
        ChangeNotifierProvider(create: (context) => SlugProvider()),
        ChangeNotifierProvider(create: (context) => FindMoviesViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FleyMovie',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        // home: Home(),
      ),
    );
  }
}
