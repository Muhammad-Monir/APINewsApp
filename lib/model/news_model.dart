class NewsModel {
  bool? success;
  List<Data>? data;

  NewsModel({this.success, this.data});

  NewsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
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
  String? isTop;
  int? languageId;
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



// class NewsModel {
//   String? status;
//   int? totalResults;
//   List<Articles>? articles;
//
//   NewsModel({this.status, this.totalResults, this.articles});
//
//   NewsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     totalResults = json['totalResults'];
//     if (json['articles'] != null) {
//       articles = <Articles>[];
//       json['articles'].forEach((v) {
//         articles!.add(Articles.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['totalResults'] = totalResults;
//     if (articles != null) {
//       data['articles'] = articles!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Articles {
//   Source? source;
//   String? author;
//   String? title;
//   String? description;
//   String? url;
//   String? urlToImage;
//   String? publishedAt;
//   String? content;
//
//   Articles(
//       {this.source,
//         this.author,
//         this.title,
//         this.description,
//         this.url,
//         this.urlToImage,
//         this.publishedAt,
//         this.content});
//
//   Articles.fromJson(Map<String, dynamic> json) {
//     source =
//     json['source'] != null ? Source.fromJson(json['source']) : null;
//     author = json['author'];
//     title = json['title'];
//     description = json['description'];
//     url = json['url'];
//     urlToImage = json['urlToImage'];
//     publishedAt = json['publishedAt'];
//     content = json['content'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (source != null) {
//       data['source'] = source!.toJson();
//     }
//     data['author'] = author;
//     data['title'] = title;
//     data['description'] = description;
//     data['url'] = url;
//     data['urlToImage'] = urlToImage;
//     data['publishedAt'] = publishedAt;
//     data['content'] = content;
//     return data;
//   }
// }
//
// class Source {
//   String? id;
//   String? name;
//
//   Source({this.id, this.name});
//
//   Source.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     return data;
//   }
// }
