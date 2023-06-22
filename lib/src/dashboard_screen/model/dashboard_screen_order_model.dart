// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  String id;
  CustomerDetails customerDetails;
  double deliveryFee;
  String orderStatus;
  String orderStoreId;
  double orderSubtotal;
  double orderTotal;
  String customer_id;
  List<OrderList> orderList;

  OrderModel({
    required this.id,
    required this.customerDetails,
    required this.deliveryFee,
    required this.orderStatus,
    required this.orderStoreId,
    required this.orderSubtotal,
    required this.orderTotal,
    required this.customer_id,
    required this.orderList,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        customerDetails: CustomerDetails.fromJson(json["customer_details"]),
        deliveryFee: json["delivery_fee"],
        orderStatus: json["order_status"],
        orderStoreId: json["order_store_id"],
        orderSubtotal: json["order_subtotal"],
        orderTotal: json["order_total"],
        customer_id: json["customer_id"],
        orderList: List<OrderList>.from(
            json["order_list"].map((x) => OrderList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_details": customerDetails.toJson(),
        "delivery_fee": deliveryFee,
        "order_status": orderStatus,
        "order_store_id": orderStoreId,
        "order_subtotal": orderSubtotal,
        "customer_id": customer_id,
        "order_total": orderTotal,
        "order_list": List<dynamic>.from(orderList.map((x) => x.toJson())),
      };
}

class CustomerDetails {
  String firstname;
  bool isNormalAccount;
  String contactno;
  String lastname;
  String address;
  String username;
  String password;
  String fcmToken;

  CustomerDetails({
    required this.firstname,
    required this.isNormalAccount,
    required this.contactno,
    required this.lastname,
    required this.address,
    required this.username,
    required this.password,
    required this.fcmToken,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      CustomerDetails(
        firstname: json["firstname"],
        isNormalAccount: json["isNormalAccount"],
        contactno: json["contactno"],
        lastname: json["lastname"],
        address: json["address"],
        username: json["username"],
        password: json["password"],
        fcmToken: json["fcmToken"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "isNormalAccount": isNormalAccount,
        "contactno": contactno,
        "lastname": lastname,
        "address": address,
        "username": username,
        "password": password,
        "fcmToken": fcmToken,
      };
}

class OrderList {
  String orderId;
  String productId;
  String productImage;
  String productName;
  double productPrice;
  double productQty;

  OrderList({
    required this.orderId,
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productQty,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        orderId: json["order_id"],
        productId: json["product_id"],
        productImage: json["product_image"],
        productName: json["product_name"],
        productPrice: json["product_price"],
        productQty: json["product_qty"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "product_id": productId,
        "product_image": productImage,
        "product_name": productName,
        "product_price": productPrice,
        "product_qty": productQty,
      };
}
