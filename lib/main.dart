import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderingappwebadmin/services/getstorage_services.dart';
import 'package:orderingappwebadmin/src/dashboard_screen/view/dashboard_screen_view.dart';
import 'package:orderingappwebadmin/src/dashboard_screen/widget/HistoryScreen.dart';
import 'package:orderingappwebadmin/src/dashboard_screen/widget/OrderScreen.dart';
import 'package:orderingappwebadmin/src/dashboard_screen/widget/ProductScreen.dart';

import 'package:orderingappwebadmin/src/splash_screen/view/splash_screen_view.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/login_screen/view/login_screen_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBnK0Ct6GCm3YUCuEDF6jYqS-v_Y_JZkGk",
          authDomain: "flutterfirebasepractice-647d4.firebaseapp.com",
          projectId: "flutterfirebasepractice-647d4",
          storageBucket: "flutterfirebasepractice-647d4.appspot.com",
          messagingSenderId: "92208666072",
          appId: "1:92208666072:web:bc6a55495abce89bc30ead",
          measurementId: "G-PRPECTM08V"));
  await Get.put(StorageServices());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        scrollBehavior: MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        debugShowCheckedModeBanner: false,
        title: 'Ordering App',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        initialRoute: SplashScreenView.id,
        routes: {
          SplashScreenView.id: (context) => SplashScreenView(),
          LoginScreenView.id: (context) => LoginScreenView(),
          DashboardScreenView.id: (context) => DashboardScreenView(),
          OrderScreen.id: (context) => OrderScreen(),
          ProductScreen.id: (context) => ProductScreen(),
          HistoryScreen.id: (context) => HistoryScreen(),
        },
      );
    });
  }
}
