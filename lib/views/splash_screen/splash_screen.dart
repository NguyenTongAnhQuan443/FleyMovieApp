import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/home_screen_view_model.dart';
import '../home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    await viewModel.fetchMovies();
    if (!viewModel.isLoading) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeScreenViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo64px.png',
                    width: 64,
                    height: 64,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Fley',
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Movie',
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Đang tải dữ liệu phim',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const Text(
                'Vui lòng chờ trong giây lát',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              if (viewModel.isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.lightBlue,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
