import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:pie_chart/pie_chart.dart';
import '../controller/dashboard_screen_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
                  controller.searchHistory(word: value);
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
                                itemCount: controller.orderList_History.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: .5.h, top: .5.h),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  controller
                                                      .orderList_History[index]
                                                      .id
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
                                                          .orderList_History[
                                                              index]
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
                                                          .orderList_History[
                                                              index]
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
                                                          .orderList_History[
                                                              index]
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
                                                  controller
                                                      .orderList_History[index]
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
                    padding: EdgeInsets.only(
                        left: 1.w, right: 1.w, top: 1.h, bottom: 1.h),
                    width: 20.w,
                    color: Colors.orange[50],
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 1.h),
                          height: 38.h,
                          width: 100.w,
                          color: Colors.white,
                          child: Obx(
                            () => PieChart(
                              dataMap: {
                                "Pending": controller.pending_count.value,
                                "Accepted": controller.accepted_count.value,
                                "Preparing": controller.preparing_count.value,
                                "Checkout": controller.checkout_count.value,
                                "Cancelled": controller.cancelled_count.value,
                              },
                              colorList: [
                                Colors.orange,
                                Colors.yellow,
                                Colors.blue,
                                Colors.green,
                                Colors.red
                              ],
                              legendOptions: LegendOptions(
                                showLegendsInRow: true,
                                legendPosition: LegendPosition.bottom,
                                showLegends: true,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 1.h),
                          height: 38.h,
                          width: 100.w,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Obx(
                                    () => CircularPercentIndicator(
                                      radius: 40.0,
                                      lineWidth: 8.0,
                                      animation: true,
                                      percent: controller.pending_percent.value,
                                      center: Text(
                                        (controller.pending_percent.value * 100)
                                                .toStringAsFixed(2)
                                                .toString() +
                                            "%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 2.50.sp),
                                      ),
                                      footer: Text(
                                        "Pending",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 2.50.sp),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Colors.orange,
                                    ),
                                  ),
                                  Obx(
                                    () => CircularPercentIndicator(
                                      radius: 40.0,
                                      lineWidth: 8.0,
                                      animation: true,
                                      percent:
                                          controller.accepted_percent.value,
                                      center: Text(
                                        (controller.accepted_percent.value *
                                                    100)
                                                .toStringAsFixed(2)
                                                .toString() +
                                            "%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 2.50.sp),
                                      ),
                                      footer: Text(
                                        "Accepted",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 2.50.sp),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Colors.yellow,
                                    ),
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => CircularPercentIndicator(
                                      radius: 40.0,
                                      lineWidth: 8.0,
                                      animation: true,
                                      percent:
                                          controller.preparing_percent.value,
                                      center: Text(
                                        (controller.preparing_percent.value *
                                                    100)
                                                .toStringAsFixed(2)
                                                .toString() +
                                            "%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 2.50.sp),
                                      ),
                                      footer: Text(
                                        "Preparing",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 2.50.sp),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Colors.blue,
                                    ),
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Obx(
                                    () => CircularPercentIndicator(
                                      radius: 40.0,
                                      lineWidth: 8.0,
                                      animation: true,
                                      percent:
                                          controller.checkout_percent.value,
                                      center: Text(
                                        (controller.checkout_percent.value *
                                                    100)
                                                .toStringAsFixed(2)
                                                .toString() +
                                            "%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 2.50.sp),
                                      ),
                                      footer: Text(
                                        "Checkout",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 2.50.sp),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Colors.green,
                                    ),
                                  ),
                                  Obx(
                                    () => CircularPercentIndicator(
                                      radius: 40.0,
                                      lineWidth: 8.0,
                                      animation: true,
                                      percent:
                                          controller.cancelled_percent.value,
                                      center: Text(
                                        (controller.cancelled_percent.value *
                                                    100)
                                                .toStringAsFixed(2)
                                                .toString() +
                                            "%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 2.50.sp),
                                      ),
                                      footer: Text(
                                        "Cancelled",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 2.50.sp),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Colors.red,
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          ),
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
