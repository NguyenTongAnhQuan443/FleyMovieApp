import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
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
                onPressed: () {},
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
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Icon(
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
