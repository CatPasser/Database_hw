import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api_connection/api_connection.dart';

class input2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: demo(),
    );
  }
}
class demo extends StatefulWidget {
  @override
  Course createState() => Course();
}

class Course extends State<demo> {

  TextEditingController Controller1 = new TextEditingController();
  TextEditingController Controller2 = new TextEditingController();
  TextEditingController Controller3 = new TextEditingController();
  bool visible = false;

  InsertData() async {
    _course insertModel = _course(
      Controller1.text.trim(),
      Controller2.text.trim(),
      Controller3.text.trim(),
    );

    try {
      await http.post(
        Uri.parse(API.insert2),
        body: insertModel.toJson(),
      );
    }
    catch (e) {
      print("error");
    }

  }

  updateData() async {
    _course updateModel = _course(
      Controller1.text.trim(),
      Controller2.text.trim(),
      Controller3.text.trim(),
    );

    try {
      await http.post(
        Uri.parse(API.update2),
        body: updateModel.toJson(),
      );
    }
    catch (e) {
      print("error");
    }

  }

  deleteData() async {
    _course deleteModel = _course(
      Controller1.text.trim(),
      Controller2.text.trim(),
      Controller3.text.trim(),
    );

    try {
      await http.post(
        Uri.parse(API.delete2),
        body: deleteModel.toJson(),
      );
    }
    catch (e) {
      print("error");
    }
  }

  Future<List> selectData() async {
    var res = await http.get(Uri.parse(API.search2));
    var json = jsonDecode(res.body);
    return json;
  }

  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.only(top: 50, left: 10, right: 10),
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            color: Colors.grey.shade300,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: Controller1,
                  decoration: InputDecoration(
                      labelText: '課號',
                      hintText: '請輸入課號'
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                TextField(
                  controller: Controller2,
                  decoration: InputDecoration(
                      labelText: '課名',
                      hintText: '請輸入課名'
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: Controller3,
                  decoration: InputDecoration(
                      labelText: '學分數',
                      hintText: '請輸入學分數'
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: Text(
                          '新增', style: TextStyle(color: Colors.black),),
                        onPressed: () {
                          InsertData();
                        }
                    ),
                    ElevatedButton(
                        child: Text(
                          '修改', style: TextStyle(color: Colors.black),),
                        onPressed: () {
                          updateData();
                        }
                    ),
                    ElevatedButton(
                        child: Text(
                          '刪除', style: TextStyle(color: Colors.black),),
                        onPressed: () {
                          deleteData();
                        }
                    ),
                    ElevatedButton(
                        child: Text(
                          '查詢', style: TextStyle(color: Colors.black),),
                        onPressed: () {
                          setState(() {
                            visible = true;
                          });
                        }
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Visibility(
                  visible: visible,
                  child: FutureBuilder<List>(
                    future: selectData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List? data = snapshot.data;
                        return ListView.builder(
                            itemCount: data?.length,
                            itemBuilder: (context, index) {
                              return Text(
                                '         '+data![index]['課號'].toString() +
                                    '         '+data![index]['課名'].toString() +
                                    '         '+data![index]['學分數'].toString(),
                                style: TextStyle(color: Colors.white,fontSize:18),
                              );
                            }
                        );
                      }
                      else if (snapshot.hasError) return Text("無資料");
                      return Text("");
                    },
                  )
              )
          ),
        ]
    );
  }
}

class _course{
  String number;
  String name;
  String score;

  _course(
      this.number,
      this.name,
      this.score,
      );

  Map<String, dynamic> toJson() =>
      {
        'number' : number,
        'name' : name,
        'score' : score,
      };
}


