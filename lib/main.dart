import 'package:fleymovieapp/view_models/home_screen_view_model.dart';
import 'package:fleymovieapp/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const FleyMovieApp());
}

class FleyMovieApp extends StatelessWidget{
  const FleyMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FleyMovie',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}