import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderingappwebadmin/services/getstorage_services.dart';
import 'package:orderingappwebadmin/src/dashboard_screen/widget/HistoryScreen.dart';
import '../../login_and_register_screen/view/login_and_register_screen_view.dart';
import '../controller/dashboard_screen_controller.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:sizer/sizer.dart';

import '../widget/DriverScreen.dart';
import '../widget/OrderScreen.dart';
import '../widget/ProductScreen.dart';

class DashboardScreenView extends StatefulWidget {
  static const String id = "dashboard";

  @override
  State<DashboardScreenView> createState() => _DashboardScreenViewState();
}

class _DashboardScreenViewState extends State<DashboardScreenView> {
  RxString selectedScreen = OrderScreen.id.obs;

  final controller = Get.put(DashboardScreenController());
  @override
  void initState() {
    if (Get.find<StorageServices>().storage.read("screen") != null) {
      selectedScreen.value = Get.find<StorageServices>().storage.read("screen");
    }
    super.initState();
  }

  currenctScreen({required AdminMenuItem item}) async {
    if (item.route == OrderScreen.id) {
      selectedScreen.value = OrderScreen.id;
      await controller.getOrders();
      controller.getCounts();
    } else if (item.route == ProductScreen.id) {
      selectedScreen.value = ProductScreen.id;
    } else if (item.route == HistoryScreen.id) {
      selectedScreen.value = HistoryScreen.id;
      await controller.getOrders();
      controller.getCounts();
    } else if (item.route == DriverScreen.id) {
      selectedScreen.value = DriverScreen.id;
      controller.getDrivers();
    }
    Get.find<StorageServices>().saveRoute(screen: selectedScreen.value);
  }

  @override
  Widget build(BuildContext context) {
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
            AdminMenuItem(
              title: 'Driver',
              route: DriverScreen.id,
              icon: Icons.motorcycle,
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
              Get.offAllNamed(LoginAndRegisterScreenView.id);
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
                : selectedScreen.value == HistoryScreen.id
                    ? HistoryScreen()
                    : DriverScreen()));
  }
}
