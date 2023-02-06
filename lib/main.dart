import 'package:mysqlflutter/controllers/controllers.dart';
import 'package:mysqlflutter/screens/homepage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Controller cx = Get.put(Controller());
  runApp(const GetMaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
