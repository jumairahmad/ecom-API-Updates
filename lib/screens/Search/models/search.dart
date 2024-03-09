// ignore_for_file: prefer_collection_literals

class Search {
  String itemName;
  String size;
  String image;
  double price;

  Search(this.image, this.itemName, this.size, this.price);
}

class ItemModel {
  String? id;
  String? upc;
  String? name;
  String? regularprice;
  String? onspecial;
  String? specialprice;
  String? specialexpires;
  String? specialstarts;
  String? specialtype;
  String? specialID;
  String? contents;
  String? size;
  String? image;

  ItemModel(
      {this.id,
      this.upc,
      this.name,
      this.regularprice,
      this.onspecial,
      this.specialprice,
      this.specialexpires,
      this.specialstarts,
      this.specialtype,
      this.specialID,
      this.contents,
      this.size,
      this.image});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    upc = json['upc'];
    name = json['name'];
    regularprice = json['regularprice'];
    onspecial = json['onspecial'];
    specialprice = json['specialprice'];
    specialexpires = json['specialexpires'];
    specialstarts = json['specialstarts'];
    specialtype = json['specialtype'];
    specialID = json['specialID'];
    contents = json['contents'];
    size = json['size'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['upc'] = upc;
    data['name'] = name;
    data['regularprice'] = regularprice;
    data['onspecial'] = onspecial;
    data['specialprice'] = specialprice;
    data['specialexpires'] = specialexpires;
    data['specialstarts'] = specialstarts;
    data['specialtype'] = specialtype;
    data['specialID'] = specialID;
    data['contents'] = contents;
    data['size'] = size;
    data['image'] = image;
    return data;
  }
}
