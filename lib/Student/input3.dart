import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api_connection/api_connection.dart';

class input3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: demo(),
    );
  }
}
class demo extends StatefulWidget {
  @override
  Student createState() => Student();
}

class Student extends State<demo> {

  TextEditingController Controller1 = new TextEditingController();
  TextEditingController Controller2 = new TextEditingController();
  TextEditingController Controller3 = new TextEditingController();
  bool visible = false;

  InsertData() async {
    _student insertModel = _student(
      Controller1.text.trim(),
      Controller2.text.trim(),
      Controller3.text.trim(),
    );

    try {
      await http.post(
        Uri.parse(API.insert3),
        body: insertModel.toJson(),
      );
    }
    catch (e) {
      print("error");
    }

  }

  updateData() async {
    _student updateModel = _student(
      Controller1.text.trim(),
      Controller2.text.trim(),
      Controller3.text.trim(),
    );

    try {
      await http.post(
        Uri.parse(API.update3),
        body: updateModel.toJson(),
      );
    }
    catch (e) {
      print("error");
    }

  }

  deleteData() async {
    _student deleteModel = _student(
      Controller1.text.trim(),
      Controller2.text.trim(),
      Controller3.text.trim(),
    );

    try {
      await http.post(
        Uri.parse(API.delete3),
        body: deleteModel.toJson(),
      );
    }
    catch (e) {
      print("error");
    }
  }

  Future<List> selectData() async {
    var res = await http.get(Uri.parse(API.search3));
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
                      labelText: '學號',
                      hintText: '請輸入學號'
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                TextField(
                  controller: Controller2,
                  decoration: InputDecoration(
                      labelText: '姓名',
                      hintText: '請輸入姓名'
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: Controller3,
                  decoration: InputDecoration(
                      labelText: '系碼',
                      hintText: '請輸入系碼'
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
                                '         '+data![index]['學號'].toString() +
                                    '         '+data![index]['姓名'].toString() +
                                    '         '+data![index]['系碼'].toString(),
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

class _student{
  String number;
  String name;
  String id;

  _student(
      this.number,
      this.name,
      this.id,
      );

  Map<String, dynamic> toJson() =>
      {
        'number' : number,
        'name' : name,
        'id' : id,
      };
}