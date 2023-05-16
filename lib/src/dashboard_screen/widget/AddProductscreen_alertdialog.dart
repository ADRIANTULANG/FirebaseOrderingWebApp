import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orderingappwebadmin/src/dashboard_screen/controller/dashboard_screen_controller.dart';
import 'package:sizer/sizer.dart';

class AddProductScreenAlertDialog {
  static showSuccessAdd() async {
    Get.dialog(AlertDialog(
        content: Container(
      height: 5.h,
      width: 15.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Product Successfully Added!",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 2.5.sp,
                color: Colors.amber[900]),
          ),
        ],
      ),
    )));
  }

  static showSuccessUpdate() async {
    Get.dialog(AlertDialog(
        content: Container(
      height: 5.h,
      width: 15.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Product Updated Successfully!",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 2.5.sp,
                color: Colors.amber[900]),
          ),
        ],
      ),
    )));
  }

  static showSuccessDelete() async {
    Get.dialog(AlertDialog(
        content: Container(
      height: 5.h,
      width: 15.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Product Deleted Successfully!",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 2.5.sp,
                color: Colors.amber[900]),
          ),
        ],
      ),
    )));
  }

  static showAddProducts(
      {required DashboardScreenController controller}) async {
    controller.imageName.value = "";
    controller.imagePath.value = "";
    controller.uint8list = null;
    controller.name.clear();
    controller.price.clear();
    Get.dialog(AlertDialog(
        title: Text("Add Product"),
        content: Container(
          height: 20.h,
          width: 60.w,
          color: Colors.white,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  controller.getImage();
                },
                child: Obx(
                  () => controller.imagePath.value == ""
                      ? Container(
                          height: 20.h,
                          width: 15.w,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Icon(Icons.add),
                          ),
                        )
                      : Container(
                          height: 20.h,
                          width: 15.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(controller.uint8list!))),
                        ),
                ),
              ),
              SizedBox(
                width: .5.w,
              ),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    height: 7.h,
                    child: TextField(
                      controller: controller.name,
                      decoration: InputDecoration(
                          fillColor: Colors.amber[100],
                          filled: true,
                          contentPadding: EdgeInsets.only(left: .5.w),
                          alignLabelWithHint: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'Name'),
                    ),
                  ),
                  SizedBox(
                    height: .5.h,
                  ),
                  Container(
                    height: 5.h,
                    child: TextField(
                      controller: controller.price,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                      ],
                      decoration: InputDecoration(
                          fillColor: Colors.amber[100],
                          filled: true,
                          contentPadding: EdgeInsets.only(left: .5.w),
                          alignLabelWithHint: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'Price'),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () {
                      if (controller.name.text.isEmpty ||
                          controller.price.text.isEmpty ||
                          controller.imagePath.value == "") {
                      } else {
                        controller.uploadImageAndProductDetails();
                      }
                    },
                    child: Container(
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Add",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
            ],
          ),
        )));
  }

  static updateProducts(
      {required DashboardScreenController controller,
      required String id,
      required String name,
      required String price,
      required String image}) async {
    controller.imageName.value = "";
    controller.imagePath.value = "";
    controller.uint8list = null;
    controller.name.text = name;
    controller.price.text = price;
    Get.dialog(AlertDialog(
        title: Text("Update Product"),
        content: Container(
          height: 20.h,
          width: 60.w,
          color: Colors.white,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  controller.getImage();
                },
                child: Obx(
                  () => controller.imagePath.value == ""
                      ? Container(
                          height: 20.h,
                          width: 15.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(image))),
                        )
                      : Container(
                          height: 20.h,
                          width: 15.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(controller.uint8list!))),
                        ),
                ),
              ),
              SizedBox(
                width: .5.w,
              ),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    height: 7.h,
                    child: TextField(
                      controller: controller.name,
                      decoration: InputDecoration(
                          fillColor: Colors.amber[100],
                          filled: true,
                          contentPadding: EdgeInsets.only(left: .5.w),
                          alignLabelWithHint: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'Name'),
                    ),
                  ),
                  SizedBox(
                    height: .5.h,
                  ),
                  Container(
                    height: 5.h,
                    child: TextField(
                      controller: controller.price,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                      ],
                      decoration: InputDecoration(
                          fillColor: Colors.amber[100],
                          filled: true,
                          contentPadding: EdgeInsets.only(left: .5.w),
                          alignLabelWithHint: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'Price'),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () {
                      if (controller.name.text.isEmpty ||
                          controller.price.text.isEmpty) {
                      } else {
                        controller.updateProducts(
                            id: id,
                            price: double.parse(controller.price.text),
                            name: controller.name.text);
                      }
                    },
                    child: Container(
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Update",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
            ],
          ),
        )));
  }
}
