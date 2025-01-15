import 'dart:async';
import 'dart:io';

import 'package:aendlab/router/routes_module.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dialog/alert.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  StreamSubscription? connection;
  bool isoffline = false;

  @override
  void initState(){
    // super.initState();
    // _barcodeValue();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkConnectionStatus(),
      builder: (context, snapshot) {
        if(snapshot.data == ConnectivityResult.wifi || snapshot.data == ConnectivityResult.mobile){
          Timer(Duration(seconds: 3), () async {
            Modular.to.popAndPushNamed(RouteMap.LOGIN.page);
          });
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              color: Color(0xff4FC9DE),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('AENDLAB', style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              color: Color(0xff4FC9DE),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomAlert("오프라인으로 진행하시겠습니까?", "확인", onTap: () => Modular.to.pushNamed(RouteMap.HOME.page)),
                ],
              ),
            ),
          );
          // return
        }
      },
    );
    // FutureBuilder(
    //   future: checkConnectionStatus(),
    //   builder: (context, AsyncSnapshot snapshot) {
    //     if(snapshot.data != ConnectivityResult.none){
    //       return
    //     } else {
    //       return CustomAlert("오프라인으로 진행하시겠습니까?", "확인", onTap: () => Modular.to.pushNamed(RouteMap.HOME.page));
    //     }
    //   },
    // );
    Timer(Duration(seconds: 3), () {
      Modular.to.pushReplacementNamed(RouteMap.LOGIN.page);
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Color(0xff4FC9DE),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('AENDLAB', style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

// Future<void> _autoLogin(context) async {
//   String page = RouteMap.LOGIN.page;
//   Preference? p = await loadPreference();
//   if (p != null && p.isAutoLogin == true) {
//       page = RouteMap.HOME.page;
//     }
//   Modular.to.pushReplacementNamed(page);
// }

}

Future checkConnectionStatus() async {
  var result = await (Connectivity().checkConnectivity());
  if (result == ConnectivityResult.none) {
    throw new SocketException("인터넷 연결 상태를 확인해 주세요.");
  }
  return result;  // wifi, mobile
}