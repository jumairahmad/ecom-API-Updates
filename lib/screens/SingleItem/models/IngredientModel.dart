class CustomModel {
  String? id;
  double? price;
  String? nameofingrediantitem;

  CustomModel({this.id, this.price});
}

class IngredientModel {
  String? id;
  String? isRequiredTrue;
  String? selectionType;
  String? requiredError;
  String? maxItemSelection;
  String? maxIncludedCount;
  String? headText;
  String? image;

  List<IngredientItem>? items;
  List<int>? includedItems;

  IngredientModel(
      {this.id,
      this.isRequiredTrue,
      this.selectionType,
      this.requiredError,
      this.maxItemSelection,
      this.maxIncludedCount,
      this.headText,
      this.items,
      this.image,
      this.includedItems});

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    final items = <IngredientItem>[];
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(IngredientItem.fromJson(v));
      });
    }
    final includedItems = <int>[];
    if (json['includedItems'] != null) {
      json['includedItems'].forEach((v) {
        includedItems.add(v);
      });
    }

    final id = json['id'].toString();
    final image = json['image'];
    final isRequiredTrue = json['isRequiredTrue'];
    final selectionType = json['selectionType'];
    final requiredError = json['requiredError'];
    final maxItemSelection = json['maxItemSelection'];
    final maxIncludedCount = json['maxIncludedCount'];
    final headText = json['headText'];

    return IngredientModel(
      id: id,
      isRequiredTrue: isRequiredTrue,
      selectionType: selectionType,
      requiredError: requiredError,
      maxItemSelection: maxItemSelection,
      maxIncludedCount: maxIncludedCount,
      headText: headText,
      items: items,
      image: image,
      includedItems: includedItems,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =
        <String, dynamic>{}; //Map<String, dynamic>();
    data['id'] = id;
    data['isRequiredTrue'] = isRequiredTrue;
    data['selectionType'] = selectionType;
    data['maxItemSelection'] = maxItemSelection;
    data['maxIncludedCount'] = maxIncludedCount;
    data['headText'] = headText;
    data['image'] = image;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['includedItems'] = includedItems;
    return data;
  }
}

class IngredientItem {
  String? id;
  String? name;
  String? price;
  String? image;

  IngredientItem({this.id, this.name, this.price, this.image});

  factory IngredientItem.fromJson(Map<String, dynamic> json) {
    final id = json['id'].toString();
    final name = json['name'];
    final price = json['price'].toString();
    final image = json['image'];
    return IngredientItem(
      id: id,
      name: name,
      price: price,
      image: image,
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
      };
}
