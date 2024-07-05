import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
    final List<int> items = List<int>.generate(40, (index) => index);
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

                  buildDetailsMovie(),

                  buildEpisode(items),
                ],
              ),
            ),
            onTapArrow(),
          ],
        ),
      ),
    );
  }

  // OnTap Button Arrow
  Widget onTapArrow() {
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
      onTap: () {},
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
                'Phi Vụ Triệu Đô (Mùa 1)',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              Text(
                'Phi Vụ Triệu Đô (Mùa 1)',
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
            'Đang xem trên: KK PHIM',
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ],
      ),
    );
  }

// Widget Episode
  Widget buildEpisode(List<int> items) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, top: 20),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Full HD - Danh sách tập',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          child: GridView.builder(
            shrinkWrap: true,
            // cho phép gridView điều chỉnh theo nội dung
            physics: const NeverScrollableScrollPhysics(),
            // không cho phép gridView cuộn
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Số lượng phần tử trên 1 hàng
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.4),
            // chiều rộng gắp 2.5 lần chiều cao
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '${items[index]}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget Details Movie
  Widget buildDetailsMovie() {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Nội dung phim',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          const Text(
            'Phi Vụ Triệu Đô (Phần 1) là một tác phẩm trộm cướp'
            ' đột phá và cuốn hút đến từ đất nước Tây Ban '
            'Nha, La Casa De Papel kể về một nhóm những tội'
            ' phạm tập hợp lại cho một phi vụ lịch sử: đột '
            'nhập Royal Mint of Spain – sở đúc tiền hoàng '
            'gia của Tây Ban Nha và tiến hành trộm hàng tỷ'
            ' euro. Không dừng lại ở việc lấy tiền rồi chạy'
            ' trốn, kế hoạch của gang trộm này còn bao '
            'gồm… in thêm tiền, bắt giữ con tin kéo dài '
            'đến hàng chục ngày được thiết kế tỉ mẩn và '
            'cực kỳ thông minh bởi nhân vật trùm cuối mang'
            ' tên Profesor (Giáo Sư). Cùng lúc đó, băng tội '
            'phạm sẽ phải cân não với lực lượng cảnh sát, '
            'thám tử cũng đang cố gắng giải vây cho nhóm '
            'con tin bị bắt giữ',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: const Text(
              'Đạo diễn: esús Colmenar',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Text(
              'Diễn viên: Úrsula Corberó, Itziar Ituño,'
              ' Álvaro Morte, Pedro Alonso, Alba Flores, '
              'Miguel Herrán, Jaime Lorente, Esther Acebo, '
              'Enrique Arce',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
