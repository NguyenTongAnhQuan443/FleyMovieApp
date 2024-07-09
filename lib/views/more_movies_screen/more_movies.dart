import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoreMoviesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoreMoviesScreenState();
  }
}

class _MoreMoviesScreenState extends State<MoreMoviesScreen> {
  final List<String> sourceMovie = <String>['KK Phim', 'KK Phim', 'KK Phim'];

  late String _dropdownValue = '';

  @override
  void initState() {
    super.initState();
    _dropdownValue = sourceMovie.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  // color: Colors.blue,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Khám phá',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                // Drop down button
              ],
            ),
          ],
        ),
      ),
    );
  }
}
