import 'package:mysqlflutter/constants/colors.dart';
import 'package:mysqlflutter/controllers/controllers.dart';
import 'package:mysqlflutter/screens/add.dart';
import 'package:mysqlflutter/screens/search.dart';
import 'package:mysqlflutter/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysqlflutter/logics/models.dart';
import 'package:mysqlflutter/logics/logics.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mysqlflutter/screens/edit.dart';

Controller cx = Get.put(Controller());

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

ColorsX xc = ColorsX();

class _HomePageState extends State<HomePage> {
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: xc.grey,
          body: CustomScrollView(
            primary: false,
            slivers: [
              SliverAppBar(
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            cx.stateTotals();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.refresh_outlined,
                            size: 30,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            showDialog(context: context, builder: (context){
                              return Dialog(
                                child: Add(),
                              );
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 30,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            Get.to(() => const Search());
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 30,
                          )),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Get.to(() => Settings());
                    //     },
                    //     child: CircleAvatar(
                    //       backgroundColor: xc.grey,
                    //       child: const Icon(Icons.settings),
                    //     ),
                    //   ),
                    // )
                  ],
                  pinned: true,
                  backgroundColor: xc.primarydark,
                  title: Row(
                    children: [
                      Image.asset("assets/budget.png",fit: BoxFit.fill,height: 35,width: 35,),
                      SizedBox(width: 10,),
                      const Text("Expense Tracker"),
                    ],
                  ),
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      dashboard(),
                    ],
                  ))),
              SliverList(delegate: SliverChildListDelegate([getDBData()]))
            ],
          )),
    );
  }

  Widget dashboard() => Container(
        height: 170,
        width: 300,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: xc.primarydark,
            gradient: LinearGradient(
                colors: [xc.primarydark, xc.primarydark],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(4, 4),
                  color: xc.primaryblack,
                  spreadRadius: 3,
                  blurRadius: 7),
              BoxShadow(
                offset: const Offset(-3, -3),
                color: xc.primary,
                blurRadius: 7,
                spreadRadius: 1,
              )
            ]),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Hello Gideon,",
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/financial-profit.png",fit: BoxFit.fill,height: 35,width: 35,),
                ),
                // CircleAvatar(
                //   child: const Icon(
                //     Icons.money,
                //   ),
                //   backgroundColor: xc.primaryblack,
                // ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Account Balance: ",
                  style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                    "${cx.totalIncome.toDouble() - cx.totalExpense.toDouble()}",
                    style: GoogleFonts.inconsolata(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Colors.white),
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Income",
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.white)),
                     Text(
                            "${cx.totalIncome.toDouble()}",
                            style: GoogleFonts.inconsolata(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                color: Colors.white),
                          )
                    ],
                  ),
                  const VerticalDivider(
                    color: Colors.white38,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Expense",
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.white)),
                      Text(
                          "${cx.totalExpense.toDouble()}",
                          style: GoogleFonts.inconsolata(
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color: Colors.white),
                        ),

                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget getDBData() {
    return FutureBuilder(
        future: cx.listsqldata(),
        builder: (context, snapshot) {
          return ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                final data = snapshot.data!;

                return InkWell(
                  onTap: () {
                    cx.id = data[i]["id"];
                    Get.to(() => const Update());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        //border: Border.all(),
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(4, 4),
                              color: Colors.grey.shade700,
                              blurRadius: 7),
                          const BoxShadow(
                              offset: Offset(-4, -4),
                              color: Colors.white,
                              blurRadius: 7),
                        ]),
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(data[i]["label"].toString()),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          data[i]["type"].toString() == "Expense"
                              ? Text("- ${data[i]["amount"]}",
                                  style: const TextStyle(color: Colors.red))
                              : Text("+ ${data[i]["amount"]}",
                                  style: const TextStyle(color: Colors.green)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            data[i]["option"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                backgroundColor: xc.primarydark),
                          )
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          const Text("Date: "),
                          Text(data[i]["date"]),
                          const Text(" Time: "),
                          Text(data[i]["time"]),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
