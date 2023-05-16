import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderingappwebadmin/src/dashboard_screen/view/dashboard_screen_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../services/getstorage_services.dart';

class LoginScreenController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final Uri facebookUrl = Uri.parse('https://www.facebook.com/');
  final Uri weChatUrl = Uri.parse('https://www.wechat.com/');
  final Uri discordUrl = Uri.parse('https://discord.com/');
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  login({required String username, required String password}) async {
    List data = [];
    Map userData = {};
    try {
      await FirebaseFirestore.instance
          .collection('store')
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          Map elementData = {
            "id": element.id,
            "address": element['address'],
            "image": element['image'],
            "name": element['name'],
            "username": element['username'],
            "password": element['password'],
            "popular": element['popular'],
          };
          userData = elementData;
          data.add(elementData);
        });
      });
      print(data);
      if (data.isNotEmpty || data.length != 0) {
        Get.find<StorageServices>().saveCredentials(
          id: userData['id'],
          username: userData['username'],
          password: userData['password'],
          name: userData['name'],
          popular: userData['popular'],
          image: userData['image'],
          address: userData['address'],
        );
        Get.offAllNamed(DashboardScreenView.id);
      } else {}
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> launchInBrowserFacebook() async {
    if (!await launchUrl(
      facebookUrl,
      webOnlyWindowName: '_blank',
    )) {
      throw Exception('Could not launch $facebookUrl');
    }
  }

  Future<void> launchInBrowserWeChat() async {
    if (!await launchUrl(
      weChatUrl,
      webOnlyWindowName: '_blank',
    )) {
      throw Exception('Could not launch $weChatUrl');
    }
  }

  Future<void> launchInBrowserDiscord() async {
    if (!await launchUrl(
      discordUrl,
      webOnlyWindowName: '_blank',
    )) {
      throw Exception('Could not launch $discordUrl');
    }
  }
}
