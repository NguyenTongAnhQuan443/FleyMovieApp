import 'package:fleymovieapp/view_models/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Consumer<UserViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.user == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var user = viewModel.user!;
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Xin chào. Chúc bạn một ngày tốt lành!',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Image.asset('assets/images/logo64px.png'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Phiên bản: ',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                      Text(
                        'PREMIUM',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    ],
                  ),
                  // const Text(
                  //   'Đã thanh toán',
                  //   style: TextStyle(color: Colors.white, fontSize: 14),
                  // ),
                  const Divider(color: Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16.0, top: 10, bottom: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    'Người dùng:',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16.0, top: 10, bottom: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    'Hạn sử dụng:',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    user.name ?? 'Cập nhập thông tin',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    user.expiry ?? 'Vĩnh viễn',
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white),
                  Expanded(
                    child: ListView(
                      children: [
                        InkWell(
                          child: const ListTile(
                            leading: Icon(Icons.backup, color: Colors.white),
                            title: Text('Sao lưu dữ liệu',
                                style: TextStyle(color: Colors.white)),
                          ),
                          onTap: () {
                            showAlertDialog(context, 'Thông báo',
                                'Chức năng đang được phát triển, vui lòng quay lại sau');
                          },
                        ),
                        InkWell(
                          child: const ListTile(
                            leading:
                                Icon(Icons.cloud_download, color: Colors.white),
                            title: Text('Khôi phục dữ liệu từ',
                                style: TextStyle(color: Colors.white)),
                          ),
                          onTap: () {
                            showAlertDialog(context, 'Thông báo',
                                'Chức năng đang được phát triển, vui lòng quay lại sau');
                          },
                        ),
                        InkWell(
                          child: const ListTile(
                            leading:
                                Icon(Icons.assignment, color: Colors.white),
                            title: Text('Trách nhiệm và bản quyền',
                                style: TextStyle(color: Colors.white)),
                          ),
                          onTap: () {
                            showAlertDialog(
                                context,
                                'Disclaimer',
                                'Any legal issues regarding the content on this '
                                    'application should be taken up with the actual '
                                    'file hosts and providers themselves as we are not '
                                    'affiliated with them. In case of copyright '
                                    'infringement, please directly contact the '
                                    'responsible parties or the streaming websites. '
                                    'The app is purely for educational and personal use. '
                                    'FleyMovie does not host any content on the app, and has '
                                    'no control over what media is put up or taken down. '
                                    'FleyMovie functions like any other search engine, '
                                    'such as Google. FleyMovie does not host, upload or'
                                    ' manage any videos, films or content. It simply crawls, '
                                    'aggregates and displayes links in a convenient, '
                                    'user-friendly interface. It merely scrapes 3rd-party '
                                    'websites that are publicly accessable via any '
                                    'regular web browser. It is the responsibility of'
                                    'user to avoid any actions that might violate the laws '
                                    'governing his/her locality. Use FleyMovie at your own '
                                    'risk.\nSpecial thanks !');
                          },
                        ),
                        InkWell(
                          child: const ListTile(
                            leading: Icon(Icons.share, color: Colors.white),
                            title: Text('Chia sẻ ứng dụng',
                                style: TextStyle(color: Colors.white)),
                          ),
                          onTap: () {
                            showAlertDialog(context, 'Thông báo',
                                'Chức năng đang được phát triển, vui lòng quay lại sau');
                          },
                        ),
                        InkWell(
                          child: const ListTile(
                            leading: Icon(Icons.star, color: Colors.white),
                            title: Text('Đánh giá ứng dụng trên CH Play',
                                style: TextStyle(color: Colors.white)),
                          ),
                          onTap: () {
                            showAlertDialog(context, 'Thông báo',
                                'Chức năng đang được phát triển, vui lòng quay lại sau');
                          },
                        ),
                        InkWell(
                          child: const ListTile(
                            leading: Icon(Icons.settings, color: Colors.white),
                            title: Text('Cài đặt nâng cao',
                                style: TextStyle(color: Colors.white)),
                          ),
                          onTap: () {
                            showAlertDialog(context, 'Thông báo',
                                'Chức năng đang được phát triển, vui lòng quay lại sau');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

// Show Alert
void showAlertDialog(BuildContext context, String title, String content) {
  Widget cancelButton = TextButton(
    child: const Text(
      "OK",
      style: TextStyle(color: Colors.white),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // Tạo AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.black,
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    content: SizedBox(
      height: content.length < 100 ? 40 : 500,
      child: ListView(
        children: [
          Text(
            content,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
    actions: [
      cancelButton,
    ],
  );

  // Hiển thị AlertDialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
