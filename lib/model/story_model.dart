import 'dart:convert';

class StoryModel {
  bool? status;
  String? message;
  Storyboard? storyboard;
  int? code;

  StoryModel({
    this.status,
    this.message,
    this.storyboard,
    this.code,
  });

  StoryModel copyWith({
    bool? status,
    String? message,
    Storyboard? storyboard,
    int? code,
  }) =>
      StoryModel(
        status: status ?? this.status,
        message: message ?? this.message,
        storyboard: storyboard ?? this.storyboard,
        code: code ?? this.code,
      );

  factory StoryModel.fromRawJson(String str) =>
      StoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        status: json["status"],
        message: json["message"],
        storyboard: json["storyboard"] == null
            ? null
            : Storyboard.fromJson(json["storyboard"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "storyboard": storyboard?.toJson(),
        "code": code,
      };
}

class Storyboard {
  int? currentPage;
  List<StoryData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Storyboard({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Storyboard copyWith({
    int? currentPage,
    List<StoryData>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) =>
      Storyboard(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        links: links ?? this.links,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory Storyboard.fromRawJson(String str) =>
      Storyboard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Storyboard.fromJson(Map<String, dynamic> json) => Storyboard(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<StoryData>.from(
                json["data"]!.map((x) => StoryData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class StoryData {
  int? id;
  String? title;
  String? video;
  int? languageId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<Images>? images;
  Language? language;
  List<Language>? storyBoardCountries;

  StoryData({
    this.id,
    this.title,
    this.video,
    this.languageId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.images,
    this.language,
    this.storyBoardCountries,
  });

  StoryData copyWith({
    int? id,
    String? title,
    String? video,
    int? languageId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    List<Images>? images,
    Language? language,
    List<Language>? storyBoardCountries,
  }) =>
      StoryData(
        id: id ?? this.id,
        title: title ?? this.title,
        video: video ?? this.video,
        languageId: languageId ?? this.languageId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        images: images ?? this.images,
        language: language ?? this.language,
        storyBoardCountries: storyBoardCountries ?? this.storyBoardCountries,
      );

  factory StoryData.fromRawJson(String str) =>
      StoryData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoryData.fromJson(Map<String, dynamic> json) => StoryData(
        id: json["id"],
        title: json["title"],
        video: json["video"],
        languageId: json["language_id"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        images: json["images"] == null
            ? []
            : List<Images>.from(json["images"]!.map((x) => Images.fromJson(x))),
        language: json["language"] == null
            ? null
            : Language.fromJson(json["language"]),
        storyBoardCountries: json["story_board_countries"] == null
            ? []
            : List<Language>.from(json["story_board_countries"]!
                .map((x) => Language.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "video": video,
        "language_id": languageId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "language": language?.toJson(),
        "story_board_countries": storyBoardCountries == null
            ? []
            : List<dynamic>.from(storyBoardCountries!.map((x) => x.toJson())),
      };
}

class Images {
  int? id;
  int? storyBoardId;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Images({
    this.id,
    this.storyBoardId,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Images copyWith({
    int? id,
    int? storyBoardId,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
  }) =>
      Images(
        id: id ?? this.id,
        storyBoardId: storyBoardId ?? this.storyBoardId,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory Images.fromRawJson(String str) => Images.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        storyBoardId: json["story_board_id"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "story_board_id": storyBoardId,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class Language {
  int? id;
  String? name;
  String? localeName;
  String? code;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Pivot? pivot;

  Language({
    this.id,
    this.name,
    this.localeName,
    this.code,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot,
  });

  Language copyWith({
    int? id,
    String? name,
    String? localeName,
    String? code,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    Pivot? pivot,
  }) =>
      Language(
        id: id ?? this.id,
        name: name ?? this.name,
        localeName: localeName ?? this.localeName,
        code: code ?? this.code,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        pivot: pivot ?? this.pivot,
      );

  factory Language.fromRawJson(String str) =>
      Language.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        name: json["name"],
        localeName: json["locale_name"],
        code: json["code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "locale_name": localeName,
        "code": code,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  int? storyBoardId;
  int? countryId;

  Pivot({
    this.storyBoardId,
    this.countryId,
  });

  Pivot copyWith({
    int? storyBoardId,
    int? countryId,
  }) =>
      Pivot(
        storyBoardId: storyBoardId ?? this.storyBoardId,
        countryId: countryId ?? this.countryId,
      );

  factory Pivot.fromRawJson(String str) => Pivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        storyBoardId: json["story_board_id"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "story_board_id": storyBoardId,
        "country_id": countryId,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Link(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
