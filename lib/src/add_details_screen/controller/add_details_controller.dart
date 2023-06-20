import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geo_firestore_flutter/geo_firestore_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../alertdialog/add_details_alertdialog.dart';

class AddDetailsController extends GetxController {
  final Completer<GoogleMapController> google_controller =
      Completer<GoogleMapController>();
  RxList<Marker> markers = <Marker>[].obs;
  LatLng tapped_location = LatLng(0.0, 0.0);
  RxString full_Address = ''.obs;

  String username = '';
  String password = '';

  final ImagePicker picker = ImagePicker();
  Uint8List? uint8list;
  XFile? imageFile;
  RxString imagePath = "".obs;
  RxString imageName = ''.obs;

  UploadTask? uploadTask;

  TextEditingController storename = TextEditingController();
  @override
  void onInit() async {
    username = await Get.arguments['username'];
    password = await Get.arguments['password'];
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  tapMap(latlng) async {
    tapped_location = latlng;
    var lat = latlng.latitude;
    var lng = latlng.longitude;
    var res = await http.get(Uri.parse(
        'https://www.mapquestapi.com/geocoding/v1/reverse?key=eQ4Sr8zMJ6WtwzitRZktia9ucM16abde&location=$lat,$lng&includeRoadMetadata=true&includeNearestIntersection=true'));
    // print(jsonDecode(res.body)['results']);
    List loc = jsonDecode(res.body)['results'];
    if (loc.length > 0) {
      List addresses = loc[0]['locations'];
      full_Address.value = addresses[0]['street'] +
          " " +
          addresses[0]['adminArea6'] +
          " " +
          addresses[0]['adminArea5'];
    }
    markers.clear();
    markers.add(Marker(
      markerId: MarkerId("1"),
      infoWindow:
          InfoWindow(title: full_Address.value, snippet: full_Address.value),
      position: latlng,
    ));
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

  uploadImageAndStoreDetails() async {
    if (imageFile != null) {
      final ref = await FirebaseStorage.instance
          .ref()
          .child("files/${imageFile!.name}");
      uploadTask = ref.putData(uint8list!);
      final snapshot = await uploadTask!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();

      try {
        var res = await FirebaseFirestore.instance.collection("store").add({
          "address": full_Address.value,
          "image": urlDownload,
          "name": storename.text,
          "password": password,
          "popular": false,
          "username": username,
        });
        await setGeoPoint(documentID: res.id);
        Get.back();
        AddDetailsDialog.showSuccessRegister();
      } on Exception catch (e) {
        print(e.toString());
      }
    }
  }

  setGeoPoint({required String documentID}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    GeoFirestore geoFirestore = GeoFirestore(firestore.collection('store'));

    await geoFirestore.setLocation(documentID,
        GeoPoint(tapped_location.latitude, tapped_location.longitude));
  }
}
