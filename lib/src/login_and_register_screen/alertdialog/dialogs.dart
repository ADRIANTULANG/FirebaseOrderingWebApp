import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Dialogs {
  static showMessage() async {
    Get.dialog(AlertDialog(
        content: Container(
      height: 20.h,
      width: 30.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Message",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 5.sp,
                color: Colors.amber[900]),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Text(
            "We sent a verification link to your email",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 3.sp),
          ),
        ],
      ),
    )));
  }

  static showErrorMessage({required String error}) async {
    Get.dialog(AlertDialog(
        content: Container(
      height: 20.h,
      width: 30.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Message",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 5.sp,
                color: Colors.amber[900]),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 3.sp),
          ),
        ],
      ),
    )));
  }
}
