
class Movie {
  String? status;
  String? msg;
  Data? data;

  Movie({this.status, this.msg, this.data});

  Movie.fromJson(Map<String, dynamic> json) {
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["msg"] is String) {
      msg = json["msg"];
    }
    if(json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["msg"] = msg;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  SeoOnPage? seoOnPage;
  List<BreadCrumb>? breadCrumb;
  String? titlePage;
  List<Items>? items;
  Params? params;
  String? typeList;
  String? appDomainFrontend;
  String? appDomainCdnImage;

  Data({this.seoOnPage, this.breadCrumb, this.titlePage, this.items, this.params, this.typeList, this.appDomainFrontend, this.appDomainCdnImage});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["seoOnPage"] is Map) {
      seoOnPage = json["seoOnPage"] == null ? null : SeoOnPage.fromJson(json["seoOnPage"]);
    }
    if(json["breadCrumb"] is List) {
      breadCrumb = json["breadCrumb"] == null ? null : (json["breadCrumb"] as List).map((e) => BreadCrumb.fromJson(e)).toList();
    }
    if(json["titlePage"] is String) {
      titlePage = json["titlePage"];
    }
    if(json["items"] is List) {
      items = json["items"] == null ? null : (json["items"] as List).map((e) => Items.fromJson(e)).toList();
    }
    if(json["params"] is Map) {
      params = json["params"] == null ? null : Params.fromJson(json["params"]);
    }
    if(json["type_list"] is String) {
      typeList = json["type_list"];
    }
    if(json["APP_DOMAIN_FRONTEND"] is String) {
      appDomainFrontend = json["APP_DOMAIN_FRONTEND"];
    }
    if(json["APP_DOMAIN_CDN_IMAGE"] is String) {
      appDomainCdnImage = json["APP_DOMAIN_CDN_IMAGE"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(seoOnPage != null) {
      _data["seoOnPage"] = seoOnPage?.toJson();
    }
    if(breadCrumb != null) {
      _data["breadCrumb"] = breadCrumb?.map((e) => e.toJson()).toList();
    }
    _data["titlePage"] = titlePage;
    if(items != null) {
      _data["items"] = items?.map((e) => e.toJson()).toList();
    }
    if(params != null) {
      _data["params"] = params?.toJson();
    }
    _data["type_list"] = typeList;
    _data["APP_DOMAIN_FRONTEND"] = appDomainFrontend;
    _data["APP_DOMAIN_CDN_IMAGE"] = appDomainCdnImage;
    return _data;
  }
}

class Params {
  String? typeSlug;
  List<String>? filterCategory;
  List<String>? filterCountry;
  String? filterYear;
  String? filterType;
  String? sortField;
  String? sortType;
  Pagination? pagination;

  Params({this.typeSlug, this.filterCategory, this.filterCountry, this.filterYear, this.filterType, this.sortField, this.sortType, this.pagination});

  Params.fromJson(Map<String, dynamic> json) {
    if(json["type_slug"] is String) {
      typeSlug = json["type_slug"];
    }
    if(json["filterCategory"] is List) {
      filterCategory = json["filterCategory"] == null ? null : List<String>.from(json["filterCategory"]);
    }
    if(json["filterCountry"] is List) {
      filterCountry = json["filterCountry"] == null ? null : List<String>.from(json["filterCountry"]);
    }
    if(json["filterYear"] is String) {
      filterYear = json["filterYear"];
    }
    if(json["filterType"] is String) {
      filterType = json["filterType"];
    }
    if(json["sortField"] is String) {
      sortField = json["sortField"];
    }
    if(json["sortType"] is String) {
      sortType = json["sortType"];
    }
    if(json["pagination"] is Map) {
      pagination = json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type_slug"] = typeSlug;
    if(filterCategory != null) {
      _data["filterCategory"] = filterCategory;
    }
    if(filterCountry != null) {
      _data["filterCountry"] = filterCountry;
    }
    _data["filterYear"] = filterYear;
    _data["filterType"] = filterType;
    _data["sortField"] = sortField;
    _data["sortType"] = sortType;
    if(pagination != null) {
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

  Pagination({this.totalItems, this.totalItemsPerPage, this.currentPage, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    if(json["totalItems"] is int) {
      totalItems = json["totalItems"];
    }
    if(json["totalItemsPerPage"] is int) {
      totalItemsPerPage = json["totalItemsPerPage"];
    }
    if(json["currentPage"] is int) {
      currentPage = json["currentPage"];
    }
    if(json["totalPages"] is int) {
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
  String? type;
  String? posterUrl;
  String? thumbUrl;
  bool? subDocquyen;
  bool? chieurap;
  String? time;
  String? episodeCurrent;
  String? quality;
  String? lang;
  int? year;
  List<Category>? category;
  List<Country>? country;

  Items({this.modified, this.id, this.name, this.slug, this.originName, this.type, this.posterUrl, this.thumbUrl, this.subDocquyen, this.chieurap, this.time, this.episodeCurrent, this.quality, this.lang, this.year, this.category, this.country});

  Items.fromJson(Map<String, dynamic> json) {
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
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["poster_url"] is String) {
      posterUrl = json["poster_url"];
    }
    if(json["thumb_url"] is String) {
      thumbUrl = json["thumb_url"];
    }
    if(json["sub_docquyen"] is bool) {
      subDocquyen = json["sub_docquyen"];
    }
    if(json["chieurap"] is bool) {
      chieurap = json["chieurap"];
    }
    if(json["time"] is String) {
      time = json["time"];
    }
    if(json["episode_current"] is String) {
      episodeCurrent = json["episode_current"];
    }
    if(json["quality"] is String) {
      quality = json["quality"];
    }
    if(json["lang"] is String) {
      lang = json["lang"];
    }
    if(json["year"] is int) {
      year = json["year"];
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
    if(modified != null) {
      _data["modified"] = modified?.toJson();
    }
    _data["_id"] = id;
    _data["name"] = name;
    _data["slug"] = slug;
    _data["origin_name"] = originName;
    _data["type"] = type;
    _data["poster_url"] = posterUrl;
    _data["thumb_url"] = thumbUrl;
    _data["sub_docquyen"] = subDocquyen;
    _data["chieurap"] = chieurap;
    _data["time"] = time;
    _data["episode_current"] = episodeCurrent;
    _data["quality"] = quality;
    _data["lang"] = lang;
    _data["year"] = year;
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

class BreadCrumb {
  String? name;
  String? slug;
  bool? isCurrent;
  int? position;

  BreadCrumb({this.name, this.slug, this.isCurrent, this.position});

  BreadCrumb.fromJson(Map<String, dynamic> json) {
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["slug"] is String) {
      slug = json["slug"];
    }
    if(json["isCurrent"] is bool) {
      isCurrent = json["isCurrent"];
    }
    if(json["position"] is int) {
      position = json["position"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["slug"] = slug;
    _data["isCurrent"] = isCurrent;
    _data["position"] = position;
    return _data;
  }
}

class SeoOnPage {
  String? ogType;
  String? titleHead;
  String? descriptionHead;
  List<String>? ogImage;
  String? ogUrl;

  SeoOnPage({this.ogType, this.titleHead, this.descriptionHead, this.ogImage, this.ogUrl});

  SeoOnPage.fromJson(Map<String, dynamic> json) {
    if(json["og_type"] is String) {
      ogType = json["og_type"];
    }
    if(json["titleHead"] is String) {
      titleHead = json["titleHead"];
    }
    if(json["descriptionHead"] is String) {
      descriptionHead = json["descriptionHead"];
    }
    if(json["og_image"] is List) {
      ogImage = json["og_image"] == null ? null : List<String>.from(json["og_image"]);
    }
    if(json["og_url"] is String) {
      ogUrl = json["og_url"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["og_type"] = ogType;
    _data["titleHead"] = titleHead;
    _data["descriptionHead"] = descriptionHead;
    if(ogImage != null) {
      _data["og_image"] = ogImage;
    }
    _data["og_url"] = ogUrl;
    return _data;
  }
}