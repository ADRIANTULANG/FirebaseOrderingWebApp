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
                  hintText: "Search",
                  fillColor: Color(0xFFF0EEEE),
                  filled: true,
                  contentPadding: EdgeInsets.only(left: .5.w),
                  alignLabelWithHint: false,
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 2.w, right: 2.w),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.orange[50],
                          height: 5.h,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Order ID",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 2.5.sp),
                                ),
                              )),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Customer",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 2.5.sp),
                                ),
                              )),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Delivery Fee",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 2.5.sp),
                                ),
                              )),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Sub-total",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 2.5.sp),
                                ),
                              )),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Total",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 2.5.sp),
                                ),
                              )),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Status",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 2.5.sp),
                                ),
                              )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Expanded(
                          child: Container(
                            child: Obx(
                              () => ListView.builder(
                                itemCount: controller.orderList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: .5.h, top: .5.h),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              controller.items.assignAll(
                                                  controller.orderList[index]
                                                      .orderList);
                                              controller.order_id.value =
                                                  controller
                                                      .orderList[index].id;
                                              controller.status.value =
                                                  controller.orderList[index]
                                                      .orderStatus;
                                              controller.userToken.value =
                                                  controller.orderList[index]
                                                      .customerDetails.fcmToken;
                                              controller.delivery_fee.value =
                                                  controller.orderList[index]
                                                      .deliveryFee
                                                      .toString();
                                              controller.subtotal.value =
                                                  controller.orderList[index]
                                                      .orderSubtotal
                                                      .toString();
                                              controller.total_amount.value =
                                                  controller.orderList[index]
                                                      .orderTotal
                                                      .toString();
                                            },
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Order ID",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 2.5.sp),
                                                  ),
                                                )),
                                                Expanded(
                                                    child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    controller
                                                            .orderList[index]
                                                            .customerDetails
                                                            .firstname
                                                            .toString() +
                                                        " " +
                                                        controller
                                                            .orderList[index]
                                                            .customerDetails
                                                            .lastname
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 2.5.sp),
                                                  ),
                                                )),
                                                Expanded(
                                                    child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    " ₱ " +
                                                        controller
                                                            .orderList[index]
                                                            .deliveryFee
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 2.5.sp),
                                                  ),
                                                )),
                                                Expanded(
                                                    child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    " ₱ " +
                                                        controller
                                                            .orderList[index]
                                                            .orderSubtotal
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 2.5.sp),
                                                  ),
                                                )),
                                                Expanded(
                                                    child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    " ₱ " +
                                                        controller
                                                            .orderList[index]
                                                            .orderTotal
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 2.5.sp),
                                                  ),
                                                )),
                                                Expanded(
                                                    child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    controller.orderList[index]
                                                        .orderStatus
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 2.5.sp),
                                                  ),
                                                )),
                                              ],
                                            ),
                                          ),
                                          Divider()
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
                  child: VerticalDivider(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
                  child: Container(
                    padding: EdgeInsets.only(left: 1.w, right: 1.w, top: 1.h),
                    width: 30.w,
                    color: Colors.orange[50],
                    child: Column(
                      children: [
                        Obx(
                          () => controller.order_id.value == ""
                              ? SizedBox()
                              : Container(
                                  padding: EdgeInsets.only(
                                      left: 1.w,
                                      right: 1.w,
                                      top: 1.h,
                                      bottom: 1.h),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Items",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 2.5.sp),
                                      ),
                                      PopupMenuButton(
                                        onSelected: (value) {
                                          print(value);
                                          if (value != "Pending") {
                                            controller.updateOrder(
                                                order_id:
                                                    controller.order_id.value,
                                                status: value,
                                                userToken:
                                                    controller.userToken.value);
                                            controller.status.value = value;
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
                                                color: Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Obx(
                                              () => Text(
                                                controller.status.value,
                                                style: TextStyle(
                                                    fontSize: 2.5.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(
                                left: 1.w, right: 1.w, top: 2.h, bottom: 1.h),
                            child: Obx(
                              () => ListView.builder(
                                itemCount: controller.items.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 1.h),
                                    child: Container(
                                      height: 10.h,
                                      width: 100.w,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 10.h,
                                            width: 5.w,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        controller.items[index]
                                                            .productImage))),
                                          ),
                                          SizedBox(
                                            width: .5.w,
                                          ),
                                          Expanded(
                                              child: Container(
                                            height: 10.h,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      controller.items[index]
                                                          .productName,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 2.5.sp),
                                                    ),
                                                    Text(
                                                      controller.items[index]
                                                              .productQty
                                                              .toString() +
                                                          "pcs.",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 2.5.sp),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  " ₱ " +
                                                      controller.items[index]
                                                          .productPrice
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 2.5.sp),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Text(
                                                    " ₱ " +
                                                        (controller.items[index]
                                                                    .productPrice *
                                                                controller
                                                                    .items[
                                                                        index]
                                                                    .productQty)
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 2.5.sp),
                                                  ),
                                                ))
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Container(
                          padding:
                              EdgeInsets.only(left: 1.w, right: 1.w, top: 1.h),
                          color: Colors.white,
                          height: 10.h,
                          width: 100.w,
                          child: Obx(
                            () => controller.order_id.value == ""
                                ? SizedBox()
                                : Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Delivery Fee:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 2.5.sp),
                                          ),
                                          Obx(
                                            () => Text(
                                              " ₱ " +
                                                  controller.delivery_fee.value,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 2.5.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: .5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Sub-total:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 2.5.sp),
                                          ),
                                          Obx(
                                            () => Text(
                                              " ₱ " + controller.subtotal.value,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 2.5.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: .5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 2.5.sp),
                                          ),
                                          Obx(
                                            () => Text(
                                              " ₱ " +
                                                  controller.total_amount.value,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 2.5.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ))
          // Expanded(
          //   child: Container(
          //     child: Obx(
          //       () => ListView.builder(
          //         itemCount: controller.orderList.length,
          //         itemBuilder: (BuildContext context, int index) {
          //           return Padding(
          //             padding:
          //                 EdgeInsets.only(left: 2.w, right: 2.w, bottom: 1.h),
          //             child: Container(
          //               color: Colors.orange,
          //               padding: EdgeInsets.only(
          //                   left: .5.w, right: 1.w, top: 1.h, bottom: 1.h),
          //               child: Column(
          //                 children: [
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Text(
          //                         controller.orderList[index].id,
          //                         style: TextStyle(
          //                             fontSize: 3.sp,
          //                             fontWeight: FontWeight.bold,
          //                             color: Colors.white),
          //                       ),
          //                       Row(
          //                         children: [
          //                           PopupMenuButton(
          //                             onSelected: (value) {
          //                               print(value);
          //                               if (value != "Pending") {
          //                                 controller.updateOrder(
          //                                     order_id: controller
          //                                         .orderList[index].id,
          //                                     status: value,
          //                                     userToken: controller
          //                                         .orderList[index]
          //                                         .customerDetails
          //                                         .fcmToken);
          //                               }
          //                             },
          //                             itemBuilder: (BuildContext bc) {
          //                               return const [
          //                                 PopupMenuItem(
          //                                   child: Text("Pending"),
          //                                   value: 'Pending',
          //                                 ),
          //                                 PopupMenuItem(
          //                                   child: Text("Accepted"),
          //                                   value: 'Accepted',
          //                                 ),
          //                                 PopupMenuItem(
          //                                   child: Text("Preparing"),
          //                                   value: 'Preparing',
          //                                 ),
          //                                 PopupMenuItem(
          //                                   child: Text("Checkout"),
          //                                   value: 'Checkout',
          //                                 )
          //                               ];
          //                             },
          //                             child: Container(
          //                                 padding: EdgeInsets.only(
          //                                     top: .5.h,
          //                                     left: .5.w,
          //                                     right: .5.w,
          //                                     bottom: .5.h),
          //                                 decoration: BoxDecoration(
          //                                     color: Colors.white,
          //                                     borderRadius:
          //                                         BorderRadius.circular(5)),
          //                                 child: Text(
          //                                   controller
          //                                       .orderList[index].orderStatus,
          //                                   style: TextStyle(
          //                                       fontSize: 2.5.sp,
          //                                       fontWeight: FontWeight.bold,
          //                                       color: Colors.black),
          //                                 )),
          //                           ),
          //                           SizedBox(
          //                             width: 1.w,
          //                           ),
          //                           InkWell(
          //                               onTap: () async {
          //                                 controller.updateOrder(
          //                                     order_id: controller
          //                                         .orderList[index].id,
          //                                     status: "Cancelled",
          //                                     userToken: controller
          //                                         .orderList[index]
          //                                         .customerDetails
          //                                         .fcmToken);
          //                               },
          //                               child: Icon(Icons.cancel)),
          //                         ],
          //                       )
          //                     ],
          //                   ),
          //                   SizedBox(
          //                     height: .5.h,
          //                   ),
          //                   Row(
          //                     children: [
          //                       Text(
          //                         "Customer: ",
          //                         style: TextStyle(
          //                             fontSize: 2.5.sp,
          //                             fontWeight: FontWeight.normal,
          //                             color: Colors.black),
          //                       ),
          //                       Container(
          //                           child: Text(
          //                         controller.orderList[index].customerDetails
          //                                 .firstname +
          //                             " " +
          //                             controller.orderList[index]
          //                                 .customerDetails.lastname,
          //                         style: TextStyle(
          //                             fontSize: 2.5.sp,
          //                             fontWeight: FontWeight.normal,
          //                             color: Colors.black),
          //                       ))
          //                     ],
          //                   ),
          //                   Row(
          //                     children: [
          //                       Text(
          //                         "Contact no: ",
          //                         style: TextStyle(
          //                             fontSize: 2.5.sp,
          //                             fontWeight: FontWeight.normal,
          //                             color: Colors.black),
          //                       ),
          //                       Container(
          //                           child: Text(
          //                         controller.orderList[index].customerDetails
          //                             .contactno,
          //                         style: TextStyle(
          //                             fontSize: 2.5.sp,
          //                             fontWeight: FontWeight.normal,
          //                             color: Colors.black),
          //                       ))
          //                     ],
          //                   ),
          //                   SizedBox(
          //                     height: .5.h,
          //                   ),
          //                   Align(
          //                     alignment: Alignment.centerLeft,
          //                     child: Text(
          //                       "ITEMS",
          //                       style: TextStyle(
          //                           fontSize: 3.sp,
          //                           fontWeight: FontWeight.bold,
          //                           color: Colors.white),
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: .5.h,
          //                   ),
          //                   Container(
          //                     padding: EdgeInsets.only(
          //                         left: .5.w,
          //                         right: .5.w,
          //                         top: 1.h,
          //                         bottom: .5.h),
          //                     color: Colors.white,
          //                     child: ListView.builder(
          //                       shrinkWrap: true,
          //                       physics: NeverScrollableScrollPhysics(),
          //                       itemCount: controller
          //                           .orderList[index].orderList.length,
          //                       itemBuilder:
          //                           (BuildContext context, int orderindex) {
          //                         return Padding(
          //                           padding: EdgeInsets.only(bottom: 1.h),
          //                           child: Container(
          //                             width: 100.w,
          //                             child: Row(
          //                               crossAxisAlignment:
          //                                   CrossAxisAlignment.start,
          //                               children: [
          //                                 Container(
          //                                   height: 8.h,
          //                                   width: 5.w,
          //                                   decoration: BoxDecoration(
          //                                       image: DecorationImage(
          //                                           fit: BoxFit.cover,
          //                                           image: NetworkImage(
          //                                               controller
          //                                                   .orderList[index]
          //                                                   .orderList[
          //                                                       orderindex]
          //                                                   .productImage))),
          //                                 ),
          //                                 SizedBox(
          //                                   width: .5.w,
          //                                 ),
          //                                 Expanded(
          //                                   child: Container(
          //                                     height: 8.h,
          //                                     child: Column(
          //                                       crossAxisAlignment:
          //                                           CrossAxisAlignment.start,
          //                                       children: [
          //                                         Container(
          //                                           child: Row(
          //                                             mainAxisAlignment:
          //                                                 MainAxisAlignment
          //                                                     .spaceBetween,
          //                                             children: [
          //                                               Text(
          //                                                 controller
          //                                                     .orderList[index]
          //                                                     .orderList[
          //                                                         orderindex]
          //                                                     .productName,
          //                                                 style: TextStyle(
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .bold,
          //                                                     fontSize: 2.5.sp),
          //                                               ),
          //                                               Text(
          //                                                 "₱ " +
          //                                                     (controller
          //                                                                 .orderList[
          //                                                                     index]
          //                                                                 .orderList[
          //                                                                     orderindex]
          //                                                                 .productQty *
          //                                                             controller
          //                                                                 .orderList[
          //                                                                     index]
          //                                                                 .orderList[
          //                                                                     orderindex]
          //                                                                 .productPrice)
          //                                                         .toString(),
          //                                                 style: TextStyle(
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .bold,
          //                                                     fontSize: 2.5.sp),
          //                                               ),
          //                                             ],
          //                                           ),
          //                                         ),
          //                                         Text(
          //                                           "₱ " +
          //                                               controller
          //                                                   .orderList[index]
          //                                                   .orderList[
          //                                                       orderindex]
          //                                                   .productPrice
          //                                                   .toString(),
          //                                           style: TextStyle(
          //                                               fontWeight:
          //                                                   FontWeight.bold,
          //                                               fontSize: 2.sp),
          //                                         ),
          //                                         Expanded(child: SizedBox()),
          //                                         Text(
          //                                           controller
          //                                                   .orderList[index]
          //                                                   .orderList[
          //                                                       orderindex]
          //                                                   .productQty
          //                                                   .toString() +
          //                                               " x " +
          //                                               controller
          //                                                   .orderList[index]
          //                                                   .orderList[
          //                                                       orderindex]
          //                                                   .productPrice
          //                                                   .toString(),
          //                                           style: TextStyle(
          //                                               fontWeight:
          //                                                   FontWeight.normal,
          //                                               fontSize: 2.sp),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 )
          //                               ],
          //                             ),
          //                           ),
          //                         );
          //                       },
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 1.5.h,
          //                   ),
          //                   Container(
          //                     width: 100.w,
          //                     child: Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Text(
          //                           "Sub-total",
          //                           style: TextStyle(
          //                               fontWeight: FontWeight.bold,
          //                               fontSize: 2.5.sp),
          //                         ),
          //                         Text(
          //                           "₱ " +
          //                               controller
          //                                   .orderList[index].orderSubtotal
          //                                   .toString(),
          //                           style: TextStyle(
          //                               fontWeight: FontWeight.bold,
          //                               fontSize: 2.5.sp),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   Container(
          //                     width: 100.w,
          //                     child: Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Text(
          //                           "Delivery Fee",
          //                           style: TextStyle(
          //                               fontWeight: FontWeight.bold,
          //                               fontSize: 2.5.sp),
          //                         ),
          //                         Text(
          //                           "₱ " +
          //                               controller.orderList[index].deliveryFee
          //                                   .toString(),
          //                           style: TextStyle(
          //                               fontWeight: FontWeight.bold,
          //                               fontSize: 2.5.sp),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 1.h,
          //                   ),
          //                   Container(
          //                     width: 100.w,
          //                     child: Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Text(
          //                           "Total",
          //                           style: TextStyle(
          //                               fontWeight: FontWeight.bold,
          //                               fontSize: 3.sp),
          //                         ),
          //                         Text(
          //                           "₱ " +
          //                               controller.orderList[index].orderTotal
          //                                   .toString(),
          //                           style: TextStyle(
          //                               color: Colors.white,
          //                               fontWeight: FontWeight.bold,
          //                               fontSize: 3.sp),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
