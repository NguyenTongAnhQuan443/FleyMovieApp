import 'package:fleymovieapp/views/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const FleyMovieApp());
}

class FleyMovieApp extends StatelessWidget{
  const FleyMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FleyMovie',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }

}