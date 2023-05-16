import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/dashboard_screen_controller.dart';

class OrderScreen extends GetView<DashboardScreenController> {
  static const String id = "orders";
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
          Container(
            padding: EdgeInsets.only(left: 2.w, right: 2.w),
            height: 7.h,
            width: 100.w,
            child: TextField(
              decoration: InputDecoration(
                  fillColor: Colors.amber[100],
                  filled: true,
                  contentPadding: EdgeInsets.only(left: .5.w),
                  alignLabelWithHint: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  hintText: 'Search'),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
            child: Container(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.orderList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding:
                          EdgeInsets.only(left: 2.w, right: 2.w, bottom: 1.h),
                      child: Container(
                        color: Colors.orange,
                        padding: EdgeInsets.only(
                            left: .5.w, right: 1.w, top: 1.h, bottom: 1.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.orderList[index].id,
                                  style: TextStyle(
                                      fontSize: 3.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    PopupMenuButton(
                                      onSelected: (value) {
                                        print(value);
                                        if (value != "Pending") {
                                          controller.updateOrder(
                                              order_id: controller
                                                  .orderList[index].id,
                                              status: value,
                                              userToken: controller
                                                  .orderList[index]
                                                  .customerDetails
                                                  .fcmToken);
                                        }
                                      },
                                      itemBuilder: (BuildContext bc) {
                                        return const [
                                          PopupMenuItem(
                                            child: Text("Pending"),
                                            value: 'Pending',
                                          ),
                                          PopupMenuItem(
                                            child: Text("Accepted"),
                                            value: 'Accepted',
                                          ),
                                          PopupMenuItem(
                                            child: Text("Preparing"),
                                            value: 'Preparing',
                                          ),
                                          PopupMenuItem(
                                            child: Text("Checkout"),
                                            value: 'Checkout',
                                          )
                                        ];
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: .5.h,
                                              left: .5.w,
                                              right: .5.w,
                                              bottom: .5.h),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            controller
                                                .orderList[index].orderStatus,
                                            style: TextStyle(
                                                fontSize: 2.5.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          controller.updateOrder(
                                              order_id: controller
                                                  .orderList[index].id,
                                              status: "Cancelled",
                                              userToken: controller
                                                  .orderList[index]
                                                  .customerDetails
                                                  .fcmToken);
                                        },
                                        child: Icon(Icons.cancel)),
                                  ],
                                )
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
                                  controller.orderList[index].customerDetails
                                          .firstname +
                                      " " +
                                      controller.orderList[index]
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
                                  controller.orderList[index].customerDetails
                                      .contactno,
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
                                    .orderList[index].orderList.length,
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
                                                            .orderList[index]
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
                                                              .orderList[index]
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
                                                                          .orderList[
                                                                              index]
                                                                          .orderList[
                                                                              orderindex]
                                                                          .productQty *
                                                                      controller
                                                                          .orderList[
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
                                                            .orderList[index]
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
                                                            .orderList[index]
                                                            .orderList[
                                                                orderindex]
                                                            .productQty
                                                            .toString() +
                                                        " x " +
                                                        controller
                                                            .orderList[index]
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
                                        controller
                                            .orderList[index].orderSubtotal
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
                                        controller.orderList[index].deliveryFee
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
                                        controller.orderList[index].orderTotal
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
