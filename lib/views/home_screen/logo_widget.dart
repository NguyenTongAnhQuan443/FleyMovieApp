import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          _buildPremiumButton(context),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return const Row(
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: Image(
            image: AssetImage('assets/images/logo64px.png'),
          ),
        ),
        SizedBox(width: 10),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Fley',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Movie',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showBottomSheet(context),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(50, 32),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text('Premium'),
    );
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const _BottomSheetContent(),
      );
    },
  );
}

class _BottomSheetContent extends StatelessWidget {
  const _BottomSheetContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Phiên bản Premium',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Nhập mã kích hoạt...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Xác nhận mã',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Phương thức khác, vui lòng liên hệ nhà cung cấp',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = _launchURL,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL() async {
    final Uri link = Uri.parse('https://www.facebook.com/groups/472852058871106');
    if (await canLaunchUrl(link)) {
      await launchUrl(link, mode: LaunchMode.externalApplication);
    } else {
      throw 'Lỗi Link Premium $link';
    }
  }
}
