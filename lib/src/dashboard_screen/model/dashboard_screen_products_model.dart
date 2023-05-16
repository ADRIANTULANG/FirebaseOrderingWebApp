// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

List<ProductsModel> productsModelFromJson(String str) =>
    List<ProductsModel>.from(
        json.decode(str).map((x) => ProductsModel.fromJson(x)));

String productsModelToJson(List<ProductsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsModel {
  String productId;
  String productImage;
  String productName;
  double productPrice;

  ProductsModel({
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.productPrice,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        productId: json["product_id"],
        productImage: json["product_image"],
        productName: json["product_name"],
        productPrice: json["product_price"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_image": productImage,
        "product_name": productName,
        "product_price": productPrice,
      };
}
