import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../view_models/home_screen_view_model.dart';

class BannerMovieWidget extends StatelessWidget{
  const BannerMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenViewModel>(
      builder: (context, viewModel, child) {
        List<String> imageBannerUrls = viewModel.getImageBannerUrls();

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            height: 500,
            child: PageView.builder(
              itemCount: imageBannerUrls.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Image.network(
                        imageBannerUrls[index],
                        height: 550,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
  
}