import 'package:flutter/material.dart';

import 'home_screen.dart';

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
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Đang tải dữ liệu phim, Vui lòng chờ trong giây lát',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    // valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    color: Colors.blue,
                    strokeWidth: 3.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
