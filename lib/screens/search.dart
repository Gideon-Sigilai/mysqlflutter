import 'package:mysqlflutter/constants/colors.dart';
import 'package:mysqlflutter/logics/logics.dart';
import 'package:mysqlflutter/logics/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ColorsX xc = ColorsX();

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}


class _SearchState extends State<Search> {
  TextEditingController sks = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        AppBar(
          backgroundColor: xc.primarydark,

        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoSearchTextField(
            onChanged: (value){
              getSQLData(value);
              setState(() {
                sks.text = value;
              });
            },
          ),
        ),
        getDBData(),

      ],),
    );
  }
  Future<List<Model>> getSQLData(String Searchkey) async {
    final List<Model> profilelist = [];
    final Mysql db = Mysql();

    await db.getConnection().then((conn) async {
      String sqlQuery = 'SELECT * FROM data1 WHERE label LIKE "%${sks.text.toString()}%" ;';
      await conn.query(sqlQuery).then((value) {
        //Texts = value.toString();
        for (var res in value) {
          final profModel = Model(res["label"].toString(),res["Amount"] ,res["Type"].toString(),res["Date"],res["Time"],res["PaymentOption"].toString(),res["id"],);
          profilelist.add(profModel);
        }
      }).onError((error, stackTrace) {
        print(error);
        return null;
      });
    });
    return profilelist;
  }
  FutureBuilder<List<Model>> getDBData() {
    return FutureBuilder(
        future: getSQLData(sks.text),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Container();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return // Text(Texts);
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        final data = snapshot.data! as List<Model>;
                        return Container(
                          decoration: BoxDecoration(
                            //border: Border.all(),
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(4, 4),
                                    color: Colors.grey.shade700,
                                    blurRadius: 7),
                                BoxShadow(
                                    offset: Offset(-4, -4),
                                    color: Colors.white,
                                    blurRadius: 7),
                              ]),
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(data[i].label.toString()),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                data[i].type.toString() == "Expense" ?
                                Text("- ${data[i].amount.toString()}",style: TextStyle(color: Colors.red) ):
                                Text("+ ${data[i].amount.toString()}",style: TextStyle(color: Colors.green)),
                                SizedBox(height: 5,),
                                Text("Mpesa",style: TextStyle(color: Colors.white,backgroundColor: xc.primarydark),)
                              ],
                            ),
                            // leading: Text(
                            //   data[i].type.toString(),
                            //   style: data[i].type.toString() == "Expense" ? TextStyle(color: Colors.red) : TextStyle(color: Colors.green),
                            // ),
                            subtitle: Row(
                              children: [
                                Text("Date: "),
                                Text(data[i].date.toString()),
                                Text(" Time: "),
                                Text(data[i].time.toString()),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              );
            // ListView(
            //     children: lsdata(snapshot.data!));

          } else {
            return Container();
          }
        });
  }
}
