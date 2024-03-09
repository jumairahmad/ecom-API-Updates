// ignore_for_file: non_constant_identifier_names, camel_case_types

class OrderList_model {
  String image_name;
  String item_name;
  String? size;
  double single_item_price;
  int quantity;
  double totalprice;

  OrderList_model(this.image_name, this.item_name, this.size,
      this.single_item_price, this.quantity, this.totalprice);
}
