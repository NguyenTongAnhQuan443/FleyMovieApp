import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../models/watch_history.dart';
import '../../services/shared_preferences_service.dart';
import '../details_movie_screen/movie_details_screen.dart';

class WatchHistoryWidget extends StatefulWidget {
  const WatchHistoryWidget({super.key});

  @override
  State<WatchHistoryWidget> createState() => _WatchHistoryWidgetState();
}

class _WatchHistoryWidgetState extends State<WatchHistoryWidget> {
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();
  late Future<List<WatchHistory>> _watchHistoryFuture;

  @override
  void initState() {
    super.initState();
    _watchHistoryFuture = _sharedPreferencesService.getWatchHistory();
  }

  Future<void> _refreshWatchHistory() async {
    setState(() {
      _watchHistoryFuture = _sharedPreferencesService.getWatchHistory();
    });
  }

  Future<void> _confirmDelete(String slug) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Xóa lịch sử xem"),
          content:
              const Text("Bạn có muốn xóa phim này khỏi lịch sử xem không?"),
          actions: [
            TextButton(
              child: const Text("Hủy"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text("Xóa"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      await _sharedPreferencesService.deleteWatchHistory(slug);
      _refreshWatchHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Phim đang xem',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        FutureBuilder<List<WatchHistory>>(
          future: _watchHistoryFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data!.isEmpty) {
              return const SizedBox();
            } else {
              final watchHistory = snapshot.data!;
              return Container(
                margin: const EdgeInsets.only(left: 8),
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: watchHistory.length,
                  itemBuilder: (context, index) {
                    final historyItem = watchHistory[index];
                    return _buildHistoryItem(context, historyItem);
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildHistoryItem(BuildContext context, WatchHistory historyItem) {
    return Column(
      children: [
        InkWell(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            width: 120,
            height: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: historyItem.posterUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/default_poster.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          onTap: () {
            String? slugMovie = historyItem.slug;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(slugMovie),
              ),
            );
          },
          onLongPress: () {
            _confirmDelete(historyItem.slug);
          },
        ),
        Container(
          width: 110,
          height: 50,
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            historyItem.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
