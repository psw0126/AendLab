import 'dart:convert';

import 'package:aendlab/router/routes_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';


class CreditTransPage extends StatefulWidget {
  @override
  _CreditTransPageState createState() => _CreditTransPageState();
}

class _CreditTransPageState extends State<CreditTransPage> {
  List<dynamic> _handList = [];
  List<dynamic> _value = [];
  var f = NumberFormat('###,###,###,###,###,###,###');
  int ter_qty = 0;
  int ter_ppbc = 0;
  int ter_spea = 0;
  String URL = '';
  bool? Phone;
  bool? Pda;


  @override
  void initState() {
    Handlist();
    super.initState();
    // _barcodeValue();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: _size.width,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                ),
                child: Column(
                  children: [
                    Header(),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 30),
                        child: FutureBuilder(
                          future: Title(),
                          builder: (context, snapshot) {
                            return snapshot.data == null ? Text('미선택', style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),) : Text('${snapshot.data}', style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),);
                          },
                        )
                    ),
                    Middle(context),
                    SizedBox(height: 30),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 50,
                        width: _size.width,
                        decoration: BoxDecoration(
                            color: Color(0xff119144),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10.0,
                                color: Colors.grey.withOpacity(0.7),
                                offset: Offset(0, 6),
                              )
                            ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('메뉴로 돌아가기', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white)),
                          ],
                        ),
                      ),
                      onTap: () =>
                          Modular.to.pushNamedAndRemoveUntil(
                              RouteMap.HOME.page, (route) => false),
                    )
                  ],
                ),
              ),
            )
        )
    );
  }


  Widget Header() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Icon(Icons.arrow_back_ios_new, size: 35),
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove("date");
              pref.remove("CreditTitle");
              pref.remove("ter_vencd");
              Modular.to.pop();
            }
          ),
          InkWell(
            child: Text('로그아웃', style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),),
            onTap: () =>
              Modular.to.pushNamedAndRemoveUntil(RouteMap.LOGIN.page, (route) => false),
          ),
        ],
      ),
    );
  }

  Widget Middle(BuildContext context) {
    Size _size = MediaQuery
        .of(context)
        .size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
            Pda == true && Phone == false ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('순번', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
                Text('바코드', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
                Text('상품명', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
                Text('규격', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
                Text('수량', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
                Text('구입가', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
                Text('판매가', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
              ],
            ) : Pda == false && Phone == true ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('순번', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  Text('바코드', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  Text('상품명', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  Text('규격', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  Text('수량', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  Text('구입가', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  Text('판매가', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                ],
                ) : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('순번', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
                  Text('바코드', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
                  Text('상품명', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
                  Text('규격', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
                  Text('수량', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
                  Text('구입가', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
                  Text('판매가', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text('순번', style: TextStyle(
                //         fontSize: 7, fontWeight: FontWeight.bold)),
                //     Text('바코드', style: TextStyle(
                //         fontSize: 7, fontWeight: FontWeight.bold)),
                //     Text('상품명', style: TextStyle(
                //         fontSize: 7, fontWeight: FontWeight.bold)),
                //     Text('규격', style: TextStyle(
                //         fontSize: 7, fontWeight: FontWeight.bold)),
                //     Text('수량', style: TextStyle(
                //         fontSize: 7, fontWeight: FontWeight.bold)),
                //     Text('구입가', style: TextStyle(
                //         fontSize: 7, fontWeight: FontWeight.bold)),
                //     Text('판매가', style: TextStyle(
                //         fontSize: 7, fontWeight: FontWeight.bold)),
                //   ],
                // ),
                Container(
                  width: _size.width,
                  height: 3,
                  color: Color(0xff119144),
                ),
                Container(
                    height: 250,
                    width: _size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                      for(int i = 0; i < _handList.length; i++)
                          Column(
                            children: [
                              Container(
                                width: _size.width,
                                height: 2.5,
                                color: Color(0xff119144),
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_handList[i]['ter_seq'].toString(), style: TextStyle(fontSize: 10),),
                                  Spacer(),
                                  Text(_handList[i]['ter_code'].toString(), style: TextStyle(fontSize: 10)),
                                  Spacer(),
                                  Text(_handList[i]['ter_name'].toString(), style: TextStyle(fontSize: 10)),
                                  Spacer(),
                                  Text(_handList[i]['ter_spec'].toString(), style: TextStyle(fontSize: 10)),
                                  Spacer(),
                                  Text(_handList[i]['ter_qty'].toString(), style: TextStyle(fontSize: 10)),
                                  Spacer(),
                                  Text(f.format(_handList[i]['ter_ppbc']).toString(), style: TextStyle(fontSize: 10)),
                                  Spacer(),
                                  Text(f.format(_handList[i]['ter_spea']).toString(), style: TextStyle(fontSize: 10)),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                ),
                Container(
                  width: _size.width,
                  height: 3,
                  color: Color(0xff119144),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color(0xff119144)
                        ),
                        child: Center(child: Text('합계', style: TextStyle(
                            color: Colors.white))),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text('수량'),
                            Text('구입가'),
                            Text('판매가'),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(f.format(ter_qty).toString() +'개'),
                            Text(f.format(ter_ppbc).toString()+'원'),
                            Text(f.format(ter_spea).toString()+'원')
                          ],
                        )
                      )
                    ],
                  ),
                )
                // Container(
                //     width: _size.width*0.65,
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         border: Border.all(color: Color(0xff43A047),width: 3),
                //         borderRadius: BorderRadius.circular(20)
                //     ),
                //     child: TextField(
                //       style: TextStyle(fontSize: 20),
                //       decoration: InputDecoration(
                //         border: InputBorder.none,
                //         disabledBorder: InputBorder.none,
                //         enabledBorder: InputBorder.none,
                //       ),
                //     )
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future Title() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    Phone = pref.getBool('Phone');
    Pda = pref.getBool('Pda');
    return pref.getString('CreditTitle');
  }


  Future<void> Handlist() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    DateTime toDay = DateTime.now();
    String date = DateFormat('yyyyMMdd').format(toDay);
    var dateData = pref.getString('date');

    if(pref.getInt('length') != 0 && pref.getString('URL') != null){
      URL = pref.getString('URL')!;
    } else {
      URL = pref.getString('exist')!;
    }


    var params = {
      'user_id': pref.getString('user_id'),
      'str_code': '001',
      'ter_date': dateData == null ? date : pref.getString('date'),
      'ter_type': pref.getString('CreditType'),
      'ter_vencd': pref.getString('ter_vencd') == null ? "null" : pref.getString('ter_vencd'),
    };

    http.Response response = await http.get(Uri.http(
        URL, 'v1/hand/list', params),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "bearer ${pref.getString('access_token')}"
        }
    );
    var decodeResponse = jsonDecode(utf8.decode(response.bodyBytes));

    print('데이터 확인');
    print(decodeResponse);
    print(pref.getString('ter_vencd'));
    setState(() {
      _handList = decodeResponse;
      for (var element in _handList) {
        ter_qty += element['ter_qty'] as int;
        ter_ppbc += element['ter_ppbc'] * element['ter_qty'] as int;
        ter_spea += element['ter_spea'] * element['ter_qty'] as int;
      }
      print(ter_qty);
      print(ter_ppbc);
      print(ter_spea);
    });
  }
}