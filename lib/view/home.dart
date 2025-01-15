
import 'package:aendlab/router/routes_module.dart';
import 'package:aendlab/wiget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      resizeToAvoidBottomInset : false,
      body: SafeArea(
        child: Container(
          width: _size.width,
          decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Logout(),
                Container(
                  child: FutureBuilder(
                    future: _Mode(),
                    builder: (context, snapshot) {
                      return Pda == true && Phone == false ? Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Text('메뉴', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ) : Pda == false && Phone == true ? Container(
                        margin: EdgeInsets.symmetric(vertical: 30),
                        child: Text('메뉴', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                      ) : Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Text('메뉴', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      );
                    },
                  )
                ),
                Container(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: 150,
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
                              child: Text('매입', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                            ),
                            onTap: () async {
                              final SharedPreferences pref = await SharedPreferences.getInstance();
                              print('확인');
                              print(pref.getString('login_ID'));
                              Modular.to.pushNamed(RouteMap.BUY.page);
                            },
                          ),
                          InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: 150,
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
                              child: Text('재고', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                            ),
                            onTap: (){
                              Modular.to.pushNamed(RouteMap.INVENTORY.page);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: 150,
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
                              child: Text('발주', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                            ),
                            onTap: (){
                              Modular.to.pushNamed(RouteMap.ORDER.page);
                            },
                          ),
                          InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: 150,
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
                            onTap: (){
                              Modular.to.pushNamed(RouteMap.CHECK.page);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: 150,
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
                              child: Text('기타', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                            ),
                            onTap: (){
                              Modular.to.pushNamed(RouteMap.ETC.page);
                            },
                          ),
                          InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: 150,
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
                              child: Text('수정', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                            ),
                            onTap: (){
                              Modular.to.pushNamed(RouteMap.PRODUCT_UPDATE.page);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget Logout(){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    alignment: Alignment.centerRight,
    child: InkWell(
        child: Text('로그아웃', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),),
      onTap: () => Modular.to.pushNamedAndRemoveUntil(RouteMap.LOGIN.page, (route) => false),
    ),
  );
}


