import 'dart:convert';

class CountryModel {
  bool? success;
  List<CountryData>? data;
  String? message;

  CountryModel({
    this.success,
    this.data,
    this.message,
  });

  CountryModel copyWith({
    bool? success,
    List<CountryData>? data,
    String? message,
  }) =>
      CountryModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory CountryModel.fromRawJson(String str) =>
      CountryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<CountryData>.from(
                json["data"]!.map((x) => CountryData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class CountryData {
  int? id;
  String? name;
  String? code;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  CountryData({
    this.id,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  CountryData copyWith({
    int? id,
    String? name,
    String? code,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
  }) =>
      CountryData(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory CountryData.fromRawJson(String str) =>
      CountryData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
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
