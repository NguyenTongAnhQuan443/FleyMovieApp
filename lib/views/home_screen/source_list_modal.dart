import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/home_screen_view_model.dart';

class SourceListModal extends StatelessWidget {
  const SourceListModal({super.key});

  void _showSourceList(
      BuildContext context, ValueNotifier<String> nameSourceNotifier) {
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    List<String> sourceMovie = viewModel.getSourceMovie();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black87,
          height: 400,
          child: ListView.builder(
            itemCount: sourceMovie.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  sourceMovie[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  if (index == 0) {
                    nameSourceNotifier.value = viewModel.sourceMovie[index];
                  } else {
                    final snackBar = SnackBar(
                      content: const Text(
                        'Nguồn phim đang được cập nhập !\nChúc bạn xem phim vui vẻ',
                      ),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(label: 'OK', onPressed: () {}),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    final nameSourceNotifier =
        ValueNotifier<String>(viewModel.getSourceMovie()[0]);

    return Positioned(
      right: 10,
      bottom: 16,
      child: ValueListenableBuilder<String>(
        valueListenable: nameSourceNotifier,
        builder: (context, nameSource, child) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              _showSourceList(context, nameSourceNotifier);
            },
            child: Row(
              children: [
                const Icon(Icons.shuffle),
                const SizedBox(width: 10),
                Text(
                  nameSource,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
