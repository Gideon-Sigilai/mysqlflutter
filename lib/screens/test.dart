import 'package:mysqlflutter/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Test11 extends StatefulWidget {
  const Test11({Key? key}) : super(key: key);

  @override
  State<Test11> createState() => _Test11State();
}

class _Test11State extends State<Test11> {
  Controller cx = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(cx.toString()),
      ),
    );
  }
}
