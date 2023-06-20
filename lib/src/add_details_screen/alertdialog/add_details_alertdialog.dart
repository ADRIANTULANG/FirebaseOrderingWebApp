import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddDetailsDialog {
  static showSuccessRegister() async {
    Get.dialog(AlertDialog(
        content: Container(
      height: 5.h,
      width: 15.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Successfully Registered!",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 2.5.sp,
                color: Colors.amber[900]),
          ),
        ],
      ),
    )));
  }
}
