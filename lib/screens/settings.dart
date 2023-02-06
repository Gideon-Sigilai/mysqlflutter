import 'package:flutter/material.dart';
class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);
  TextEditingController ip = TextEditingController();
  TextEditingController table = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(children: [
          AppBar(),
          Row(children: [Text("Input ip address: "),TextEd(ip)] ),
          SizedBox(height: 40,),
          MaterialButton(onPressed: (){},color: Colors.blue,child: Text("Save"),)
        ],),
      ),
    );
  }
  Widget TextEd(controller){
    return Expanded(child:TextField(
      controller: controller,
    ));
  }
}

