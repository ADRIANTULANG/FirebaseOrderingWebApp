import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
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
              onChanged: (value) {
                if (controller.debounceProducts?.isActive ?? false)
                  controller.debounceProducts!.cancel();
                controller.debounceProducts =
                    Timer(const Duration(milliseconds: 800), () {
                  controller.searchOrder(word: value);
                  if (value == "") {
                    FocusScope.of(context).unfocus();
                  }
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
                              Expanded(
                                  child: Container(
                                alignment: Alignment.center,
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
                                              controller.orderList[index]
                                                  .hasMessage.value = false;
                                              controller.selected_customer_id
                                                      .value =
                                                  controller.orderList[index]
                                                      .customer_id;
                                              controller.showChat(
                                                  orderID: controller
                                                      .orderList[index].id);
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
                                                    controller
                                                        .orderList[index].id
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
                                                Expanded(
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Obx(
                                                          () => Icon(
                                                            Icons
                                                                .message_rounded,
                                                            color: controller
                                                                        .orderList[
                                                                            index]
                                                                        .hasMessage
                                                                        .value ==
                                                                    true
                                                                ? Colors.orange
                                                                : Colors.black,
                                                          ),
                                                        ))),
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
                        Container(
                          height: 3.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.isOrderList_or_ChatList.value =
                                      true;
                                },
                                child: Icon(
                                  Icons.list,
                                  size: 4.sp,
                                ),
                              ),
                              SizedBox(
                                width: .5.w,
                              ),
                              InkWell(
                                onTap: () {
                                  controller.isOrderList_or_ChatList.value =
                                      false;
                                  Future.delayed(Duration(seconds: 3), () {
                                    controller.scrollcontroller.jumpTo(
                                        controller.scrollcontroller.position
                                            .maxScrollExtent);
                                  });
                                },
                                child: Icon(
                                  Icons.chat_rounded,
                                  size: 4.sp,
                                ),
                              )
                            ],
                          ),
                        ),
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
                        Obx(
                          () => controller.isOrderList_or_ChatList.value == true
                              ? Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(
                                        left: 1.w,
                                        right: 1.w,
                                        top: 2.h,
                                        bottom: 1.h),
                                    child: Obx(
                                      () => ListView.builder(
                                        itemCount: controller.items.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 1.h),
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
                                                                controller
                                                                    .items[
                                                                        index]
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              controller
                                                                  .items[index]
                                                                  .productName,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      2.5.sp),
                                                            ),
                                                            Text(
                                                              controller
                                                                      .items[
                                                                          index]
                                                                      .productQty
                                                                      .toString() +
                                                                  "pcs.",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      2.5.sp),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          " ₱ " +
                                                              controller
                                                                  .items[index]
                                                                  .productPrice
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 2.5.sp),
                                                        ),
                                                        Expanded(
                                                            child: Container(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Text(
                                                            " ₱ " +
                                                                (controller
                                                                            .items[
                                                                                index]
                                                                            .productPrice *
                                                                        controller
                                                                            .items[index]
                                                                            .productQty)
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    2.5.sp),
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
                                )
                              : Expanded(
                                  child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(
                                      left: 1.w,
                                      right: 1.w,
                                      top: 2.h,
                                      bottom: 1.h),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Obx(
                                          () => ListView.builder(
                                            itemCount: controller
                                                .chatListforDisplay.length,
                                            controller:
                                                controller.scrollcontroller,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      left: 14,
                                                      right: 14,
                                                      top: 10,
                                                    ),
                                                    child: Align(
                                                      alignment: (controller
                                                                  .chatListforDisplay[
                                                                      index]
                                                                  .sender ==
                                                              "customer"
                                                          ? Alignment.topLeft
                                                          : Alignment.topRight),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: (controller
                                                                      .chatListforDisplay[
                                                                          index]
                                                                      .sender ==
                                                                  "customer"
                                                              ? Colors
                                                                  .grey.shade200
                                                              : Colors
                                                                  .orange[200]),
                                                        ),
                                                        padding:
                                                            EdgeInsets.all(16),
                                                        child: Text(
                                                          controller
                                                              .chatListforDisplay[
                                                                  index]
                                                              .message,
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 2.w,
                                                      right: 2.w,
                                                    ),
                                                    child: Align(
                                                        alignment: (controller
                                                                    .chatListforDisplay[
                                                                        index]
                                                                    .sender ==
                                                                "customer"
                                                            ? Alignment.topLeft
                                                            : Alignment
                                                                .topRight),
                                                        child: Text(
                                                          DateFormat('yMMMd')
                                                                  .format(controller
                                                                      .chatListforDisplay[
                                                                          index]
                                                                      .date) +
                                                              " " +
                                                              DateFormat('jm')
                                                                  .format(controller
                                                                      .chatListforDisplay[
                                                                          index]
                                                                      .date),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 1.5.sp),
                                                        )),
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 5.h,
                                        color: Colors.grey[200],
                                        padding: EdgeInsets.only(
                                            left: 1.w, right: 1.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 4.h,
                                              width: 20.w,
                                              child: TextField(
                                                controller: controller.message,
                                                decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: .5.w),
                                                    alignLabelWithHint: false,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    hintText:
                                                        'Type something..'),
                                              ),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  controller.sendMessage(
                                                      chat: controller
                                                          .message.text);
                                                },
                                                child: Icon(Icons.send))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
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
        ],
      ),
    );
  }
}
