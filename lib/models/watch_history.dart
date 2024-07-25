class WatchHistory {
  final String movieUrl;
  final String slug;
  final int episode;
  final String posterUrl;
  final String name;

  WatchHistory({
    required this.movieUrl,
    required this.slug,
    required this.episode,
    required this.posterUrl,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
    'movieUrl': movieUrl,
    'slug': slug,
    'episode': episode,
    'posterUrl': posterUrl,
    'name' : name,
  };

  factory WatchHistory.fromJson(Map<String, dynamic> json) {
    return WatchHistory(
      movieUrl: json['movieUrl'],
      slug: json['slug'],
      episode: json['episode'],
      posterUrl: json['posterUrl'],
      name: json['name'],
    );
  }
}
