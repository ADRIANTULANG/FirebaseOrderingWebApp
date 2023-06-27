// To parse this JSON data, do
//
//     final driverModel = driverModelFromJson(jsonString);

import 'dart:convert';

List<DriverModel> driverModelFromJson(String str) => List<DriverModel>.from(
    json.decode(str).map((x) => DriverModel.fromJson(x)));

String driverModelToJson(List<DriverModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DriverModel {
  String driverid;
  String firstname;
  String lastname;
  String contactno;
  String username;
  String password;

  DriverModel({
    required this.driverid,
    required this.firstname,
    required this.lastname,
    required this.contactno,
    required this.username,
    required this.password,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
        driverid: json["driverid"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        contactno: json["contactno"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "driverid": driverid,
        "firstname": firstname,
        "lastname": lastname,
        "contactno": contactno,
        "username": username,
        "password": password,
      };
}
