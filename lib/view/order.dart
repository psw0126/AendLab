import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../router/routes_module.dart';
import 'package:http/http.dart' as http;

class OrderPage extends StatefulWidget {
  String OrderType = '';
  OrderPage({Key? key, required this.OrderType}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  bool? Phone;
  bool? Pda;

  Future _Mode() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    Phone = pref.getBool('Phone');
    Pda = pref.getBool('Pda');
    return true;
  }

  @override
  void initState() {
    _Mode();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: _size.width,
          decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
          ),
          child: Column(
            children: [
              Header(),
              Column(
                children: [
                  Container(
                      child: FutureBuilder(
                        future: _Mode(),
                        builder: (context, snapshot) {
                          return Pda == true && Phone == false ? Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Text('발주 메뉴', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          ) : Pda == false && Phone == true ? Container(
                            margin: EdgeInsets.symmetric(vertical: 30),
                            child: Text('발주 메뉴', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                          ) : Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Text('발주 메뉴', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          );
                        },
                      )
                  ),
                  // Container(
                  //     margin: EdgeInsets.symmetric(vertical: 30),
                  //     child: Text('발주 메뉴', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                  // ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      alignment: Alignment.center,
                      height: 100,
                      width: _size.width,
                      decoration: BoxDecoration(
                          color: Color(0xff119144),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.0,
                              color: Colors.grey.withOpacity(0.7),
                              offset: Offset(0,6),
                            ),
                          ]
                      ),
                      child: Text('입력', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                    ),
                    onTap: () async {
                      final SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.setString('OrderType', widget.OrderType);
                      print('확인');
                      print(pref.getString('OrderType'));
                      Modular.to.pushNamed(RouteMap.ORDERENTER.page);
                    },
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      alignment: Alignment.center,
                      height: 100,
                      width: _size.width,
                      decoration: BoxDecoration(
                          color: Color(0xff119144),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.0,
                              color: Colors.grey.withOpacity(0.7),
                              offset: Offset(0,6),
                            ),
                          ]
                      ),
                      child: Text('조회', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                    ),
                    onTap: () async {
                      final SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.setString('OrderType', widget.OrderType);
                      print('확인');
                      print(pref.getString('OrderType'));
                      Modular.to.pushNamed(RouteMap.ORDERCHECK.page);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Widget Header(){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: Icon(Icons.arrow_back_ios_new, size: 35),
          onTap: () => Modular.to.pop(),
        ),
        InkWell(
          child: Text('로그아웃', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),),
          onTap: () => Modular.to.pushNamedAndRemoveUntil(RouteMap.LOGIN.page, (route) => false),
        ),
      ],
    ),
  );
}

// Future Item() async {
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   pref.setString('O', 'O');
//   try{
//     http.Response response = await http.get(Uri.http(
//       'aend.iptime.org:7020', 'v1/ven/svenname', params),
//       headers: {
//         "Content-Type": "application/json",
//         "Accept": "application/json",
//         "Authorization": "bearer ${pref.getString('access_token')}"
//       }
//     );
//   }
// }