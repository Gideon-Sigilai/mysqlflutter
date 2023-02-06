import 'package:mysqlflutter/constants/colors.dart';
import 'package:mysqlflutter/controllers/controllers.dart';
import 'package:mysqlflutter/logics/logics.dart';
import 'package:mysqlflutter/logics/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';

class Update extends StatefulWidget {
  const Update({Key? key}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  TextEditingController _label = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _type = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _time = TextEditingController();
  TextEditingController _paymentoption = TextEditingController();

  @override
  void initState() {
    getSQLData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ColorsX cex = ColorsX();
    return SafeArea(child: Scaffold(
      body: Column(children: [
        AppBar(
          backgroundColor: cex.primarydark,
        ),

        TextEd(_label, "label"),
        TextEd(_amount, "Amount"),
        TextEd(_type, "Type"),
        TextEd(_date, "Date"),
        TextEd(_time, "Time"),
        TextEd(_paymentoption, "PaymentOption"),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(onPressed: () async{
              final db = Mysql();
                db.getConnection().then((conn) {
                  String sqlQuery = 'UPDATE data1 SET label = ? , Amount = ?, Type = ?, Date = ?, Time = ?, PaymentOption = ? WHERE id = ${cx.id};';
                  conn.query(sqlQuery, [_label.text, _amount.text,_type.text,_date.text,_time.text,_paymentoption.text,]);
                  setState(() {});
                  Get.snackbar("Success", "Updated Successfully");
                  Navigator.pop(context);
                });


            }, child: Text("Update")),
            MaterialButton(onPressed: () async{
              cx.Delete(cx.id);
              Get.snackbar("Success", "Deleted Successfully");
              Navigator.pop(context);
            }
            , child: Text("Delete",style: TextStyle(color: Colors.white),),color: Colors.blue,),
          ],
        ),

        Spacer()
      ],),
    ));
  }
  Widget TextEd(controller, label){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        icon: Icon(Icons.edit),
      ),
    );
  }
  void getSQLData() async {
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      String sqlQuery = 'Select * from data1 where id = ? ';
      await conn.query(sqlQuery,[cx.id]).then((value) {
        for (var res in value) {
            _label.text = res[0].toString();
            _amount.text = res[1].toString();
            _type.text = res[2].toString();
            _date.text = res[3].toString();
            _time.text = res[4].toString();
            _paymentoption.text = res[5].toString();
        }
      }).onError((error, stackTrace) {
        print(error);
      });
    });



  }
}
Controller cx = Get.put(Controller());