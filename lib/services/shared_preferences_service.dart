import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:fleymovieapp/models/watch_history.dart';

class SharedPreferencesService {
  static const String watchHistoryKey = 'watch_history';

  Future<void> saveWatchHistory(WatchHistory watchHistory) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(watchHistoryKey) ?? [];

    // Kiểm tra xem ID có tồn tại trong lịch sử hay không
    bool isDuplicate = history.any((item) {
      var existingItem = WatchHistory.fromJson(jsonDecode(item));
      return existingItem.slug == watchHistory.slug;
    });

    // Nếu không trùng lặp, thêm lịch sử mới nhất lên đầu danh sách
    if (!isDuplicate) {
      history.insert(0, jsonEncode(watchHistory.toJson()));

      // Giới hạn số lượng lịch sử là 10
      if (history.length > 10) {
        history = history.sublist(0, 10);
      }

      await prefs.setStringList(watchHistoryKey, history);
    }
  }

  Future<List<WatchHistory>> getWatchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(watchHistoryKey) ?? [];

    return history.map((item) => WatchHistory.fromJson(jsonDecode(item))).toList();
  }

  Future<void> deleteWatchHistory(String slug) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(watchHistoryKey) ?? [];

    history.removeWhere((item) {
      var existingItem = WatchHistory.fromJson(jsonDecode(item));
      return existingItem.slug == slug;
    });

    await prefs.setStringList(watchHistoryKey, history);
  }
}
