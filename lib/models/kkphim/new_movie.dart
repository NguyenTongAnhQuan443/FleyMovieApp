class NewMovie {
  bool? status;
  List<Items>? items;
  Pagination? pagination;

  NewMovie({this.status, this.items, this.pagination});

  NewMovie.fromJson(Map<String, dynamic> json) {
    if (json["status"] is bool) {
      status = json["status"];
    }
    if (json["items"] is List) {
      items = json["items"] == null
          ? null
          : (json["items"] as List).map((e) => Items.fromJson(e)).toList();
    }
    if (json["pagination"] is Map) {
      pagination = json["pagination"] == null
          ? null
          : Pagination.fromJson(json["pagination"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    if (items != null) {
      _data["items"] = items?.map((e) => e.toJson()).toList();
    }
    if (pagination != null) {
      _data["pagination"] = pagination?.toJson();
    }
    return _data;
  }
}

class Pagination {
  int? totalItems;
  int? totalItemsPerPage;
  int? currentPage;
  int? totalPages;

  Pagination(
      {this.totalItems,
      this.totalItemsPerPage,
      this.currentPage,
      this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    if (json["totalItems"] is int) {
      totalItems = json["totalItems"];
    }
    if (json["totalItemsPerPage"] is int) {
      totalItemsPerPage = json["totalItemsPerPage"];
    }
    if (json["currentPage"] is int) {
      currentPage = json["currentPage"];
    }
    if (json["totalPages"] is int) {
      totalPages = json["totalPages"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["totalItems"] = totalItems;
    _data["totalItemsPerPage"] = totalItemsPerPage;
    _data["currentPage"] = currentPage;
    _data["totalPages"] = totalPages;
    return _data;
  }
}

class Items {
  Modified? modified;
  String? id;
  String? name;
  String? slug;
  String? originName;
  String? posterUrl;
  String? thumbUrl;
  int? year;

  Items(
      {this.modified,
      this.id,
      this.name,
      this.slug,
      this.originName,
      this.posterUrl,
      this.thumbUrl,
      this.year});

  Items.fromJson(Map<String, dynamic> json) {
    if (json["modified"] is Map) {
      modified =
          json["modified"] == null ? null : Modified.fromJson(json["modified"]);
    }
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["slug"] is String) {
      slug = json["slug"];
    }
    if (json["origin_name"] is String) {
      originName = json["origin_name"];
    }
    if (json["poster_url"] is String) {
      posterUrl = json["poster_url"];
    }
    if (json["thumb_url"] is String) {
      thumbUrl = json["thumb_url"];
    }
    if (json["year"] is int) {
      year = json["year"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (modified != null) {
      _data["modified"] = modified?.toJson();
    }
    _data["_id"] = id;
    _data["name"] = name;
    _data["slug"] = slug;
    _data["origin_name"] = originName;
    _data["poster_url"] = posterUrl;
    _data["thumb_url"] = thumbUrl;
    _data["year"] = year;
    return _data;
  }
}

class Modified {
  String? time;

  Modified({this.time});

  Modified.fromJson(Map<String, dynamic> json) {
    if (json["time"] is String) {
      time = json["time"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["time"] = time;
    return _data;
  }
}
