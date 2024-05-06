class BookmarkModel {
  bool? status;
  String? message;
  List<Data>? data;
  int? code;

  BookmarkModel({this.status, this.message, this.data, this.code});

  BookmarkModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? description;
  String? url;
  String? featuredImage;
  String? source;
  String? author;
  String? category;
  dynamic image;
  dynamic video;
  // Change This int To String
  String? isTop;
  // Change This int To String
  String? languageId;
  String? content;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Data(
      {this.id,
      this.title,
      this.description,
      this.url,
      this.featuredImage,
      this.source,
      this.author,
      this.category,
      this.image,
      this.video,
      this.isTop,
      this.languageId,
      this.content,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    featuredImage = json['featured_image'];
    source = json['source'];
    author = json['author'];
    category = json['category'];
    image = json['image'];
    video = json['video'];
    isTop = json['is_top'];
    languageId = json['language_id'];
    content = json['content'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['featured_image'] = featuredImage;
    data['source'] = source;
    data['author'] = author;
    data['category'] = category;
    data['image'] = image;
    data['video'] = video;
    data['is_top'] = isTop;
    data['language_id'] = languageId;
    data['content'] = content;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
