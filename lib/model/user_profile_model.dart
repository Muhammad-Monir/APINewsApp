class ProfileModel {
  bool? status;
  String? message;
  Data? data;
  int? code;

  ProfileModel({this.status, this.message, this.data, this.code});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    return data;
  }
}

class Data {
  int? id;
  String? username;
  String? email;
  String? phone;
  String? avatar;
  String? coverPhoto;
  String? role;
  String? status;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Data(
      {this.id,
        this.username,
        this.email,
        this.phone,
        this.avatar,
        this.coverPhoto,
        this.role,
        this.status,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    coverPhoto = json['cover_photo'];
    role = json['role'];
    status = json['status'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['cover_photo'] = coverPhoto;
    data['role'] = role;
    data['status'] = status;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}