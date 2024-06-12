import 'dart:convert';

class BookmarkModel {
  bool? status;
  String? message;
  List<Data>? data;
  int? code;

  BookmarkModel({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  BookmarkModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
    int? code,
  }) =>
      BookmarkModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory BookmarkModel.fromRawJson(String str) =>
      BookmarkModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookmarkModel.fromJson(Map<String, dynamic> json) => BookmarkModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
      };
}

class Data {
  int? id;
  String? title;
  String? description;
  String? url;
  String? featuredImage;
  String? source;
  String? author;
  dynamic image;
  dynamic video;
  String? isTop;
  String? languageId;
  String? content;
  String? status;
  String? ready;
  DateTime? statusStartTime;
  DateTime? statusEndTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Data({
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
  });

  Data copyWith({
    int? id,
    String? title,
    String? description,
    String? url,
    String? featuredImage,
    String? source,
    String? author,
    dynamic image,
    dynamic video,
    String? isTop,
    String? languageId,
    String? content,
    String? status,
    String? ready,
    DateTime? statusStartTime,
    DateTime? statusEndTime,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
  }) =>
      Data(
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
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        featuredImage: json["featured_image"],
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
        statusEndTime: json["status_end_time"] == null
            ? null
            : DateTime.parse(json["status_end_time"]),
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
        "title": title,
        "description": description,
        "url": url,
        "featured_image": featuredImage,
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
        "status_end_time": statusEndTime?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}



















// class BookmarkModel {
//   bool? status;
//   String? message;
//   List<Data>? data;
//   int? code;

//   BookmarkModel({this.status, this.message, this.data, this.code});

//   BookmarkModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data ?? [].add(Data.fromJson(v));
//       });
//     }
//     code = json['code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data ?? [].map((v) => v.toJson()).toList();
//     }
//     data['code'] = code;
//     return data;
//   }
// }

// class Data {
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
//   // Change This int To String
//   String? isTop;
//   // Change This int To String
//   String? languageId;
//   String? content;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   dynamic deletedAt;

//   Data(
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
//       this.deletedAt});

//   Data.fromJson(Map<String, dynamic> json) {
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
//   }

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
//     return data;
//   }
// }
