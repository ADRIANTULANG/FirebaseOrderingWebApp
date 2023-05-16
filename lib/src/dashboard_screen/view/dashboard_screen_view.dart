import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderingappwebadmin/services/getstorage_services.dart';
import 'package:orderingappwebadmin/src/dashboard_screen/widget/HistoryScreen.dart';
import '../../login_screen/view/login_screen_view.dart';
import '../controller/dashboard_screen_controller.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:sizer/sizer.dart';

import '../widget/OrderScreen.dart';
import '../widget/ProductScreen.dart';

class DashboardScreenView extends StatefulWidget {
  static const String id = "dashboard";

  @override
  State<DashboardScreenView> createState() => _DashboardScreenViewState();
}

class _DashboardScreenViewState extends State<DashboardScreenView> {
  RxString selectedScreen = OrderScreen.id.obs;
  @override
  void initState() {
    if (Get.find<StorageServices>().storage.read("screen") != null) {
      selectedScreen.value = Get.find<StorageServices>().storage.read("screen");
    }
    super.initState();
  }

  currenctScreen({required AdminMenuItem item}) {
    if (item.route == OrderScreen.id) {
      selectedScreen.value = OrderScreen.id;
    } else if (item.route == ProductScreen.id) {
      selectedScreen.value = ProductScreen.id;
    } else if (item.route == HistoryScreen.id) {
      selectedScreen.value = HistoryScreen.id;
    }
    Get.find<StorageServices>().saveRoute(screen: selectedScreen.value);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardScreenController());
    return AdminScaffold(
        appBar: AppBar(
          title: Container(
            child: Text(
              Get.find<StorageServices>().storage.read("name"),
              style: TextStyle(
                fontSize: 3.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        sideBar: SideBar(
          iconColor: Colors.amber[800],
          backgroundColor: Colors.white,
          items: [
            AdminMenuItem(
              title: 'Orders',
              route: OrderScreen.id,
              icon: Icons.receipt_long,
            ),
            AdminMenuItem(
              title: 'Product',
              route: ProductScreen.id,
              icon: Icons.food_bank_rounded,
            ),
            AdminMenuItem(
              title: 'History',
              route: HistoryScreen.id,
              icon: Icons.list,
            ),
          ],
          selectedRoute: DashboardScreenView.id,
          onSelected: (item) {
            currenctScreen(item: item);
          },
          header: Container(
            height: 20.h,
            child: Column(
              children: [
                Container(
                  height: 20.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo.png"))),
                ),
              ],
            ),
          ),
          footer: InkWell(
            onTap: () {
              Get.find<StorageServices>().removeStorageCredentials();
              Get.offAllNamed(LoginScreenView.id);
            },
            child: Container(
              height: 4.h,
              width: double.infinity,
              color: Colors.amber[800],
              child: Center(
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Obx(() => selectedScreen.value == OrderScreen.id
            ? OrderScreen()
            : selectedScreen.value == ProductScreen.id
                ? ProductScreen()
                : HistoryScreen()));
  }
}
