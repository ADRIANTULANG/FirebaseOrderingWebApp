import 'dart:async';

import 'package:get/get.dart';
import 'package:orderingappwebadmin/src/dashboard_screen/view/dashboard_screen_view.dart';
import 'package:orderingappwebadmin/src/login_screen/view/login_screen_view.dart';

import '../../../services/getstorage_services.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    navigateTo();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  navigateTo() async {
    Timer(Duration(seconds: 3), () {
      if (Get.find<StorageServices>().storage.read("id") == null) {
        Get.offAllNamed(LoginScreenView.id);
      } else {
        Get.offAllNamed(DashboardScreenView.id);
      }
    });
  }
}
