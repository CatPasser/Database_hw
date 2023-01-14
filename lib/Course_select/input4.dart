import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api_connection/api_connection.dart';

class input4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: demo(),
    );
  }
}
class demo extends StatefulWidget {
  @override
  Course_select createState() => Course_select();
}

class Course_select extends State<demo> {

  var _value = null;
  var number = null;
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;
  bool check4 = false;
  bool check5 = false;
  bool visible = false;

  InsertData() async {

    _select insertModel = _select(
      (check1 == true)? '1' : '0',
      (check2 == true)? '1' : '0',
      (check3 == true)? '1' : '0',
      (check4 == true)? '1' : '0',
      (check5 == true)? '1' : '0',
      number,
    );

    try {
      await http.post(
        Uri.parse(API.insert4),
        body: insertModel.toJson(),
      );
    }
    catch (e) {
      print("error");
    }

  }

  DeleteData() async {

    _select insertModel = _select(
      (check1 == true)? '1' : '0',
      (check2 == true)? '1' : '0',
      (check3 == true)? '1' : '0',
      (check4 == true)? '1' : '0',
      (check5 == true)? '1' : '0',
      number,
    );

    try {
      await http.post(
        Uri.parse(API.delete4),
        body: insertModel.toJson(),
      );
    }
    catch (e) {
      print("error");
    }

  }

  Future<List> selectData() async {
    var res = await http.get(Uri.parse(API.search4));
    var json = jsonDecode(res.body);
    return json;
  }

  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            color: Colors.grey.shade300,
            child: Column(
              children: <Widget>[
                DropdownButton(
                    value: _value,
                    hint: Text("學號/姓名"),
                    items: [
                      DropdownMenuItem(child: Text("S0001 一心"),value: 1,),
                      DropdownMenuItem(child: Text("S0002 二聖"),value: 2,),
                      DropdownMenuItem(child: Text("S0003 三多"),value: 3,),
                      DropdownMenuItem(child: Text("S0004 四維"),value: 4,),
                      DropdownMenuItem(child: Text("S0005 五福"),value: 5,),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value!;
                        switch(value){
                          case 1:
                            number = "S0001";
                            break;
                          case 2:
                            number = "S0002";
                            break;
                          case 3:
                            number = "S0003";
                            break;
                          case 4:
                            number = "S0004";
                            break;
                          case 5:
                            number = "S0005";
                            break;
                        }

                      });
                    }),
                CheckboxListTile(
                  value: check1,
                  selected: false,
                  title: Text("C001 資料庫系統 學分數: 4"),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (isCheck){
                    setState(() {
                      check1 = isCheck!;
                    });
                  },
                ),
                CheckboxListTile(
                  value: check2,
                  selected: false,
                  title: Text("C002  手機程式    學分數: 4"),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (isCheck){
                    setState(() {
                      check2 = isCheck!;
                    });
                  },
                ),
                CheckboxListTile(
                  value: check3,
                  selected: false,
                  title: Text("C003 機器人程式 學分數: 3"),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (isCheck){
                    setState(() {
                      check3 = isCheck!;
                    });
                  },
                ),
                CheckboxListTile(
                  value: check4,
                  selected: false,
                  title: Text("C004 物聯網技術 學分數: 4"),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (isCheck){
                    setState(() {
                      check4 = isCheck!;
                    });
                  },
                ),
                CheckboxListTile(
                  value: check5,
                  selected: false,
                  title: Text("C005 大數據分析 學分數: 3"),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (isCheck){
                    setState(() {
                      check5 = isCheck!;
                    });
                  },
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: Text(
                          '加選', style: TextStyle(color: Colors.black),),
                        onPressed: () {
                          InsertData();
                        }
                    ),
                    ElevatedButton(
                        child: Text(
                          '退選', style: TextStyle(color: Colors.black),),
                        onPressed: () {
                          DeleteData();
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
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
              height: 200,
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
                                    '         '+data![index]['課號'].toString() +
                                    '         '+data![index]['成績'].toString(),
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
class _select{
  String check1;
  String check2;
  String check3;
  String check4;
  String check5;
  String number;

  _select(
      this.check1,
      this.check2,
      this.check3,
      this.check4,
      this.check5,
      this.number,
      );

  Map<String, dynamic> toJson() =>
      {
        'check1' : check1,
        'check2' : check2,
        'check3' : check3,
        'check4' : check4,
        'check5' : check5,
        'number' : number,
      };
}