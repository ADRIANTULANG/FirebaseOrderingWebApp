import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orderingappwebadmin/src/add_details_screen/controller/add_details_controller.dart';
import 'package:sizer/sizer.dart';

class AddDetailsView extends GetView<AddDetailsController> {
  static const String id = "adddetails";

  @override
  Widget build(BuildContext context) {
    Get.put(AddDetailsController());
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Container(
              width: 30.w,
              height: 100.h,
              color: Colors.grey[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, right: 2.w),
                        child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, right: 2.w),
                        child: InkWell(
                          onTap: () {
                            controller.getImage();
                          },
                          child: Obx(
                            () => controller.imagePath.value == ""
                                ? Container(
                                    height: 35.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Colors.white),
                                    child: Icon(Icons.image),
                                  )
                                : Container(
                                    height: 35.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: MemoryImage(
                                                controller.uint8list!))),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, right: 2.w),
                        child: Text(
                          "Store Name",
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
                          onEditingComplete: () {},
                          obscureText: false,
                          controller: controller.storename,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.only(left: .5.w),
                              alignLabelWithHint: false,
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, right: 2.w),
                        child: Text(
                          "Store Address",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 2.5.sp),
                        ),
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, right: 2.w),
                        child: Container(
                          padding: EdgeInsets.only(left: .3.w),
                          height: 5.h,
                          width: 100.w,
                          decoration: BoxDecoration(color: Colors.white),
                          alignment: Alignment.centerLeft,
                          child: Obx(
                            () => Text(
                              controller.full_Address.value,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 2.4.sp),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, right: 2.w),
                        child: InkWell(
                          onTap: () {
                            controller.uploadImageAndStoreDetails();
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
                              "DONE",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 3.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Obx(
                  () => GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(8.24464951074821, 124.25674850288009),
                      zoom: 17.4746,
                    ),
                    markers: controller.markers.toSet(),
                    onTap: (latlng) {
                      controller.tapMap(latlng);
                    },
                    onMapCreated: (GoogleMapController g_controller) {
                      controller.google_controller.complete(g_controller);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
