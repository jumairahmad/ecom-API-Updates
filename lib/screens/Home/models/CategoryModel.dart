class CategoryModel {
  String? categoryid;
  String? categoryname;
  String? image;

  CategoryModel({this.categoryid, this.categoryname, this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final categoryid = json['categoryid'];
    final categoryname = json['categoryname'];
    final image = json['image'];

    return CategoryModel(
        categoryid: categoryid, categoryname: categoryname, image: image);
  }
}
