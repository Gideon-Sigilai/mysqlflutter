import 'dart:math';

import 'package:get/get.dart';
import 'package:mysqlflutter/logics/logics.dart';

String Date =
    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
String Time =
    "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";

class Controller extends GetxController {
  int id = 0;
  int totallength = 0;
  double totalIncome = 0.0;
  double totalExpense = 0.0;

  Future<void> stateTotals() async {
    final Mysql db = Mysql();

    await db.getConnection().then((conn) async {
      String sqlQuery =
          'SELECT SUM(Amount) as totalamount FROM data1 where Type = "Income" ';
      String sqlQuery2 =
          'SELECT SUM(Amount) as totalamount FROM data1 where Type = "Expense" ';
      await conn.query(sqlQuery).then((value) {
        for (var row in value) {
          totalIncome = row[0] as double;
        }
      }).onError((error, stackTrace) {
        print(error);
      });
      await conn.query(sqlQuery2).then((value) {
        for (var row in value) {
          totalExpense = row[0] as double;
        }
      }).onError((error, stackTrace) {
        print(error);
      });
    });
  }

  Future<List> listsqldata() async {
    List data = [];
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      String sqlQuery = 'Select * from data1';
      await conn.query(sqlQuery).then((value) {
        for (var row in value) {
          Map<String, Object> _temp = {
            "label": row[0].toString(),
            "amount": row[1],
            "type": row[2],
            "date": row[3],
            "time": row[4],
            "option": row[5],
            "id": row[6],
          };
          data.add(_temp);
        }
      }).onError((error, stackTrace) {
        print(error);
      });
    });
    return data;
  }

  // Future<void> updateSQLData() async {
  //   final Mysql db = Mysql();
  //   await db.getConnection().then((conn) async {
  //     String sqlQuery = 'Select * from data1';
  //     await conn.query(sqlQuery).then((value) {
  //       for (var res in value) {
  //         Map<String, Object> _temp = {
  //           "label": res[0],
  //           "amount": res[1],
  //           "type": res[2],
  //           "date": res[3],
  //           "time": res[4],
  //           "option": res[5],
  //           "id": res[6],
  //         };
  //         data.add(_temp);
  //       }
  //     }).onError((error, stackTrace) {
  //       print(error);
  //       return null;
  //     });
  //   });
  // }

  Future<void> Delete(int id) async {
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      String sqlQuery = 'delete from data1 where id = ? ';
      conn.query(sqlQuery, [id]);
    }).onError((error, stackTrace) {
      print(error);
    });
    update();

  }

  Future<void> getLenght() async {
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      String sqlQuery = 'SELECT COUNT(*) as length FROM data1;';
      await conn.query(sqlQuery).then((value) {
        for (var row in value) {
          totallength = row[0] as int;
        }
      }).onError((error, stackTrace) {
        print(error);
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }
  Future<void> insertData(_label, _amount, type, _option) async {
    List dat = await listsqldata();
    int newid = Random().nextInt(199999999);

    final db = Mysql();
    db.getConnection().then((conn) {
      String sqlQuery =
          'insert into data1 (label, Amount, Type, Date, Time, PaymentOption, id) values (?, ?, ?, ?, ?, ?, ?)';
      conn.query(
          sqlQuery, [_label, double.parse(_amount.toString()), type, Date, Time, _option, newid]);
      print("Data Added");
    });
    update();

  }

  @override
  void onInit() async{
    getLenght();
    stateTotals();
    super.onInit();
  }

  Future<void> updateData() async{

  }

}
