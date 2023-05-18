import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/dashboard_screen_controller.dart';
import 'AddProductscreen_alertdialog.dart';

class ProductScreen extends GetView<DashboardScreenController> {
  static const String id = "products";
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
                controller: controller.searchproducts,
                onChanged: (value) {
                  if (controller.debounceProducts?.isActive ?? false)
                    controller.debounceProducts!.cancel();
                  controller.debounceProducts =
                      Timer(const Duration(milliseconds: 800), () {
                    controller.searchProducts(
                        word: controller.searchproducts.text);
                    if (controller.searchproducts.text == "") {
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
            Expanded(
              child: Container(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.products_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: .5.h),
                        child: Column(
                          children: [
                            Container(
                              height: 10.h,
                              width: 100.w,
                              decoration: BoxDecoration(),
                              child: Row(
                                children: [
                                  Container(
                                    height: 10.h,
                                    width: 7.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(controller
                                                .products_list[index]
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
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              controller.products_list[index]
                                                  .productName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 2.5.sp),
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    AddProductScreenAlertDialog
                                                        .updateProducts(
                                                            controller:
                                                                controller,
                                                            id: controller
                                                                .products_list[
                                                                    index]
                                                                .productId,
                                                            name: controller
                                                                .products_list[
                                                                    index]
                                                                .productName,
                                                            price: controller
                                                                .products_list[
                                                                    index]
                                                                .productPrice
                                                                .toString(),
                                                            image: controller
                                                                .products_list[
                                                                    index]
                                                                .productImage);
                                                  },
                                                  child: Icon(
                                                    Icons.edit_document,
                                                    size: 4.5.sp,
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: .5.w,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    controller.deleteProducts(
                                                      id: controller
                                                          .products_list[index]
                                                          .productId,
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons
                                                        .delete_outline_rounded,
                                                    size: 4.5.sp,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 1.5.w,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Text(
                                          "₱ " +
                                              controller.products_list[index]
                                                  .productPrice
                                                  .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange,
                                              fontSize: 2.sp),
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            index == controller.products_list.length - 1
                                ? SizedBox()
                                : Divider()
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                AddProductScreenAlertDialog.showAddProducts(
                    controller: controller);
              },
              child: Container(
                height: 5.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.orange,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add Product",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 3.sp),
                    ),
                    Icon(Icons.add_box_rounded)
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
    );
  }
}
