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
import 'package:sizer/sizer.dart';
import '../model/dashboard_screen_chat_model.dart';
import '../model/dashboard_screen_order_model.dart';
import '../model/dashboard_screen_products_model.dart';
import '../widget/AddProductscreen_alertdialog.dart';

class DashboardScreenController extends GetxController {
  RxList<OrderModel> orderList = <OrderModel>[].obs;
  RxList<OrderModel> orderList_masterlist = <OrderModel>[].obs;
  RxList<OrderModel> orderList_History = <OrderModel>[].obs;
  RxList<OrderModel> orderList_History_masterList = <OrderModel>[].obs;

  RxList<ChatModel> chatList = <ChatModel>[].obs;
  RxList<ChatModel> chatListforDisplay = <ChatModel>[].obs;
  RxList<OrderList> items = <OrderList>[].obs;

  RxList<ProductsModel> products_list = <ProductsModel>[].obs;
  RxList<ProductsModel> products_list_masterList = <ProductsModel>[].obs;
  RxString imageName = ''.obs;
  RxString status = ''.obs;
  RxString order_id = ''.obs;
  RxString userToken = ''.obs;

  RxString delivery_fee = ''.obs;
  RxString subtotal = ''.obs;
  RxString total_amount = ''.obs;
  RxString selected_customer_id = ''.obs;

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

  RxDouble pending_count = 0.0.obs;
  RxDouble accepted_count = 0.0.obs;
  RxDouble preparing_count = 0.0.obs;
  RxDouble checkout_count = 0.0.obs;
  RxDouble cancelled_count = 0.0.obs;

  RxDouble pending_percent = 0.0.obs;
  RxDouble accepted_percent = 0.0.obs;
  RxDouble preparing_percent = 0.0.obs;
  RxDouble checkout_percent = 0.0.obs;
  RxDouble cancelled_percent = 0.0.obs;

  Stream? streamChats;
  StreamSubscription<dynamic>? chat_listener;
  RxBool isOrderList_or_ChatList = true.obs;
  RxBool isShown = false.obs;

  UploadTask? uploadTask;

  TextEditingController message = TextEditingController();
  Timer? debounce;
  ScrollController scrollcontroller = ScrollController();
  @override
  void onInit() async {
    await getOrders();
    await getChat();
    ordersListener();
    getProducts();
    getCounts();
    streamChat();
    super.onInit();
  }

  @override
  void onClose() {
    listener!.cancel();
    chat_listener!.cancel();
    debounce!.cancel();
    super.onClose();
  }

  getChat() async {
    List data = [];
    var storeDocumentReference = await FirebaseFirestore.instance
        .collection('store')
        .doc(Get.find<StorageServices>().storage.read("id"));

    var res = await FirebaseFirestore.instance
        .collection('chat')
        .where("store", isEqualTo: storeDocumentReference)
        .limit(100)
        .get();

    var chatData = await res.docs;
    for (var i = 0; i < chatData.length; i++) {
      Map obj = {
        "id": chatData[i].id,
        "message": chatData[i]['message'],
        "sender": chatData[i]['sender'],
        "date": chatData[i]['date'].toDate().toString(),
        "orderid": chatData[i]['orderid'],
      };
      data.add(obj);
    }
    var encodedData = await jsonEncode(data);
    chatList.assignAll(await chatModelFromJson(encodedData));
    chatList.sort((a, b) => a.date.compareTo(b.date));
  }

  streamChat() async {
    var storeDocumentReference = await FirebaseFirestore.instance
        .collection('store')
        .doc(Get.find<StorageServices>().storage.read("id"));

    streamChats = await FirebaseFirestore.instance
        .collection('chat')
        .where("store", isEqualTo: storeDocumentReference)
        .snapshots();

    chat_listener = await streamChats!.listen(
      (event) {
        List docChanges = [];
        for (var change in event.docChanges) {
          bool isExist = false;
          for (var i = 0; i < chatList.length; i++) {
            if (chatList[i].id == change.doc.id) {
              isExist = true;
            }
          }
          // print("$isExist ${change.doc.id}");
          // print(change.doc['customer'].id);
          if (isExist == false) {
            chatList.add(ChatModel(
                id: change.doc.id,
                message: change.doc['message'],
                sender: change.doc['sender'],
                orderid: change.doc['orderid'],
                date: change.doc['date'].toDate()));
            if (chatListforDisplay.length > 0 &&
                selected_customer_id.value == change.doc['customer'].id &&
                change.doc['sender'] == "customer") {
              chatListforDisplay.add(ChatModel(
                  id: change.doc.id,
                  message: change.doc['message'],
                  sender: change.doc['sender'],
                  orderid: change.doc['orderid'],
                  date: change.doc['date'].toDate()));
            }
            if (change.doc['sender'] == "customer") {
              if (debounce?.isActive ?? false) debounce!.cancel();

              if (scrollcontroller.hasClients) {
                Future.delayed(Duration(seconds: 3), () {
                  scrollcontroller
                      .jumpTo(scrollcontroller.position.maxScrollExtent);
                });
              }
              docChanges.add({
                "id": change.doc.id,
                "message": change.doc['message'],
                "order_id": change.doc['orderid'],
              });
              for (var i = 0; i < orderList.length; i++) {
                if (orderList[i].id == change.doc['orderid']) {
                  orderList[i].hasMessage.value = true;
                }
              }
            }
          }
        }
        final stores = docChanges.map((e) => e['id']).toSet();
        docChanges.retainWhere((x) => stores.remove(x['id']));

        showSnackBar(docChanges: docChanges);
      },
    );
  }

  showSnackBar({required List docChanges}) async {
    print(docChanges.length);
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
    ScaffoldMessenger.of(Get.context!).removeCurrentSnackBar();
    ScaffoldMessenger.of(Get.context!).clearSnackBars();
    for (var i = 0; i < docChanges.length; i++) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          content: Container(
            width: 100.w,
            height: 7.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Message",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3.sp,
                            color: Colors.black),
                      ),
                      Text(
                        docChanges[i]['message'],
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 2.sp,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Order#: ",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 2.sp,
                          color: Colors.grey),
                    ),
                    Text(
                      docChanges[i]['order_id'],
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 2.sp,
                          color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          ),
          backgroundColor: Colors.orange[100],
          action: SnackBarAction(
            textColor: Colors.black,
            label: 'View',
            onPressed: () {},
          ),
        ),
      );
    }
  }

  showChat({required String orderID}) {
    chatListforDisplay.clear();
    print(orderID);
    for (var i = 0; i < chatList.length; i++) {
      if (orderID == chatList[i].orderid) {
        chatListforDisplay.add(chatList[i]);
        print(chatList[i].orderid);
        print(chatList[i].orderid);
        print(chatList[i].message);
      }
    }
    if (scrollcontroller.hasClients) {
      Future.delayed(Duration(seconds: 3), () {
        scrollcontroller.jumpTo(scrollcontroller.position.maxScrollExtent);
      });
    }
  }

  sendMessage({required String chat}) async {
    try {
      var storeDocumentReference = await FirebaseFirestore.instance
          .collection('store')
          .doc(Get.find<StorageServices>().storage.read("id"));
      var userDocumentReference = await FirebaseFirestore.instance
          .collection('users')
          .doc(selected_customer_id.value);
      var res = await FirebaseFirestore.instance.collection('chat').add({
        "customer": userDocumentReference,
        "date": Timestamp.now(),
        "message": chat,
        "orderid": order_id.value.toString(),
        "sender": "store",
        "store": storeDocumentReference
      });
      chatListforDisplay.add(ChatModel(
          id: res.id,
          message: chat,
          sender: "store",
          orderid: order_id.value.toString(),
          date: DateTime.now()));
      message.clear();
      sendNotificationIfOffline(chat: chat, orderid: order_id.value.toString());
      Future.delayed(Duration(seconds: 3), () {
        scrollcontroller.jumpTo(scrollcontroller.position.maxScrollExtent);
      });
    } catch (e) {}
  }

  sendNotificationIfOffline(
      {required String chat, required String orderid}) async {
    var customer = await FirebaseFirestore.instance
        .collection('users')
        .doc(selected_customer_id.value)
        .get();

    var data = customer.data();
    bool isonline = jsonDecode(jsonEncode(data))['online'];
    String fcmToken = jsonDecode(jsonEncode(data))['fcmToken'];
    if (isonline == false) {
      var body = jsonEncode({
        "to": "$fcmToken",
        "notification": {
          "body": chat,
          "title": Get.find<StorageServices>().storage.read('name'),
          "subtitle": "Tracking Order: $orderid",
        },
        "data": {"notif_from": "Chat", "value": "$orderid"},
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
          "customer_id": storeData[i]['customer_id'].id,
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
      orderList_masterlist.assignAll(await orderModelFromJson(jsonEncodedData));
      orderList_History
          .assignAll(await orderModelFromJson(jsonEncodedData_for_history));
      orderList_History_masterList
          .assignAll(await orderModelFromJson(jsonEncodedData_for_history));
    } catch (e) {}
  }

  getCounts() async {
    for (var z = 0; z < orderList_History.length; z++) {
      if (orderList_History[z].orderStatus == "Pending") {
        pending_count.value = pending_count.value + 1;
      } else if (orderList_History[z].orderStatus == "Accepted") {
        accepted_count.value = accepted_count.value + 1;
      } else if (orderList_History[z].orderStatus == "Preparing") {
        preparing_count.value = preparing_count.value + 1;
      } else if (orderList_History[z].orderStatus == "Checkout") {
        checkout_count.value = checkout_count.value + 1;
      } else if (orderList_History[z].orderStatus == "Cancelled") {
        cancelled_count.value = cancelled_count.value + 1;
      }
    }

    pending_percent.value = pending_count.value / orderList_History.length;
    accepted_percent.value = accepted_count.value / orderList_History.length;
    preparing_percent.value = preparing_count.value / orderList_History.length;
    checkout_percent.value = checkout_count.value / orderList_History.length;
    cancelled_percent.value = cancelled_count.value / orderList_History.length;
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

  searchOrder({required String word}) async {
    RxList<OrderModel> temp_list = <OrderModel>[].obs;
    if (word == "") {
      orderList.assignAll(orderList_masterlist);
    } else {
      for (var i = 0; i < orderList_masterlist.length; i++) {
        if (orderList_masterlist[i]
            .id
            .toLowerCase()
            .toString()
            .contains(word.toLowerCase().toString())) {
          temp_list.add(orderList_masterlist[i]);
        }
      }
      orderList.assignAll(temp_list);
    }
  }

  searchHistory({required String word}) async {
    RxList<OrderModel> temp_list = <OrderModel>[].obs;
    if (word == "") {
      orderList_History.assignAll(orderList_History_masterList);
    } else {
      for (var i = 0; i < orderList_History_masterList.length; i++) {
        if (orderList_History_masterList[i]
            .id
            .toLowerCase()
            .toString()
            .contains(word.toLowerCase().toString())) {
          temp_list.add(orderList_History_masterList[i]);
        }
      }
      orderList_History.assignAll(temp_list);
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
      },
      "data": {"notif_from": "Order Status", "value": ""}
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
