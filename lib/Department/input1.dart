import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api_connection/api_connection.dart';

class input1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: demo(),
    );
  }
}
class demo extends StatefulWidget {
  @override
  Department createState() => Department();
}

class Department extends State<demo> {

  TextEditingController Controller1 = new TextEditingController();
  TextEditingController Controller2 = new TextEditingController();
  TextEditingController Controller3 = new TextEditingController();
  bool visible = false;

  InsertData() async {
    _department insertModel = _department(
      Controller1.text.trim(),
      Controller2.text.trim(),
      Controller3.text.trim(),
    );

    try {
      await http.post(
        Uri.parse(API.insert1),
        body: insertModel.toJson(),
      );
    }
    catch (e) {
      print("error");
    }

  }

  updateData() async {
    _department updateModel = _department(
      Controller1.text.trim(),
      Controller2.text.trim(),
      Controller3.text.trim(),
    );

    try {
      await http.post(
        Uri.parse(API.update1),
        body: updateModel.toJson(),
      );
    }
    catch (e) {
      print("error");
    }

  }

  deleteData() async {
    _department deleteModel = _department(
      Controller1.text.trim(),
      Controller2.text.trim(),
      Controller3.text.trim(),
    );

    try {
      await http.post(
        Uri.parse(API.delete1),
        body: deleteModel.toJson(),
      );
    }
    catch (e) {
      print("error");
    }
  }

  Future<List> selectData() async {
      var res = await http.get(Uri.parse(API.search1));
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
                      labelText: '??????',
                      hintText: '????????????(4???)???:D001'
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                TextField(
                  controller: Controller2,
                  decoration: InputDecoration(
                      labelText: '??????',
                      hintText: '???????????????'
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: Controller3,
                  decoration: InputDecoration(
                      labelText: '?????????',
                      hintText: '???????????????'
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: Text(
                          '??????', style: TextStyle(color: Colors.black),),
                        onPressed: () {
                          InsertData();
                        }
                    ),
                    ElevatedButton(
                        child: Text(
                          '??????', style: TextStyle(color: Colors.black),),
                        onPressed: () {
                          updateData();
                        }
                    ),
                    ElevatedButton(
                        child: Text(
                          '??????', style: TextStyle(color: Colors.black),),
                        onPressed: () {
                          deleteData();
                        }
                    ),
                    ElevatedButton(
                        child: Text(
                          '??????', style: TextStyle(color: Colors.black),),
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
                        '         '+data![index]['??????'].toString() +
                        '         '+data![index]['??????'].toString() +
                        '         '+data![index]['?????????'].toString(),
                        style: TextStyle(color: Colors.white,fontSize:18),
                      );
                    }
                  );
                }
                else if (snapshot.hasError) return Text("?????????");
                return Text("");
                  },
                )
            )
          ),
        ]
    );
  }
}

class _department{
  String number;
  String name;
  String director;

  _department(
      this.number,
      this.name,
      this.director,
      );

  Map<String, dynamic> toJson() =>
      {
        'number' : number,
        'name' : name,
        'director' : director,
      };
}


