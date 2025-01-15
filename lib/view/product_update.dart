import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../router/routes_module.dart';

class ProductUpdatePage extends StatefulWidget {
  @override
  _ProductUpdatePageState createState() => _ProductUpdatePageState();
}

class _ProductUpdatePageState extends State<ProductUpdatePage> {

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
                      margin: EdgeInsets.symmetric(vertical: 30),
                      child: Text('수정 메뉴', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
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
                      child: Text('일반 상품', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                    ),
                    onTap: (){
                      Modular.to.pushNamed(RouteMap.COMMON_UPDATE.page);
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
                      child: Text('박스 상품', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                    ),
                    onTap: (){
                      Modular.to.pushNamed(RouteMap.BOX_UPDATE.page);
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