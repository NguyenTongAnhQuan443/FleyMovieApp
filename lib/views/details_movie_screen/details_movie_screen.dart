import 'package:flutter/material.dart';

class DetailsMovieScreen extends StatefulWidget {
  const DetailsMovieScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DetailsMovieScreenState();
  }
}

class _DetailsMovieScreenState extends State<DetailsMovieScreen> {
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
                  // Đè tên phim - thể loại lên poster
                  Stack(
                    children: [
                      buildPoster(),
                      Positioned(
                        bottom: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTitleMovie(),
                            buildCategoryMovie(),
                          ],
                        ),
                      ),
                    ],
                  ),

                  buildWatchAMovie(),

                  buildSourceMovie(),
                ],
              ),
            ),
            onTapArraw(),
          ],
        ),
      ),
    );
  }

  // OnTap Button Arrow
  Widget onTapArraw() {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
    );
  }

  // Widget Build Poster
  Widget buildPoster() {
    return InkWell(
      child: Image.network(
        'https://kenh14cdn.com/2020/8/1/mv5bzdcxogi0mdytntc5ns00nduzlwfkotitndixzji0otllntljxkeyxkfqcgdeqxvymtmxodk2otuv1-1592454662484458613488-15962494366901991849797.jpg',
        width: double.infinity,
        height: 300,
        fit: BoxFit.cover,
      ),
      onTap: () {
        print('object');
      },
    );
  }

  // Widget Title Movie
  Widget buildTitleMovie() {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10),
      child: const Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Phi Vụ Triêu Đô',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              Text(
                'Phi Vụ Triêu Đô',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget Category Movie
  Widget buildCategoryMovie() {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: const Text(
        'Full HD - Vietsub - Hành Động - Phiêu Lưu - Gia Đình - Giả Tượng',
        style: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  // Widget Watch a Movie
  Widget buildWatchAMovie() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                fixedSize: const Size(200, 50),
              ),
              child: const Text(
                'XEM PHIM',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.download,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget Source Movie
  Widget buildSourceMovie() {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Đang xem trên nguồn: KK PHIM',
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
