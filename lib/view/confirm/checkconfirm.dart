
import 'dart:convert';

import 'package:aendlab/router/routes_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CheckConfirmPage extends StatefulWidget {
  @override
  _CheckConfirmPageState createState() => _CheckConfirmPageState();
}

class _CheckConfirmPageState extends State<CheckConfirmPage> {
  TextEditingController CodeController = TextEditingController();
  List<dynamic> _valueList = [];
  var barcode;
  String URL = '';
  @override
  void initState() {
    confirm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return _onBackPressd();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: _size.height,
              width: _size.width,
              decoration: BoxDecoration(
                color: Color(0xffFFFFF),
              ),
              child: Column(
                children: [
                  Header(),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 30),
                      child: Text('상품목록', style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        Text('바코드', style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            width: _size.width * 0.625,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xff43A047),
                                    width: 3),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child:
                            FutureBuilder(
                              future: Barcode(),
                              builder: (context, snapshot) {
                                return snapshot.data == null ? Text('불러오는중',style: TextStyle(fontSize: 20)) : Text('${barcode}',style: TextStyle(fontSize: 20));
                              },
                            // barcode == null ? Text('불러오는중',style: TextStyle(fontSize: 20)) : Text('${barcode}',style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Middle(context)
                ],
              ),
            ),
          ),
        ),
      ),
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
              pref.remove('barcode');
              Modular.to.pop();
            }
          ),
          InkWell(
            child: Text('로그아웃', style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),),
            onTap: () =>
                Modular.to.pushNamedAndRemoveUntil(
                    RouteMap.LOGIN.page, (route) => false),
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
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('상품명', style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.bold)),
                Text('구입단가', style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.bold)),
                Text('판매가', style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          for(int i = 0; i < _valueList.length; i++)
          Column(
            children: [
              Container(
                width: _size.width,
                height: 2.5,
                color: Color(0xff119144),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_valueList[i]['itm_name'].toString(), style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold)),
                  Text(_valueList[i]['itm_ppbc'].toString()+'원', style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold)),
                  Text(_valueList[i]['itm_spea'].toString()+'원', style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Future Barcode() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    barcode = pref.getString('barcode');
    return pref.getString('barcode');
  }

  Future<void> confirm() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    if(pref.getInt('length') != 0 && pref.getString('URL') != null){
      URL = pref.getString('URL')!;
    } else {
      URL = pref.getString('exist')!;
    }


    var params = {
      'user_id': pref.getString('user_id'),
      'str_code': '001',
      'barcode': pref.getString('barcode'),
    };

    http.Response response = await http.get(Uri.http(URL, 'v1/item/list', params),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "bearer ${pref.getString('access_token')}"
        }
    );
    var decodeResponse = jsonDecode(utf8.decode(response.bodyBytes));

    setState(() {
      this._valueList = decodeResponse;
      this.barcode = pref.getString('barcode');
      print('확인');
      print(barcode);
      print(_valueList);
    });
  }
}

Future<bool> _onBackPressd() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  pref.remove('barcode');
  return true;
}