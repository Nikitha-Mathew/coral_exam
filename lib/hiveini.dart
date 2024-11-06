import 'package:coral_exam/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:coral_exam/cart.dart';
import 'package:coral_exam/home.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Hive.initFlutter();

    await Hive.openBox('cartBox');

    Get.put(CartController());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return GetMaterialApp(
          title: 'Flutter E-Commerce',
          home: HomePage(),
          getPages: [
            GetPage(name: '/cart', page: () => CartPage()),
          ],
        );
      },
    );
  }
}
