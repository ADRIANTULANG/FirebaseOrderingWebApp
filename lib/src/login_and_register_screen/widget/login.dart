import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/login_and_register_screen_controller.dart';

class LoginView extends GetView<LoginAndRegistrationScreenController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 38.w, right: 38.w),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE0E0E0), width: 1),
              borderRadius: BorderRadius.circular(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                child: Text(
                  "Email",
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 2.5.sp),
                ),
              ),
              SizedBox(
                height: .5.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                height: 7.h,
                width: 100.w,
                child: TextField(
                  onChanged: (value) {},
                  onEditingComplete: () {
                    controller.login(
                        username: controller.username.text,
                        password: controller.password.text);
                  },
                  controller: controller.username,
                  decoration: InputDecoration(
                      fillColor: Color(0xFFF0EEEE),
                      filled: true,
                      contentPadding: EdgeInsets.only(left: .5.w),
                      alignLabelWithHint: false,
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                child: Text(
                  "Password",
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 2.5.sp),
                ),
              ),
              SizedBox(
                height: .5.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                height: 7.h,
                width: 100.w,
                child: TextField(
                  onChanged: (value) {},
                  onEditingComplete: () {
                    controller.login(
                        username: controller.username.text,
                        password: controller.password.text);
                  },
                  obscureText: true,
                  controller: controller.password,
                  decoration: InputDecoration(
                      fillColor: Color(0xFFF0EEEE),
                      filled: true,
                      contentPadding: EdgeInsets.only(left: .5.w),
                      alignLabelWithHint: false,
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                child: InkWell(
                  onTap: () {
                    controller.login(
                        username: controller.username.text,
                        password: controller.password.text);
                  },
                  child: Container(
                    height: 5.h,
                    width: 100.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.amber[900],
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 3.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                child: Container(
                  height: 5.h,
                  width: 100.w,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not yet registered? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 2.2.sp),
                      ),
                      Text(
                        "Create a free account.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 2.2.sp),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
