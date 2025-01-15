
import 'package:aendlab/router/routes_module.dart';
import 'package:aendlab/wiget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EtcPage extends StatefulWidget {
  @override
  _EtcPageState createState() => _EtcPageState();
}

class _EtcPageState extends State<EtcPage> {

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Header(),
                Container(
                    child: FutureBuilder(
                      future: _Mode(),
                      builder: (context, snapshot) {
                        return Pda == true && Phone == false ? Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: Text('기타정보관리', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ) : Pda == false && Phone == true ? Container(
                          margin: EdgeInsets.symmetric(vertical: 30),
                          child: Text('기타정보관리', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                        ) : Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: Text('기타정보관리', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        );
                      },
                    )
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 30),
                //   child: Text('기타정보관리', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                // ),
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
                              child: Text('바코드', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                            ),
                            onTap: () async {
                              Modular.to.pushNamed(RouteMap.BARCODE.page);
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
                              child: Text('창고입고', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                            ),
                            onTap: () {
                              Modular.to.pushNamed(RouteMap.STORAGE_IN.page);
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
                              child: Text('행사', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                            ),
                            onTap: (){
                              Modular.to.pushNamed(RouteMap.EVENT.page);
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
                              child: Text('창고출고', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                            ),
                            onTap: (){
                              Modular.to.pushNamed(RouteMap.STORAGE_OUT.page);
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
                              child: Text('매출등록', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                            ),
                            onTap: (){
                              Modular.to.pushNamed(RouteMap.SALES_INSERT_ENTER.page);
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
                              child: Text('매출반품', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                            ),
                            onTap: (){
                              Modular.to.pushNamed(RouteMap.SALES_INSERT_RETURN.page);
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
