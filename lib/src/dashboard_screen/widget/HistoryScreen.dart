import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/dashboard_screen_controller.dart';

class HistoryScreen extends GetView<DashboardScreenController> {
  static const String id = "history";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: Container(
              height: 10.h,
              width: 100.w,
              decoration: BoxDecoration(),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 2.w, right: 2.w, top: 2.h, bottom: 2.h),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Text(
                          "Pending: ",
                          style: TextStyle(
                            fontSize: 3.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(
                          () => Text(
                            controller.pending_count.value.toString(),
                            style: TextStyle(
                              fontSize: 3.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 2.w, right: 2.w, top: 2.h, bottom: 2.h),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Text(
                          "Success: ",
                          style: TextStyle(
                            fontSize: 3.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(
                          () => Text(
                            controller.success_count.value.toString(),
                            style: TextStyle(
                              fontSize: 3.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 2.w, right: 2.w, top: 2.h, bottom: 2.h),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Text(
                          "Cancelled: ",
                          style: TextStyle(
                            fontSize: 3.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(
                          () => Text(
                            controller.cancelled_count.value.toString(),
                            style: TextStyle(
                              fontSize: 3.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
            child: Container(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.orderList_History.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding:
                          EdgeInsets.only(left: 2.w, right: 2.w, bottom: 1.h),
                      child: Container(
                        color: Colors.amberAccent,
                        padding: EdgeInsets.only(
                            left: .5.w, right: 1.w, top: 1.h, bottom: 1.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.orderList_History[index].id,
                                  style: TextStyle(
                                      fontSize: 3.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Container(
                                    padding: EdgeInsets.only(
                                        top: .5.h,
                                        left: .5.w,
                                        right: .5.w,
                                        bottom: .5.h),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      controller
                                          .orderList_History[index].orderStatus,
                                      style: TextStyle(
                                          fontSize: 2.5.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: .5.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Customer: ",
                                  style: TextStyle(
                                      fontSize: 2.5.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                                Container(
                                    child: Text(
                                  controller.orderList_History[index]
                                          .customerDetails.firstname +
                                      " " +
                                      controller.orderList_History[index]
                                          .customerDetails.lastname,
                                  style: TextStyle(
                                      fontSize: 2.5.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Contact no: ",
                                  style: TextStyle(
                                      fontSize: 2.5.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                                Container(
                                    child: Text(
                                  controller.orderList_History[index]
                                      .customerDetails.contactno,
                                  style: TextStyle(
                                      fontSize: 2.5.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))
                              ],
                            ),
                            SizedBox(
                              height: .5.h,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "ITEMS",
                                style: TextStyle(
                                    fontSize: 3.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: .5.h,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: .5.w,
                                  right: .5.w,
                                  top: 1.h,
                                  bottom: .5.h),
                              color: Colors.white,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller
                                    .orderList_History[index].orderList.length,
                                itemBuilder:
                                    (BuildContext context, int orderindex) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 1.h),
                                    child: Container(
                                      width: 100.w,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 8.h,
                                            width: 5.w,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        controller
                                                            .orderList_History[
                                                                index]
                                                            .orderList[
                                                                orderindex]
                                                            .productImage))),
                                          ),
                                          SizedBox(
                                            width: .5.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 8.h,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .orderList_History[
                                                                  index]
                                                              .orderList[
                                                                  orderindex]
                                                              .productName,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 2.5.sp),
                                                        ),
                                                        Text(
                                                          "₱ " +
                                                              (controller
                                                                          .orderList_History[
                                                                              index]
                                                                          .orderList[
                                                                              orderindex]
                                                                          .productQty *
                                                                      controller
                                                                          .orderList_History[
                                                                              index]
                                                                          .orderList[
                                                                              orderindex]
                                                                          .productPrice)
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 2.5.sp),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    "₱ " +
                                                        controller
                                                            .orderList_History[
                                                                index]
                                                            .orderList[
                                                                orderindex]
                                                            .productPrice
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 2.sp),
                                                  ),
                                                  Expanded(child: SizedBox()),
                                                  Text(
                                                    controller
                                                            .orderList_History[
                                                                index]
                                                            .orderList[
                                                                orderindex]
                                                            .productQty
                                                            .toString() +
                                                        " x " +
                                                        controller
                                                            .orderList_History[
                                                                index]
                                                            .orderList[
                                                                orderindex]
                                                            .productPrice
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 2.sp),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Container(
                              width: 100.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sub-total",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 2.5.sp),
                                  ),
                                  Text(
                                    "₱ " +
                                        controller.orderList_History[index]
                                            .orderSubtotal
                                            .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 2.5.sp),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 100.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Delivery Fee",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 2.5.sp),
                                  ),
                                  Text(
                                    "₱ " +
                                        controller.orderList_History[index]
                                            .deliveryFee
                                            .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 2.5.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              width: 100.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 3.sp),
                                  ),
                                  Text(
                                    "₱ " +
                                        controller
                                            .orderList_History[index].orderTotal
                                            .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 3.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
