import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/dashboard_screen_controller.dart';
import 'dashboard_alertdialog.dart';

class DriverScreen extends GetView<DashboardScreenController> {
  static const String id = "driver";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      child: Padding(
        padding: EdgeInsets.only(top: 1.h, left: 2.w, right: 2.w),
        child: Column(
          children: [
            Container(
              height: 7.h,
              width: 100.w,
              child: TextField(
                onChanged: (value) {
                  if (controller.debounceProducts?.isActive ?? false)
                    controller.debounceProducts!.cancel();
                  controller.debounceProducts =
                      Timer(const Duration(milliseconds: 800), () {
                    controller.searchDriver(word: value);
                  });
                },
                decoration: InputDecoration(
                    hintText: "Search",
                    fillColor: Color(0xFFF0EEEE),
                    filled: true,
                    contentPadding: EdgeInsets.only(left: .5.w),
                    alignLabelWithHint: false,
                    border: InputBorder.none),
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.driverList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.driverList[index].firstname +
                                      " " +
                                      controller.driverList[index].lastname,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 2.5.sp),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          DashboardAlertDialog.showUpdateDriver(
                                              controller: controller,
                                              contact: controller
                                                  .driverList[index].contactno,
                                              firstname: controller
                                                  .driverList[index].firstname,
                                              lastname: controller
                                                  .driverList[index].lastname,
                                              username: controller
                                                  .driverList[index].username,
                                              driverID: controller
                                                  .driverList[index].driverid,
                                              password: controller
                                                  .driverList[index].password);
                                        },
                                        icon: Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          controller.deleteDriver(
                                              driverID: controller
                                                  .driverList[index].driverid);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                )
                              ],
                            ),
                            Text(
                              controller.driverList[index].contactno,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 2.sp),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            InkWell(
              onTap: () {
                DashboardAlertDialog.showAddDriver(controller: controller);
              },
              child: Container(
                height: 5.h,
                width: 100.w,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.orange),
                child: Icon(Icons.add),
              ),
            ),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }
}
