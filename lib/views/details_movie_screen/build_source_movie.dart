import 'package:flutter/material.dart';

class BuildSourceMovie extends StatelessWidget {
  const BuildSourceMovie({super.key});

  @override
  Widget build(BuildContext context) {
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
}
