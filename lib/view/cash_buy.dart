
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../router/routes_module.dart';

class CashBuyPage extends StatefulWidget {
  String CashBuyType = '';
  CashBuyPage({Key? key, required this.CashBuyType}) : super(key: key);

  @override
  _CashBuyPageState createState() => _CashBuyPageState();
}

class _CashBuyPageState extends State<CashBuyPage> {

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
                            child: Text('현금매입 메뉴', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          ) : Pda == false && Phone == true ? Container(
                            margin: EdgeInsets.symmetric(vertical: 30),
                            child: Text('현금매입 메뉴', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                          ) : Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Text('현금매입 메뉴', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          );
                        },
                      )
                  ),
                  // Container(
                  //     margin: EdgeInsets.symmetric(vertical: 30),
                  //     child: Text('현금매입 메뉴', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
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
                      pref.setString('CashBuyType', widget.CashBuyType);
                      print('확인');
                      print(pref.getString('CashBuyType'));
                      Modular.to.pushNamed(RouteMap.CASH_BUY_ENTER.page);
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
                      pref.setString('CashBuyType', widget.CashBuyType);
                      print('확인');
                      print(pref.getString('CashBuyType'));
                      Modular.to.pushNamed(RouteMap.CASH_BUY_CHECK.page);
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