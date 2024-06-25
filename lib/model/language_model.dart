// import 'dart:convert';

// class LanguageModel {
//   bool? success;
//   List<LanguageData>? data;
//   String? message;

//   LanguageModel({
//     this.success,
//     this.data,
//     this.message,
//   });

//   LanguageModel copyWith({
//     bool? success,
//     List<LanguageData>? data,
//     String? message,
//   }) =>
//       LanguageModel(
//         success: success ?? this.success,
//         data: data ?? this.data,
//         message: message ?? this.message,
//       );

//   factory LanguageModel.fromRawJson(String str) =>
//       LanguageModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
//         success: json["success"],
//         data: json["data"] == null
//             ? []
//             : List<LanguageData>.from(
//                 json["data"]!.map((x) => LanguageData.fromJson(x))),
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "message": message,
//       };
// }

// class LanguageData {
//   int? id;
//   String? code;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   dynamic deletedAt;

//   LanguageData({
//     this.id,
//     this.code,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });

//   factory LanguageData.fromJson(Map<String, dynamic> json) => LanguageData(
//         id: json["id"],
//         code: json["code"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         deletedAt: json["deleted_at"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "code": code,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "deleted_at": deletedAt,
//       };

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     if (other is! LanguageData) return false;
//     return id == other.id && code == other.code;
//   }

//   @override
//   int get hashCode => id.hashCode ^ code.hashCode;
// }

// // class LanguageData {
// //   int? id;
// //   String? code;
// //   DateTime? createdAt;
// //   DateTime? updatedAt;
// //   dynamic deletedAt;

// //   LanguageData({
// //     this.id,
// //     this.code,
// //     this.createdAt,
// //     this.updatedAt,
// //     this.deletedAt,
// //   });

// //   LanguageData copyWith({
// //     int? id,
// //     String? code,
// //     DateTime? createdAt,
// //     DateTime? updatedAt,
// //     dynamic deletedAt,
// //   }) =>
// //       LanguageData(
// //         id: id ?? this.id,
// //         code: code ?? this.code,
// //         createdAt: createdAt ?? this.createdAt,
// //         updatedAt: updatedAt ?? this.updatedAt,
// //         deletedAt: deletedAt ?? this.deletedAt,
// //       );

// //   factory LanguageData.fromRawJson(String str) =>
// //       LanguageData.fromJson(json.decode(str));

// //   String toRawJson() => json.encode(toJson());

// //   factory LanguageData.fromJson(Map<String, dynamic> json) => LanguageData(
// //         id: json["id"],
// //         code: json["code"],
// //         createdAt: json["created_at"] == null
// //             ? null
// //             : DateTime.parse(json["created_at"]),
// //         updatedAt: json["updated_at"] == null
// //             ? null
// //             : DateTime.parse(json["updated_at"]),
// //         deletedAt: json["deleted_at"],
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "code": code,
// //         "created_at": createdAt?.toIso8601String(),
// //         "updated_at": updatedAt?.toIso8601String(),
// //         "deleted_at": deletedAt,
// //       };
// // }
import 'dart:convert';

class LanguageModel {
  bool? success;
  List<LanguageData>? data;
  String? message;

  LanguageModel({
    this.success,
    this.data,
    this.message,
  });

  LanguageModel copyWith({
    bool? success,
    List<LanguageData>? data,
    String? message,
  }) =>
      LanguageModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory LanguageModel.fromRawJson(String str) =>
      LanguageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<LanguageData>.from(
                json["data"]!.map((x) => LanguageData.fromJson(x))),
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

class LanguageData {
  int? id;
  String? name;
  String? code;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  LanguageData({
    this.id,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  LanguageData copyWith({
    int? id,
    String? name,
    String? code,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
  }) =>
      LanguageData(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory LanguageData.fromRawJson(String str) =>
      LanguageData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LanguageData.fromJson(Map<String, dynamic> json) => LanguageData(
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

  @override
  String toString() {
    return 'LanguageData(id: $id, name: $name, code: $code, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }
}
