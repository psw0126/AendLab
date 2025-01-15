import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../router/routes_module.dart';

class BuyPage extends StatefulWidget {
  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {

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
                              child: Text('매입 메뉴', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ) : Pda == false && Phone == true ? Container(
                              margin: EdgeInsets.symmetric(vertical: 30),
                              child: Text('매입 메뉴', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                            ) : Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: Text('매입 메뉴', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            );
                          },
                        )
                    ),
                    Middle(),
                  ],
                ),
              ),
            )
        )
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

Widget Middle() {
  return FutureBuilder(
    future: Access(),
    builder: (context, snapshot) {
      if(snapshot.data == null) {
        return NetMiddle();
      }
      else {
        return snapshot.data == "3" ? Container(
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
                      child: Text('외상매입', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                    ),
                    onTap: (){
                      Modular.to.pushNamed(RouteMap.CREDIT.page);
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
                      child: Text('외상반품', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                    ),
                    onTap: (){
                      Modular.to.pushNamed(RouteMap.CREDIT_RETURN.page);
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
                      child: Text('현금매입', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                    ),
                    onTap: (){
                      Modular.to.pushNamed(RouteMap.CASH_BUY.page);
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
                      child: Text('현금반품', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                    ),
                    onTap: (){
                      Modular.to.pushNamed(RouteMap.CASH_RETURN.page);
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
                      child: Text('점간매입', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                    ),
                    onTap: (){
                      Modular.to.pushNamed(RouteMap.STORE_BUY.page);
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
                      child: Text('점간이동', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                    ),
                    onTap: (){
                      Modular.to.pushNamed(RouteMap.STORE_POINT.page);
                    },
                  ),
                ],
              ),
            ],
          ),
        ) : AesMiddle();
      }
    },
  );
}

Widget AesMiddle() {
  return Container(
    height: 400,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                child: Text('외상매입', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
              ),
              onTap: (){
                Modular.to.pushNamed(RouteMap.CREDIT.page);
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
                child: Text('현금매입', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
              ),
              onTap: (){
                Modular.to.pushNamed(RouteMap.CASH_BUY.page);
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
                child: Text('점간매입', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
              ),
              onTap: (){
                Modular.to.pushNamed(RouteMap.STORE_BUY.page);
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
                child: Text('점간이동', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
              ),
              onTap: (){
                Modular.to.pushNamed(RouteMap.STORE_POINT.page);
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Widget NetMiddle() {
  return Container(
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
                child: Text('외상매입', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
              ),
              onTap: (){
                Modular.to.pushNamed(RouteMap.CREDIT.page);
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
                child: Text('외상반품', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
              ),
              onTap: (){
                Modular.to.pushNamed(RouteMap.CREDIT_RETURN.page);
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
                child: Text('현금매입', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
              ),
              onTap: (){
                Modular.to.pushNamed(RouteMap.CASH_BUY.page);
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
                child: Text('현금반품', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
              ),
              onTap: (){
                Modular.to.pushNamed(RouteMap.CASH_RETURN.page);
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
                child: Text('점간매입', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
              ),
              onTap: (){
                Modular.to.pushNamed(RouteMap.STORE_BUY.page);
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
                child: Text('점간이동', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
              ),
              onTap: (){
                Modular.to.pushNamed(RouteMap.STORE_POINT.page);
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Future Access() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  var result = await (Connectivity().checkConnectivity());
  String? status;
  if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
    status = pref.getString('access_type');
  }
  return status;
}

