import 'dart:async';

import 'package:get/get.dart';
import 'package:orderingappwebadmin/src/dashboard_screen/view/dashboard_screen_view.dart';

import '../../../services/getstorage_services.dart';
import '../../login_and_register_screen/view/login_and_register_screen_view.dart';

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
        Get.offAllNamed(LoginAndRegisterScreenView.id);
      } else {
        Get.offAllNamed(DashboardScreenView.id);
      }
    });
  }
}
