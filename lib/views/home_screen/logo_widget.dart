import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';
class LogoWidget extends StatelessWidget{
  const LogoWidget({super.key});



  Future<bool> checkImageUrl(String imageUrl) async {
    HttpClient client = HttpClient();
    try {
      HttpClientRequest request = await client.getUrl(Uri.parse(imageUrl));
      HttpClientResponse response = await request.close();

      // Kiểm tra nếu mã trạng thái là 200 (OK)
      if (response.statusCode == HttpStatus.ok) {
        // Đọc dữ liệu từ phản hồi để kiểm tra nếu là dữ liệu hình ảnh hợp lệ
        List<int> bytes = await consolidateHttpClientResponseBytes(response);

        // Kiểm tra nếu là hình ảnh hợp lệ (VD: JPEG, PNG, ...)
        if (_isImage(bytes)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

// Hàm kiểm tra nếu dữ liệu là hình ảnh hợp lệ
  bool _isImage(List<int> bytes) {
    // Mảng magic number (header bytes) của các định dạng hình ảnh
    Set<String> imageHeaders = {
      'ffd8ffe0', // JPEG/JFIF
      '89504e47', // PNG
      '47494638', // GIF
      '52494646'  // WebP
      // Thêm các header khác nếu cần
    };

    if (bytes.length < 4) return false;

    String header = bytes[0].toRadixString(16).padLeft(2, '0') +
        bytes[1].toRadixString(16).padLeft(2, '0') +
        bytes[2].toRadixString(16).padLeft(2, '0') +
        bytes[3].toRadixString(16).padLeft(2, '0');

    return imageHeaders.contains(header.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset('assets/images/logo64px.png'),
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
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Movie',
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  checkImageUrl("https://vietdaily.vn/wp-content/uploads/2024/02/Mai_Main-Poster_1600x2000-1.jpg");
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(50, 32),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Premium'),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.menu,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
}
