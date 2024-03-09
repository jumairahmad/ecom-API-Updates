// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:e_commerce/screens/OrderView/models/orderlist_model.dart';

class OrderView_model {
  String address;
  String cardimage;
  String card_name;
  String card_number;
  List<OrderList_model> orders;
  double subtotal_price;
  double delivery_price;
  double total_price;

  OrderView_model(
      this.address,
      this.cardimage,
      this.card_name,
      this.card_number,
      this.orders,
      this.subtotal_price,
      this.delivery_price,
      this.total_price);
}
