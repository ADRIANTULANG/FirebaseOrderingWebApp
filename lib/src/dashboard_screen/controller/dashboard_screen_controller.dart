import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orderingappwebadmin/services/getstorage_services.dart';
import 'package:http/http.dart' as http;
import '../model/dashboard_screen_order_model.dart';
import '../model/dashboard_screen_products_model.dart';
import '../widget/AddProductscreen_alertdialog.dart';

class DashboardScreenController extends GetxController {
  RxList<OrderModel> orderList = <OrderModel>[].obs;
  RxList<OrderModel> orderList_History = <OrderModel>[].obs;
  RxList<ProductsModel> products_list = <ProductsModel>[].obs;
  RxList<ProductsModel> products_list_masterList = <ProductsModel>[].obs;
  RxString imageName = ''.obs;
  final ImagePicker picker = ImagePicker();
  Timer? _debounce;
  Timer? debounceProducts;
  StreamSubscription<dynamic>? listener;
  Uint8List? uint8list;
  XFile? imageFile;
  RxString imagePath = "".obs;
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();

  TextEditingController searchproducts = TextEditingController();

  RxInt pending_count = 0.obs;
  RxInt success_count = 0.obs;
  RxInt cancelled_count = 0.obs;

  UploadTask? uploadTask;
  @override
  void onInit() async {
    await getOrders();
    ordersListener();
    getProducts();
    getCounts();
    super.onInit();
  }

  @override
  void onClose() {
    listener!.cancel();
    super.onClose();
  }

  getOrders() async {
    List data = [];
    List data_temp_for_history = [];
    try {
      var storeDocumentReference = await FirebaseFirestore.instance
          .collection('store')
          .doc(Get.find<StorageServices>().storage.read("id"));
      var storeResult = await FirebaseFirestore.instance
          .collection('orders')
          .where('order_store_id', isEqualTo: storeDocumentReference)
          .get();
      var storeData = await storeResult.docs;
      for (var i = 0; i < storeData.length; i++) {
        var customerDetailResult = await FirebaseFirestore.instance
            .collection('users')
            .doc(storeData[i]['customer_id'].id)
            .get();
        List orders = [];
        await FirebaseFirestore.instance
            .collection('order_products')
            .where("order_id", isEqualTo: storeData[i].id.toString())
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((element) {
            Map elements = {
              "order_id": element['order_id'],
              "product_id": element['product_id'],
              "product_image": element['product_image'],
              "product_name": element['product_name'],
              "product_price": element['product_price'],
              "product_qty": element['product_qty'],
            };
            orders.add(elements);
          });
        });

        Map elementData = {
          "id": storeData[i].id,
          "customer_details": customerDetailResult.data(),
          "delivery_fee": storeData[i]['delivery_fee'],
          "order_status": storeData[i]['order_status'],
          "order_store_id": storeData[i]['order_store_id'].id,
          "order_subtotal": storeData[i]['order_subtotal'],
          "order_total": storeData[i]['order_total'],
          "order_list": orders
        };
        if (storeData[i]['order_status'] == "Accepted" ||
            storeData[i]['order_status'] == "Pending" ||
            storeData[i]['order_status'] == "Preparing" ||
            storeData[i]['order_status'] == "Checkout") {
          data.add(elementData);
        }
        data_temp_for_history.add(elementData);
      }
      var jsonEncodedData = await jsonEncode(data.reversed.toList());
      var jsonEncodedData_for_history =
          await jsonEncode(data_temp_for_history.reversed.toList());
      orderList.assignAll(await orderModelFromJson(jsonEncodedData));
      orderList_History
          .assignAll(await orderModelFromJson(jsonEncodedData_for_history));
    } catch (e) {}
  }

  getCounts() async {
    for (var z = 0; z < orderList_History.length; z++) {
      if (orderList_History[z].orderStatus == "Pending") {
        pending_count.value = pending_count.value + 1;
      } else if (orderList_History[z].orderStatus == "Checkout") {
        success_count.value = success_count.value + 1;
      } else if (orderList_History[z].orderStatus == "Cancelled") {
        cancelled_count.value = cancelled_count.value + 1;
      }
    }
  }

  getProducts() async {
    List data = [];
    var storeDocumentReference = await FirebaseFirestore.instance
        .collection('store')
        .doc(Get.find<StorageServices>().storage.read("id"));
    await FirebaseFirestore.instance
        .collection('products')
        .where("product_store_id", isEqualTo: storeDocumentReference)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        Map elements = {
          "product_id": element.id,
          "product_image": element['product_image'],
          "product_name": element['product_name'],
          "product_price": element['product_price'],
        };
        data.add(elements);
      });
    });
    var jsonEncodedData = await jsonEncode(data.reversed.toList());
    products_list.assignAll(await productsModelFromJson(jsonEncodedData));
    products_list_masterList
        .assignAll(await productsModelFromJson(jsonEncodedData));
  }

  searchProducts({required String word}) async {
    RxList<ProductsModel> temp_list = <ProductsModel>[].obs;
    if (word == "") {
      products_list.assignAll(products_list_masterList);
    } else {
      for (var i = 0; i < products_list_masterList.length; i++) {
        if (products_list_masterList[i]
            .productName
            .toLowerCase()
            .toString()
            .contains(word.toLowerCase().toString())) {
          temp_list.add(products_list_masterList[i]);
        }
      }
      products_list.assignAll(temp_list);
    }
  }

  ordersListener() async {
    var storeDocumentReference = await FirebaseFirestore.instance
        .collection('store')
        .doc(Get.find<StorageServices>().storage.read("id"));
    listener = await FirebaseFirestore.instance
        .collection('orders')
        .where('order_store_id', isEqualTo: storeDocumentReference)
        .snapshots()
        .listen((event) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 2000), () {
        getOrders();
      });
    });
  }

  sendNotification(
      {required String userToken,
      required String status,
      required String orderid}) async {
    String message = "";
    if (status == "Accepted") {
      message = "Order Accepted";
    } else if (status == "Preparing") {
      message = "Your order is being Prepared";
    } else if (status == "Checkout") {
      message = "Your order is on the way!";
    } else if (status == "Cancelled") {
      message = "Your order is cancelled!";
    }
    var body = jsonEncode({
      "to": "$userToken",
      "notification": {
        "body": message,
        "title": "Food3ip",
        "subtitle": "Tracking Order: $orderid",
      }
    });
    var e2epushnotif =
        await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: {
              "Authorization":
                  "key=AAAAFXgQldg:APA91bH0blj9KQykFmRZ1Pjub61SPwFyaq-YjvtH1vTvsOeNQ6PTWCYm5S7pOZIuB5zuc7hrFFYsRbuxEB8vF9N5nQoW9fZckjy4bwwltxf4ATPeBDH4L4VlZ1yyVBHF3OKr3yVZ_Ioy",
              "Content-Type": "application/json"
            },
            body: body);
    print("e2e notif: ${e2epushnotif.body}");
  }

  updateOrder(
      {required String order_id,
      required String status,
      required String userToken}) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(order_id)
          .update({"order_status": status});
      sendNotification(userToken: userToken, status: status, orderid: order_id);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  getImage() async {
    try {
      XFile? imageresult = await picker.pickImage(source: ImageSource.gallery);
      if (imageresult != null) {
        imageFile = imageresult;
        uint8list = await imageFile!.readAsBytes();
        imageName.value = imageFile!.name;
        imagePath.value = imageFile!.path;
      } else {
        return null;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  uploadImageAndProductDetails() async {
    if (imageFile != null) {
      final ref = await FirebaseStorage.instance
          .ref()
          .child("files/${imageFile!.name}");
      uploadTask = ref.putData(uint8list!);
      final snapshot = await uploadTask!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();

      var storeDocumentReference = await FirebaseFirestore.instance
          .collection('store')
          .doc(Get.find<StorageServices>().storage.read("id"));

      try {
        await FirebaseFirestore.instance.collection("products").add({
          "product_image": urlDownload,
          "product_name": name.text,
          "product_price": double.parse(price.text),
          "product_store_id": storeDocumentReference
        });
        Get.back();
        AddProductScreenAlertDialog.showSuccessAdd();
        getProducts();
      } on Exception catch (e) {
        print(e.toString());
      }
    }
  }

  updateProducts(
      {required String id, required double price, required String name}) async {
    if (imagePath.value == "") {
      try {
        await FirebaseFirestore.instance.collection("products").doc(id).update({
          "product_name": name,
          "product_price": price,
        });
        Get.back();
        getProducts();
      } on Exception catch (e) {
        print(e.toString());
      }
    } else {
      try {
        final ref = await FirebaseStorage.instance
            .ref()
            .child("files/${imageFile!.name}");
        uploadTask = ref.putData(uint8list!);
        final snapshot = await uploadTask!.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance.collection("products").doc(id).update({
          "product_name": name,
          "product_price": price,
          "product_image": urlDownload,
        });
        Get.back();
        getProducts();
        AddProductScreenAlertDialog.showSuccessUpdate();
      } on Exception catch (e) {
        print(e.toString());
      }
    }
  }

  deleteProducts({required String id}) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(id).delete();
      AddProductScreenAlertDialog.showSuccessDelete();
      getProducts();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
