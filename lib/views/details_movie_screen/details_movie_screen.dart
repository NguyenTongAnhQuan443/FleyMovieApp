import 'package:flutter/material.dart';

class DetailsMovieScreen extends StatefulWidget {
  const DetailsMovieScreen({super.key});



  @override
  State<StatefulWidget> createState() {
    return _DetailsMovieScreenState();
  }
}

class _DetailsMovieScreenState extends State<DetailsMovieScreen>{
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
                  Image.asset(
                    'assets/images/default_poster.jpg',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phi Vụ Triêu Đô',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
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
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      'Full HD - Vietsub - Hành Động - Phiêu Lưu - Gia Đình - Giả Tượng',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        padding: const EdgeInsets.only(top:10),
                        child: Row(
                          children: [
                            Expanded(
                              flex:2,
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
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Đang xem trên nguồn: KK PHIM', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 400,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
