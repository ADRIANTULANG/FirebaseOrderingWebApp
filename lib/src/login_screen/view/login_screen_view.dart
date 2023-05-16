import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controller/login_screen_controller.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  static const String id = "login";

  @override
  Widget build(BuildContext context) {
    Get.put(LoginScreenController());
    return RawKeyboardListener(
      autofocus: false,
      focusNode: FocusNode(),
      onKey: (event) {},
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: 100.h,
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 7.h,
                width: 100.w,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(left: 1.w, top: 1.h),
                        height: 7.h,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset("assets/images/logo.png"),
                            SizedBox(
                              width: .5.w,
                            ),
                            Text(
                              "Food3ip ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 3.sp,
                                  fontFamily: "Pacifico",
                                  color: Colors.orangeAccent),
                            ),
                          ],
                        ),
                      )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: Text(
                              "Pricing",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 2.5.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: Text(
                              "Real Results",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 2.5.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          VerticalDivider(
                            indent: 1.h,
                            color: Color(0xFFE0E0E0),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: Container(
                              height: 4.h,
                              width: 5.w,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(25)),
                              alignment: Alignment.center,
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 2.sp,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: .5.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: Container(
                              height: 4.h,
                              width: 5.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.orange, width: 3),
                                  borderRadius: BorderRadius.circular(25)),
                              alignment: Alignment.center,
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 2.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                        ],
                      ),
                    ]),
              ),
              Divider(color: Color(0xFFE0E0E0)),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Start your ",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 3.sp,
                    ),
                  ),
                  Text(
                    "Food3ip ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 3.sp,
                        color: Colors.orangeAccent),
                  ),
                  Text(
                    "with us.",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 3.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
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
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 2.5.sp),
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
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 2.5.sp),
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
                                    fontWeight: FontWeight.w400,
                                    fontSize: 2.2.sp),
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
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 2.2.sp,
                      color: Colors.orange),
                ),
              )),
              Container(
                height: 20.h,
                width: 100.w,
                color: Colors.orange[50],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "CONTACT US",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 3.sp,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: .5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email_rounded,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: .5.w,
                        ),
                        Text("adriantulang@gmail.com"),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      "CONNECT WITH US",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 3.sp,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: .5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.launchInBrowserFacebook();
                          },
                          child: Icon(
                            Icons.facebook_rounded,
                            color: Colors.lightBlue,
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        InkWell(
                          onTap: () async {
                            controller.launchInBrowserWeChat();
                          },
                          child: Icon(
                            Icons.wechat_sharp,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        InkWell(
                          onTap: () {
                            controller.launchInBrowserDiscord();
                          },
                          child: Icon(
                            Icons.discord_outlined,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
