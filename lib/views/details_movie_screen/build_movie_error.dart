import 'package:flutter/material.dart';

class BuildMovieError extends StatelessWidget {
  const BuildMovieError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/cinema.png",
            width: 200,
            height: 200,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Phim này đang được cập nhập, bạn quay lại sau nhé <3',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
