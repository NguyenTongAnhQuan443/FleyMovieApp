
class MovieInformationAndMovieList {
  bool? status;
  String? msg;
  Movie? movie;
  List<Episodes>? episodes;

  MovieInformationAndMovieList({this.status, this.msg, this.movie, this.episodes});

  MovieInformationAndMovieList.fromJson(Map<String, dynamic> json) {
    if(json["status"] is bool) {
      status = json["status"];
    }
    if(json["msg"] is String) {
      msg = json["msg"];
    }
    if(json["movie"] is Map) {
      movie = json["movie"] == null ? null : Movie.fromJson(json["movie"]);
    }
    if(json["episodes"] is List) {
      episodes = json["episodes"] == null ? null : (json["episodes"] as List).map((e) => Episodes.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["msg"] = msg;
    if(movie != null) {
      _data["movie"] = movie?.toJson();
    }
    if(episodes != null) {
      _data["episodes"] = episodes?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Episodes {
  String? serverName;
  List<ServerData>? serverData;

  Episodes({this.serverName, this.serverData});

  Episodes.fromJson(Map<String, dynamic> json) {
    if(json["server_name"] is String) {
      serverName = json["server_name"];
    }
    if(json["server_data"] is List) {
      serverData = json["server_data"] == null ? null : (json["server_data"] as List).map((e) => ServerData.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["server_name"] = serverName;
    if(serverData != null) {
      _data["server_data"] = serverData?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class ServerData {
  String? name;
  String? slug;
  String? filename;
  String? linkEmbed;
  String? linkM3U8;

  ServerData({this.name, this.slug, this.filename, this.linkEmbed, this.linkM3U8});

  ServerData.fromJson(Map<String, dynamic> json) {
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["slug"] is String) {
      slug = json["slug"];
    }
    if(json["filename"] is String) {
      filename = json["filename"];
    }
    if(json["link_embed"] is String) {
      linkEmbed = json["link_embed"];
    }
    if(json["link_m3u8"] is String) {
      linkM3U8 = json["link_m3u8"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["slug"] = slug;
    _data["filename"] = filename;
    _data["link_embed"] = linkEmbed;
    _data["link_m3u8"] = linkM3U8;
    return _data;
  }
}

class Movie {
  Created? created;
  Modified? modified;
  String? id;
  String? name;
  String? slug;
  String? originName;
  String? content;
  String? type;
  String? status;
  String? posterUrl;
  String? thumbUrl;
  bool? isCopyright;
  bool? subDocquyen;
  bool? chieurap;
  String? trailerUrl;
  String? time;
  String? episodeCurrent;
  String? episodeTotal;
  String? quality;
  String? lang;
  String? notify;
  String? showtimes;
  int? year;
  int? view;
  List<String>? actor;
  List<String>? director;
  List<Category>? category;
  List<Country>? country;

  Movie({this.created, this.modified, this.id, this.name, this.slug, this.originName, this.content, this.type, this.status, this.posterUrl, this.thumbUrl, this.isCopyright, this.subDocquyen, this.chieurap, this.trailerUrl, this.time, this.episodeCurrent, this.episodeTotal, this.quality, this.lang, this.notify, this.showtimes, this.year, this.view, this.actor, this.director, this.category, this.country});

  Movie.fromJson(Map<String, dynamic> json) {
    if(json["created"] is Map) {
      created = json["created"] == null ? null : Created.fromJson(json["created"]);
    }
    if(json["modified"] is Map) {
      modified = json["modified"] == null ? null : Modified.fromJson(json["modified"]);
    }
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["slug"] is String) {
      slug = json["slug"];
    }
    if(json["origin_name"] is String) {
      originName = json["origin_name"];
    }
    if(json["content"] is String) {
      content = json["content"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["poster_url"] is String) {
      posterUrl = json["poster_url"];
    }
    if(json["thumb_url"] is String) {
      thumbUrl = json["thumb_url"];
    }
    if(json["is_copyright"] is bool) {
      isCopyright = json["is_copyright"];
    }
    if(json["sub_docquyen"] is bool) {
      subDocquyen = json["sub_docquyen"];
    }
    if(json["chieurap"] is bool) {
      chieurap = json["chieurap"];
    }
    if(json["trailer_url"] is String) {
      trailerUrl = json["trailer_url"];
    }
    if(json["time"] is String) {
      time = json["time"];
    }
    if(json["episode_current"] is String) {
      episodeCurrent = json["episode_current"];
    }
    if(json["episode_total"] is String) {
      episodeTotal = json["episode_total"];
    }
    if(json["quality"] is String) {
      quality = json["quality"];
    }
    if(json["lang"] is String) {
      lang = json["lang"];
    }
    if(json["notify"] is String) {
      notify = json["notify"];
    }
    if(json["showtimes"] is String) {
      showtimes = json["showtimes"];
    }
    if(json["year"] is int) {
      year = json["year"];
    }
    if(json["view"] is int) {
      view = json["view"];
    }
    if(json["actor"] is List) {
      actor = json["actor"] == null ? null : List<String>.from(json["actor"]);
    }
    if(json["director"] is List) {
      director = json["director"] == null ? null : List<String>.from(json["director"]);
    }
    if(json["category"] is List) {
      category = json["category"] == null ? null : (json["category"] as List).map((e) => Category.fromJson(e)).toList();
    }
    if(json["country"] is List) {
      country = json["country"] == null ? null : (json["country"] as List).map((e) => Country.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(created != null) {
      _data["created"] = created?.toJson();
    }
    if(modified != null) {
      _data["modified"] = modified?.toJson();
    }
    _data["_id"] = id;
    _data["name"] = name;
    _data["slug"] = slug;
    _data["origin_name"] = originName;
    _data["content"] = content;
    _data["type"] = type;
    _data["status"] = status;
    _data["poster_url"] = posterUrl;
    _data["thumb_url"] = thumbUrl;
    _data["is_copyright"] = isCopyright;
    _data["sub_docquyen"] = subDocquyen;
    _data["chieurap"] = chieurap;
    _data["trailer_url"] = trailerUrl;
    _data["time"] = time;
    _data["episode_current"] = episodeCurrent;
    _data["episode_total"] = episodeTotal;
    _data["quality"] = quality;
    _data["lang"] = lang;
    _data["notify"] = notify;
    _data["showtimes"] = showtimes;
    _data["year"] = year;
    _data["view"] = view;
    if(actor != null) {
      _data["actor"] = actor;
    }
    if(director != null) {
      _data["director"] = director;
    }
    if(category != null) {
      _data["category"] = category?.map((e) => e.toJson()).toList();
    }
    if(country != null) {
      _data["country"] = country?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Country {
  String? id;
  String? name;
  String? slug;

  Country({this.id, this.name, this.slug});

  Country.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["slug"] is String) {
      slug = json["slug"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["slug"] = slug;
    return _data;
  }
}

class Category {
  String? id;
  String? name;
  String? slug;

  Category({this.id, this.name, this.slug});

  Category.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["slug"] is String) {
      slug = json["slug"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["slug"] = slug;
    return _data;
  }
}

class Modified {
  String? time;

  Modified({this.time});

  Modified.fromJson(Map<String, dynamic> json) {
    if(json["time"] is String) {
      time = json["time"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["time"] = time;
    return _data;
  }
}

class Created {
  String? time;

  Created({this.time});

  Created.fromJson(Map<String, dynamic> json) {
    if(json["time"] is String) {
      time = json["time"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["time"] = time;
    return _data;
  }
}