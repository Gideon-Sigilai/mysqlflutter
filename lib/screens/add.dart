import 'package:mysqlflutter/controllers/controllers.dart';
import 'package:mysqlflutter/logics/logics.dart';
import 'package:flutter/material.dart';
import 'package:mysqlflutter/constants/colors.dart';
import 'package:get/get.dart';
import '../screens/homepage.dart';

HomePage hps = const HomePage();

class Add extends StatelessWidget {
  Add({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        addText(_label, "Label", 1),
        addText(_amount, "Amount", 2),
        addText(_option, "Payment Option", 1),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
                onPressed: (){
              cex.insertData(_label.text, _amount.text, "Expense", _option.text);
              Navigator.pop(context);
            }, child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Add Expense"),
            )),
            MaterialButton(onPressed: (){
              cex.insertData(_label.text, _amount.text, "Income", _option.text);
              Navigator.pop(context);

            }, color: Colors.blue,child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Add Income",style: TextStyle(color: Colors.white),),
            ),)
          ],
        ),
        const SizedBox(height: 10,)
      ],);
  }
  final db = Mysql();
  Widget addText(TextEditingController controller, String label, int no){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        maxLines: no,
        decoration: InputDecoration(

          hintText: label,
          label: Text(label),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7)
          )
        ),
      ),
    );
  }
}
TextEditingController _label = TextEditingController();
TextEditingController _amount = TextEditingController();
TextEditingController _option = TextEditingController();
//TextEditingController _ = TextEditingController();
ColorsX cx = ColorsX();
Controller cex = Get.put(Controller());