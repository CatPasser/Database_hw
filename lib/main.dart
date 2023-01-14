import 'package:flutter/material.dart';
import 'Department/input1.dart';
import 'Course/input2.dart';
import 'Student/input3.dart';
import 'Course_select/input4.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('選課系統'),
          centerTitle: true,
          backgroundColor: Colors.green[500],
        ),
        body: DefaultTabController(
            length: 4,
            child: Column(
              children: [
                Container(
                  child: TabBar(
                    labelColor: Colors.black,
                    tabs: [
                      Tab(text: "科系管理",),
                      Tab(text: "課程管理",),
                      Tab(text: "學生管理",),
                      Tab(text: "選課作業",),
                    ],
                  ),
                ),
                Container(
                    child: Expanded(
                      child: TabBarView(
                        children: [
                          input1(),
                          input2(),
                          input3(),
                          input4(),
                        ],
                      ),
                    )
                )
              ],
            )
        )
        ),
      );
  }
}

