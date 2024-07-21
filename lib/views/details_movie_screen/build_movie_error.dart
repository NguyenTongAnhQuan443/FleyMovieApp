import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildMovieError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/cinema.png"),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Phim này đang được cập nhập, bạn quay lại sau nhé <3',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
