import 'package:flutter/material.dart';

class BuildFunctionSearch extends StatelessWidget {
  const BuildFunctionSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search_outlined,
            color: Colors.white.withOpacity(0.5),
          ),
          hintText: 'Nhập tên phim cần tìm ...',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.3),
        ),
      ),
    );
  }
}
