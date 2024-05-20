import 'dart:convert';

class NewsModel {
  bool? success;
  Data? data;

  NewsModel({
    this.success,
    this.data,
  });

  NewsModel copyWith({
    bool? success,
    Data? data,
  }) =>
      NewsModel(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory NewsModel.fromRawJson(String str) =>
      NewsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
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
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  int? id;
  String? title;
  String? description;
  String? url;
  String? featuredImage;
  String? source;
  String? author;
  String? categoryId;
  String? countryId;
  dynamic image;
  dynamic video;
  String? isTop;
  String? languageId;
  String? content;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  bool? isBookmarked;

  Datum({
    this.id,
    this.title,
    this.description,
    this.url,
    this.featuredImage,
    this.source,
    this.author,
    this.categoryId,
    this.countryId,
    this.image,
    this.video,
    this.isTop,
    this.languageId,
    this.content,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isBookmarked,
  });

  Datum copyWith({
    int? id,
    String? title,
    String? description,
    String? url,
    String? featuredImage,
    String? source,
    String? author,
    String? categoryId,
    String? countryId,
    dynamic image,
    dynamic video,
    String? isTop,
    String? languageId,
    String? content,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    bool? isBookmarked,
  }) =>
      Datum(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        featuredImage: featuredImage ?? this.featuredImage,
        source: source ?? this.source,
        author: author ?? this.author,
        categoryId: categoryId ?? this.categoryId,
        countryId: countryId ?? this.countryId,
        image: image ?? this.image,
        video: video ?? this.video,
        isTop: isTop ?? this.isTop,
        languageId: languageId ?? this.languageId,
        content: content ?? this.content,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        isBookmarked: isBookmarked ?? this.isBookmarked,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        featuredImage: json["featured_image"],
        source: json["source"],
        author: json["author"],
        categoryId: json["category_id"],
        countryId: json["country_id"],
        image: json["image"],
        video: json["video"],
        isTop: json["is_top"],
        languageId: json["language_id"],
        content: json["content"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        isBookmarked: json["isBookmarked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "url": url,
        "featured_image": featuredImage,
        "source": source,
        "author": author,
        "category_id": categoryId,
        "country_id": countryId,
        "image": image,
        "video": video,
        "is_top": isTop,
        "language_id": languageId,
        "content": content,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "isBookmarked": isBookmarked,
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







// class NewsModel {
//   bool? success;
//   AllNewses? data;

//   NewsModel({
//     this.success,
//     this.data,
//   });

//   NewsModel copyWith({
//     bool? success,
//     AllNewses? data,
//   }) =>
//       NewsModel(
//         success: success ?? this.success,
//         data: data ?? this.data,
//       );

//   factory NewsModel.fromRawJson(String str) => NewsModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
//     success: json["success"],
//     data: json["data"] == null ? null : AllNewses.fromJson(json["data"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "data": data?.toJson(),
//   };
// }

// class AllNewses {
//   int? currentPage;
//   List<Datum>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<Link>? links;
//   dynamic nextPageUrl;
//   String? path;
//   int? perPage;
//   dynamic prevPageUrl;
//   int? to;
//   int? total;

//   AllNewses({
//     this.currentPage,
//     this.data,
//     this.firstPageUrl,
//     this.from,
//     this.lastPage,
//     this.lastPageUrl,
//     this.links,
//     this.nextPageUrl,
//     this.path,
//     this.perPage,
//     this.prevPageUrl,
//     this.to,
//     this.total,
//   });

//   AllNewses copyWith({
//     int? currentPage,
//     List<Datum>? data,
//     String? firstPageUrl,
//     int? from,
//     int? lastPage,
//     String? lastPageUrl,
//     List<Link>? links,
//     dynamic nextPageUrl,
//     String? path,
//     int? perPage,
//     dynamic prevPageUrl,
//     int? to,
//     int? total,
//   }) =>
//       AllNewses(
//         currentPage: currentPage ?? this.currentPage,
//         data: data ?? this.data,
//         firstPageUrl: firstPageUrl ?? this.firstPageUrl,
//         from: from ?? this.from,
//         lastPage: lastPage ?? this.lastPage,
//         lastPageUrl: lastPageUrl ?? this.lastPageUrl,
//         links: links ?? this.links,
//         nextPageUrl: nextPageUrl ?? this.nextPageUrl,
//         path: path ?? this.path,
//         perPage: perPage ?? this.perPage,
//         prevPageUrl: prevPageUrl ?? this.prevPageUrl,
//         to: to ?? this.to,
//         total: total ?? this.total,
//       );

//   factory AllNewses.fromRawJson(String str) => AllNewses.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory AllNewses.fromJson(Map<String, dynamic> json) => AllNewses(
//     currentPage: json["current_page"],
//     data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//     firstPageUrl: json["first_page_url"],
//     from: json["from"],
//     lastPage: json["last_page"],
//     lastPageUrl: json["last_page_url"],
//     links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
//     nextPageUrl: json["next_page_url"],
//     path: json["path"],
//     perPage: json["per_page"],
//     prevPageUrl: json["prev_page_url"],
//     to: json["to"],
//     total: json["total"],
//   );

//   Map<String, dynamic> toJson() => {
//     "current_page": currentPage,
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//     "first_page_url": firstPageUrl,
//     "from": from,
//     "last_page": lastPage,
//     "last_page_url": lastPageUrl,
//     "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
//     "next_page_url": nextPageUrl,
//     "path": path,
//     "per_page": perPage,
//     "prev_page_url": prevPageUrl,
//     "to": to,
//     "total": total,
//   };
// }

// class Datum {
//   int? id;
//   String? title;
//   String? description;
//   String? url;
//   String? featuredImage;
//   String? source;
//   String? author;
//   String? category;
//   dynamic image;
//   dynamic video;
//   String? isTop;
//   String? languageId;
//   String? content;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   dynamic deletedAt;
//   bool? isBookmarked;

//   Datum({
//     this.id,
//     this.title,
//     this.description,
//     this.url,
//     this.featuredImage,
//     this.source,
//     this.author,
//     this.category,
//     this.image,
//     this.video,
//     this.isTop,
//     this.languageId,
//     this.content,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.isBookmarked,
//   });

//   Datum copyWith({
//     int? id,
//     String? title,
//     String? description,
//     String? url,
//     String? featuredImage,
//     String? source,
//     String? author,
//     String? category,
//     dynamic image,
//     dynamic video,
//     String? isTop,
//     String? languageId,
//     String? content,
//     String? status,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     dynamic deletedAt,
//     bool? isBookmarked,
//   }) =>
//       Datum(
//         id: id ?? this.id,
//         title: title ?? this.title,
//         description: description ?? this.description,
//         url: url ?? this.url,
//         featuredImage: featuredImage ?? this.featuredImage,
//         source: source ?? this.source,
//         author: author ?? this.author,
//         category: category ?? this.category,
//         image: image ?? this.image,
//         video: video ?? this.video,
//         isTop: isTop ?? this.isTop,
//         languageId: languageId ?? this.languageId,
//         content: content ?? this.content,
//         status: status ?? this.status,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         deletedAt: deletedAt ?? this.deletedAt,
//         isBookmarked: isBookmarked ?? this.isBookmarked,
//       );

//   factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     title: json["title"],
//     description: json["description"],
//     url: json["url"],
//     featuredImage: json["featured_image"],
//     source: json["source"],
//     author: json["author"],
//     category: json["category"],
//     image: json["image"],
//     video: json["video"],
//     isTop: json["is_top"],
//     languageId: json["language_id"],
//     content: json["content"],
//     status: json["status"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//     isBookmarked: json["isBookmarked"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "description": description,
//     "url": url,
//     "featured_image": featuredImage,
//     "source": source,
//     "author": author,
//     "category": category,
//     "image": image,
//     "video": video,
//     "is_top": isTop,
//     "language_id": languageId,
//     "content": content,
//     "status": status,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//     "isBookmarked": isBookmarked,
//   };
// }

// class Link {
//   String? url;
//   String? label;
//   bool? active;

//   Link({
//     this.url,
//     this.label,
//     this.active,
//   });

//   Link copyWith({
//     String? url,
//     String? label,
//     bool? active,
//   }) =>
//       Link(
//         url: url ?? this.url,
//         label: label ?? this.label,
//         active: active ?? this.active,
//       );

//   factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//     url: json["url"],
//     label: json["label"],
//     active: json["active"],
//   );

//   Map<String, dynamic> toJson() => {
//     "url": url,
//     "label": label,
//     "active": active,
//   };
// }

















// class NewsModel {
//   bool? success;
//   List<NewesData>? data;
//
//   NewsModel({this.success, this.data});
//
//   NewsModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       data = <NewesData>[];
//       json['data'].forEach((v) {
//         data!.add(NewesData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['success'] = success;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class NewesData {
//   int? id;
//   String? title;
//   String? description;
//   String? url;
//   String? featuredImage;
//   String? source;
//   String? author;
//   String? category;
//   dynamic image;
//   dynamic video;
//   int? isTop;
//   int? languageId;
//   String? content;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   dynamic deletedAt;
//   bool? isBookmarked;
//
//   NewesData(
//       {this.id,
//       this.title,
//       this.description,
//       this.url,
//       this.featuredImage,
//       this.source,
//       this.author,
//       this.category,
//       this.image,
//       this.video,
//       this.isTop,
//       this.languageId,
//       this.content,
//       this.status,
//       this.createdAt,
//       this.updatedAt,
//       this.deletedAt,
//       this.isBookmarked});
//
//   NewesData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     description = json['description'];
//     url = json['url'];
//     featuredImage = json['featured_image'];
//     source = json['source'];
//     author = json['author'];
//     category = json['category'];
//     image = json['image'];
//     video = json['video'];
//     isTop = json['is_top'];
//     languageId = json['language_id'];
//     content = json['content'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//     isBookmarked = json['isBookmarked'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['description'] = description;
//     data['url'] = url;
//     data['featured_image'] = featuredImage;
//     data['source'] = source;
//     data['author'] = author;
//     data['category'] = category;
//     data['image'] = image;
//     data['video'] = video;
//     data['is_top'] = isTop;
//     data['language_id'] = languageId;
//     data['content'] = content;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['deleted_at'] = deletedAt;
//     data['isBookmarked'] = isBookmarked;
//     return data;
//   }
// }
//
//
//
// // class NewsModel {
// //   String? status;
// //   int? totalResults;
// //   List<Articles>? articles;
// //
// //   NewsModel({this.status, this.totalResults, this.articles});
// //
// //   NewsModel.fromJson(Map<String, dynamic> json) {
// //     status = json['status'];
// //     totalResults = json['totalResults'];
// //     if (json['articles'] != null) {
// //       articles = <Articles>[];
// //       json['articles'].forEach((v) {
// //         articles!.add(Articles.fromJson(v));
// //       });
// //     }
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     data['status'] = status;
// //     data['totalResults'] = totalResults;
// //     if (articles != null) {
// //       data['articles'] = articles!.map((v) => v.toJson()).toList();
// //     }
// //     return data;
// //   }
// // }
// //
// // class Articles {
// //   Source? source;
// //   String? author;
// //   String? title;
// //   String? description;
// //   String? url;
// //   String? urlToImage;
// //   String? publishedAt;
// //   String? content;
// //
// //   Articles(
// //       {this.source,
// //         this.author,
// //         this.title,
// //         this.description,
// //         this.url,
// //         this.urlToImage,
// //         this.publishedAt,
// //         this.content});
// //
// //   Articles.fromJson(Map<String, dynamic> json) {
// //     source =
// //     json['source'] != null ? Source.fromJson(json['source']) : null;
// //     author = json['author'];
// //     title = json['title'];
// //     description = json['description'];
// //     url = json['url'];
// //     urlToImage = json['urlToImage'];
// //     publishedAt = json['publishedAt'];
// //     content = json['content'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     if (source != null) {
// //       data['source'] = source!.toJson();
// //     }
// //     data['author'] = author;
// //     data['title'] = title;
// //     data['description'] = description;
// //     data['url'] = url;
// //     data['urlToImage'] = urlToImage;
// //     data['publishedAt'] = publishedAt;
// //     data['content'] = content;
// //     return data;
// //   }
// // }
// //
// // class Source {
// //   String? id;
// //   String? name;
// //
// //   Source({this.id, this.name});
// //
// //   Source.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     name = json['name'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     data['id'] = id;
// //     data['name'] = name;
// //     return data;
// //   }
// // }
