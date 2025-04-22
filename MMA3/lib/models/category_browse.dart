class CategoryBrowse {
  int? id;
  int? categoryId;
  String? title;
  String? video;
  String? content;
  String? image;
  CategoryData? categoryData;

  CategoryBrowse(
      {this.id,
      this.categoryId,
      this.title,
      this.video,
      this.content,
      this.image,
      this.categoryData});

  CategoryBrowse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    video = json['video'];
    content = json['content'];
    image = json['image'];
    categoryData = json['category_data'] != null
        ? new CategoryData.fromJson(json['category_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['video'] = this.video;
    data['content'] = this.content;
    data['image'] = this.image;
    if (this.categoryData != null) {
      data['category_data'] = this.categoryData!.toJson();
    }
    return data;
  }
}

class CategoryData {
  int? id;
  String? categoryName;

  CategoryData({this.id, this.categoryName});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    return data;
  }
}
