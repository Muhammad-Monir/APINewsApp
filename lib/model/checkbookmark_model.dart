import 'dart:convert';

class CheckBookmarkModel {
  bool? status;
  String? message;
  CheckData? data;
  int? code;

  CheckBookmarkModel({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  CheckBookmarkModel copyWith({
    bool? status,
    String? message,
    CheckData? data,
    int? code,
  }) =>
      CheckBookmarkModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory CheckBookmarkModel.fromRawJson(String str) =>
      CheckBookmarkModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckBookmarkModel.fromJson(Map<String, dynamic> json) =>
      CheckBookmarkModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : CheckData.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class CheckData {
  int? id;
  String? userId;
  String? newsId;
  DateTime? createdAt;
  DateTime? updatedAt;

  CheckData({
    this.id,
    this.userId,
    this.newsId,
    this.createdAt,
    this.updatedAt,
  });

  CheckData copyWith({
    int? id,
    String? userId,
    String? newsId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CheckData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        newsId: newsId ?? this.newsId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CheckData.fromRawJson(String str) =>
      CheckData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckData.fromJson(Map<String, dynamic> json) => CheckData(
        id: json["id"],
        userId: json["user_id"],
        newsId: json["news_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "news_id": newsId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
