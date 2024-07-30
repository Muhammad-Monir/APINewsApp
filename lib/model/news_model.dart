// ignore_for_file: constant_identifier_names

import 'dart:convert';

import '../utils/api_url.dart';

class NewsModel {
  bool? status;
  String? message;
  Data? data;
  int? code;

  NewsModel({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  NewsModel copyWith({
    bool? status,
    String? message,
    Data? data,
    int? code,
  }) =>
      NewsModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory NewsModel.fromRawJson(String str) =>
      NewsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class Data {
  int? currentPage;
  List<Datum>? data;
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

  Data({
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

  Data copyWith({
    int? currentPage,
    List<Datum>? data,
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
      Data(
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

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
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
            : List<dynamic>.from(data ?? [].map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links ?? [].map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  int? id;
  String? title;
  String? description;
  String? url;
  List<String>? featuredImage;
  String? source;
  dynamic author;
  dynamic image;
  dynamic video;
  String? isTop;
  int? languageId;
  String? content;
  String? status;
  String? ready;
  DateTime? statusStartTime;
  dynamic statusEndTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  bool? isBookmarked;
  String? formatedDate;
  List<Category>? categories;
  List<Country>? countries;
  List<dynamic>? images;

  Datum({
    this.id,
    this.title,
    this.description,
    this.url,
    this.featuredImage,
    this.source,
    this.author,
    this.image,
    this.video,
    this.isTop,
    this.languageId,
    this.content,
    this.status,
    this.ready,
    this.statusStartTime,
    this.statusEndTime,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isBookmarked,
    this.formatedDate,
    this.categories,
    this.countries,
    this.images,
  });

  Datum copyWith({
    int? id,
    String? title,
    String? description,
    String? url,
    List<String>? featuredImage,
    String? source,
    dynamic author,
    dynamic image,
    dynamic video,
    String? isTop,
    int? languageId,
    String? content,
    String? status,
    String? ready,
    DateTime? statusStartTime,
    dynamic statusEndTime,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    bool? isBookmarked,
    String? formatedDate,
    List<Category>? categories,
    List<Country>? countries,
    List<dynamic>? images,
  }) =>
      Datum(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        featuredImage: featuredImage ?? this.featuredImage,
        source: source ?? this.source,
        author: author ?? this.author,
        image: image ?? this.image,
        video: video ?? this.video,
        isTop: isTop ?? this.isTop,
        languageId: languageId ?? this.languageId,
        content: content ?? this.content,
        status: status ?? this.status,
        ready: ready ?? this.ready,
        statusStartTime: statusStartTime ?? this.statusStartTime,
        statusEndTime: statusEndTime ?? this.statusEndTime,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        isBookmarked: isBookmarked ?? this.isBookmarked,
        formatedDate: formatedDate ?? this.formatedDate,
        categories: categories ?? this.categories,
        countries: countries ?? this.countries,
        images: images ?? this.images,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        featuredImage: json["featured_image"] == null
            ? [ApiUrl.imageNotFound]
            : List<String>.from(json["featured_image"].map((x) => x)),
        source: json["source"],
        author: json["author"],
        image: json["image"],
        video: json["video"],
        isTop: json["is_top"],
        languageId: json["language_id"],
        content: json["content"],
        status: json["status"],
        ready: json["ready"],
        statusStartTime: json["status_start_time"] == null
            ? null
            : DateTime.parse(json["status_start_time"]),
        statusEndTime: json["status_end_time"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        isBookmarked: json["isBookmarked"],
        formatedDate: json["formated_date"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        countries: json["countries"] == null
            ? []
            : List<Country>.from(
                json["countries"].map((x) => Country.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<dynamic>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "url": url,
        "featured_image": featuredImage == null
            ? [ApiUrl.imageNotFound]
            : List<dynamic>.from(
                featuredImage ?? [ApiUrl.imageNotFound].map((x) => x)),
        "source": source,
        "author": author,
        "image": image,
        "video": video,
        "is_top": isTop,
        "language_id": languageId,
        "content": content,
        "status": status,
        "ready": ready,
        "status_start_time": statusStartTime?.toIso8601String(),
        "status_end_time": statusEndTime,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "isBookmarked": isBookmarked,
        "formated_date": formatedDate,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories ?? [].map((x) => x.toJson())),
        "countries": countries == null
            ? []
            : List<dynamic>.from(countries ?? [].map((x) => x.toJson())),
        "images": images == null
            ? []
            : List<dynamic>.from(images ?? [].map((x) => x)),
      };
}

class Category {
  int? id;
  String? title;
  String? slug;
  String? image;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  CategoryPivot? pivot;

  Category({
    this.id,
    this.title,
    this.slug,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot,
  });

  Category copyWith({
    int? id,
    String? title,
    String? slug,
    String? image,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    CategoryPivot? pivot,
  }) =>
      Category(
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        image: image ?? this.image,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        pivot: pivot ?? this.pivot,
      );

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        pivot: json["pivot"] == null
            ? null
            : CategoryPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "pivot": pivot?.toJson(),
      };
}

class CategoryPivot {
  int? newsId;
  int? categoryId;

  CategoryPivot({
    this.newsId,
    this.categoryId,
  });

  CategoryPivot copyWith({
    int? newsId,
    int? categoryId,
  }) =>
      CategoryPivot(
        newsId: newsId ?? this.newsId,
        categoryId: categoryId ?? this.categoryId,
      );

  factory CategoryPivot.fromRawJson(String str) =>
      CategoryPivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryPivot.fromJson(Map<String, dynamic> json) => CategoryPivot(
        newsId: json["news_id"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "news_id": newsId,
        "category_id": categoryId,
      };
}

class Country {
  int? id;
  String? name;
  String? code;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  CountryPivot? pivot;

  Country({
    this.id,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot,
  });

  Country copyWith({
    int? id,
    String? name,
    String? code,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    CountryPivot? pivot,
  }) =>
      Country(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        pivot: pivot ?? this.pivot,
      );

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        pivot:
            json["pivot"] == null ? null : CountryPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "pivot": pivot?.toJson(),
      };
}

class CountryPivot {
  int? newsId;
  int? countryId;

  CountryPivot({
    this.newsId,
    this.countryId,
  });

  CountryPivot copyWith({
    int? newsId,
    int? countryId,
  }) =>
      CountryPivot(
        newsId: newsId ?? this.newsId,
        countryId: countryId ?? this.countryId,
      );

  factory CountryPivot.fromRawJson(String str) =>
      CountryPivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryPivot.fromJson(Map<String, dynamic> json) => CountryPivot(
        newsId: json["news_id"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "news_id": newsId,
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
