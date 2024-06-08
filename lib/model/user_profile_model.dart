import 'dart:convert';

class ProfileModel {
  bool? status;
  String? message;
  Data? data;
  int? code;

  ProfileModel({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  ProfileModel copyWith({
    bool? status,
    String? message,
    Data? data,
    int? code,
  }) =>
      ProfileModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );

  factory ProfileModel.fromRawJson(String str) =>
      ProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
  int? id;
  String? username;
  String? email;
  String? phone;
  String? avatar;
  dynamic coverPhoto;
  List<int>? categories;
  Country? language;
  Country? country;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Data({
    this.id,
    this.username,
    this.email,
    this.phone,
    this.avatar,
    this.coverPhoto,
    this.categories,
    this.language,
    this.country,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Data copyWith({
    int? id,
    String? username,
    String? email,
    String? phone,
    String? avatar,
    dynamic coverPhoto,
    List<int>? categories,
    Country? language,
    Country? country,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
  }) =>
      Data(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        avatar: avatar ?? this.avatar,
        coverPhoto: coverPhoto ?? this.coverPhoto,
        categories: categories ?? this.categories,
        language: language ?? this.language,
        country: country ?? this.country,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        avatar: json["avatar"],
        coverPhoto: json["cover_photo"],
        categories: json["categories"] == null
            ? []
            : List<int>.from(json["categories"]!.map((x) => x)),
        language: json["language"] == null
            ? null
            : Country.fromJson(json["language"]),
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
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
        "username": username,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "cover_photo": coverPhoto,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
        "language": language?.toJson(),
        "country": country?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class Country {
  int? id;
  String? name;
  String? code;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Country({
    this.id,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Country copyWith({
    int? id,
    String? name,
    String? code,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
  }) =>
      Country(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
