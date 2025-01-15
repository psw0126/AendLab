import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import '../dialog/alert.dart';
import '../router/routes_module.dart';

class BoxUpdatePage extends StatefulWidget {
  String BoxUpdateType = '';
  BoxUpdatePage({Key? key, required this.BoxUpdateType}) : super(key: key);

  @override
  _BoxUpdatePageState createState() => _BoxUpdatePageState();
}

class _BoxUpdatePageState extends State<BoxUpdatePage> {
  List<dynamic> _valueList = [];
  TextEditingController TercodeController = TextEditingController(); //바코드

  List<dynamic> handvalueList = [];
  var selectTax;
  var Tax;
  var _value;
  var handvalue;
  var f = NumberFormat('###,###,###,###');
  var seq;
  var handseq;
  var accessType;
  var accessOption;
  String URL = '';
  String scanBarcode = '';
  String inputBarcode = '';
  var seqNo = 0;


  final TernameController = TextEditingController(); //상품명
  final TerbqtyController = TextEditingController(); //박스내품수량
  final TerspeaController = TextEditingController(); //판매가
  final TerspebController = TextEditingController(); //행사판매가
  final TerppbcController = TextEditingController(); //구입가
  final TerppccController = TextEditingController(); //행사구입가
  final TerqtyController = TextEditingController(); //수량
  final TerspecController = TextEditingController(); //규격
  final TertaxController = TextEditingController(); //면과세구분
  final TerbcodeController = TextEditingController(); //박스바코드
  final SPEAController = TextEditingController(); //판매가
  final SPEBController = TextEditingController(); //행사판매가
  final PPBController = TextEditingController(); //구입가
  final PPCController = TextEditingController(); //행사구입가
  final TerbqtController = TextEditingController();

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
    // itemList();
    this.PPCController.addListener(() {
      setState(() {});
    });
    this.PPBController.addListener(() {
      setState(() {});
    });
    this.SPEBController.addListener(() {
      setState(() {});
    });
    this.SPEAController.addListener(() {
      setState(() {});
    });
    this.TernameController.addListener(() {
      setState(() {});
    });
    this.TerbqtyController.addListener(() {
      setState(() {});
    });
    this.TerspeaController.addListener(() {
      setState(() {});
    });
    this.TerspebController.addListener(() {
      setState(() {});
    });
    this.TerppbcController.addListener(() {
      setState(() {});
    });
    this.TerppccController.addListener(() {
      setState(() {});
    });
    this.TerqtyController.addListener(() {
      setState(() {});
    });
    this.TerqtyController.addListener(() {
      setState(() {});
    });
    this.TertaxController.addListener(() {
      setState(() {});
    });
    this.TerbcodeController.addListener(() {
      setState(() {});
    });
    this.TerbqtController.addListener(() {
      setState(() {

      });
    });
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
                        child: Text('박스상품 수정', style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),)
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: FutureBuilder(
                                future: _Mode(),
                                builder: (context, snapshot) {
                                  return Pda == true && Phone == false ? Text('바코드', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                                      : Pda == false && Phone == true ? ElevatedButton(
                                    onPressed: ()  {
                                      scanBarcodeNormal();
                                      Future.delayed(Duration(milliseconds: 500), () {
                                        setState(() {
                                          TerppbcController.text = f.format(0).toString();
                                          TerppccController.text = f.format(0).toString();
                                          TerspeaController.text = f.format(0).toString();
                                          TerspebController.text = f.format(0).toString();
                                        });
                                      });
                                    },
                                    child: const Text('바코드'),
                                  ) : Text('바코드', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold));
                                },
                              )
                          ),
                          // ElevatedButton(
                          //   onPressed: () async {
                          //     scanBarcodeNormal();
                          //     Future.delayed(Duration(milliseconds: 500), () {
                          //       setState(() {
                          //         TerppbcController.text = f.format(0).toString();
                          //         TerppccController.text = f.format(0).toString();
                          //         TerspeaController.text = f.format(0).toString();
                          //         TerspebController.text = f.format(0).toString();
                          //       });
                          //     });
                          //   },
                          //   child: const Text('바코드'),
                          // ),
                          SizedBox(width: 10),
                          Container(
                              width: _size.width * 0.45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xff43A047),
                                      width: 3),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Pda == true && Phone == false ? TextField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                controller: TercodeController,
                                style: TextStyle(fontSize: 20),
                                onSubmitted: (value) {
                                  handItemList();

                                },
                                onTap:(){
                                  TercodeController.selection = TextSelection(baseOffset: TercodeController.text.length, extentOffset: 0);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                              ) : Pda == false && Phone == true ? TextField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                controller: TercodeController,
                                style: TextStyle(fontSize: 20),
                                onSubmitted: (value) {
                                  handItemList();

                                },
                                onTap:(){
                                  TercodeController.selection = TextSelection(baseOffset: TercodeController.text.length, extentOffset: 0);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                              ) : TextField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                controller: TercodeController,
                                style: TextStyle(fontSize: 20),
                                onSubmitted: (value) {
                                  handItemList();

                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                              )
                          ),
                          Column(
                            children: [
                              TextButton(
                                child: Text('조회', style: TextStyle(fontSize: 15),),
                                onPressed: () async {
                                  final SharedPreferences pref = await SharedPreferences.getInstance();
                                  pref.setString('barcode', TercodeController.text);
                                  Modular.to.pushNamed(RouteMap.CHECK_CONFIRM.page);
                                },
                              ),
                              // TextButton(
                              //   child: Text('코드조회', style: TextStyle(fontSize: 15),),
                              //   onPressed: () {
                              //     handItemList();
                              //   },
                              // )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('상품명', style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                                Container(
                                    width: _size.width * 0.65,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff43A047), width: 3),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: TextField(
                                      controller: TernameController,
                                      style: TextStyle(fontSize: 20),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('규격', style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                                Container(
                                    width: _size.width * 0.65,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff43A047), width: 3),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: TextField(
                                      controller: TerspecController,
                                      style: TextStyle(fontSize: 20),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('전산재고', style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                                Container(
                                    width: _size.width * 0.65,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff43A047), width: 3),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: TextField(
                                      controller: TerbqtController,
                                      style: TextStyle(fontSize: 20),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        enabled: false,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('면 / 과세', style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                                Pda == true && Phone == false ? SizedBox(width: 0)
                                    : Pda == false && Phone == true ? SizedBox(width: 23)
                                    : SizedBox(width: 0),
                                Container(
                                    width: _size.width * 0.25,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff43A047), width: 3),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField(
                                          padding: EdgeInsets.symmetric(vertical: 13.5),
                                          decoration: InputDecoration.collapsed(hintText: ''),
                                          value: selectTax,
                                          hint: Text('선택'),
                                          onChanged: (value) {
                                            setState(() async {
                                              print(value);
                                              selectTax = value;
                                              SharedPreferences pref = await SharedPreferences.getInstance();
                                              pref.setString('tax', value.toString());
                                            });
                                          },
                                          items: [
                                            DropdownMenuItem(
                                              child: Text('면세'),
                                              value: '0',
                                              onTap: () {
                                                setState(() {
                                                  selectTax = '0';
                                                });
                                              },
                                            ),
                                            DropdownMenuItem(
                                              child: Text('과세'),
                                              value: '1',
                                              onTap: () {
                                                setState(() {
                                                  selectTax = '1';
                                                });
                                              },
                                            )
                                          ]
                                      ),
                                    ),
                                ),
                                Text('수량', style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                                Container(
                                    width: _size.width * 0.25,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff43A047), width: 3),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: TextField(
                                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                      textAlign: TextAlign.right,
                                      controller: TerqtyController,
                                      style: TextStyle(fontSize: 20),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        enabled: false,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('구 입 가', style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                                Pda == true && Phone == false ? SizedBox(width: 15)
                                    : Pda == false && Phone == true ? SizedBox(width: 40)
                                    : SizedBox(width: 15),
                                Container(
                                  width: _size.width * 0.32,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xff43A047), width: 3),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: TextField(
                                    controller: PPBController,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      enabled: false,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: _size.width * 0.32,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xff43A047), width: 3),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: accessOption == "3" ? TerppbcTrue() : accessOption == "2" ? TerppbcFalse() : accessOption == "1" ? TerppbcTrue() : TerppbcFalse()
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('판 매 가', style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                                Pda == true && Phone == false ? SizedBox(width: 15)
                                    : Pda == false && Phone == true ? SizedBox(width: 40)
                                    : SizedBox(width: 15),
                                Container(
                                  width: _size.width * 0.32,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xff43A047), width: 3),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: TextField(
                                    controller: SPEAController,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      enabled: false,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: _size.width * 0.32,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xff43A047), width: 3),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: accessOption == "3" ? TerspeaTrue() : accessOption == "2" ? TerspeaTrue() : accessOption == "1" ? TerspeaFalse() : TerspeaFalse()
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('행사구입가', style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                                Pda == true && Phone == false ? SizedBox(width: 0)
                                    : Pda == false && Phone == true ? SizedBox(width: 20)
                                    : SizedBox(width: 0),
                                Container(
                                  width: _size.width * 0.32,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xff43A047), width: 3),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: TextField(
                                    textAlign: TextAlign.right,
                                    controller: PPCController,
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      enabled: false,
                                    ),
                                  ),
                                ),
                                Pda == true && Phone == false ? Expanded(
                                  child: Container(
                                    width: _size.width * 0.32,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff43A047), width: 3),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: accessOption == "3" ? TerppccTrue() : accessOption == "2" ? TerppccFalse() : accessOption == "1" ? TerppccTrue() : TerppccFalse()
                                  ),
                                ) : Pda == false && Phone == true ? Container(
                                    width: _size.width * 0.32,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff43A047), width: 3),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: accessOption == "3" ? TerppccTrue() : accessOption == "2" ? TerppccFalse() : accessOption == "1" ? TerppccTrue() : TerppccFalse()
                                ) : Container(
                                    width: _size.width * 0.32,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff43A047), width: 3),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: accessOption == "3" ? TerppccTrue() : accessOption == "2" ? TerppccFalse() : accessOption == "1" ? TerppccTrue() : TerppccFalse()
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('행사판매가', style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                                Pda == true && Phone == false ? SizedBox(width: 0)
                                    : Pda == false && Phone == true ? SizedBox(width: 20)
                                    : SizedBox(width: 0),
                                Container(
                                  width: _size.width * 0.32,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xff43A047), width: 3),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: TextField(
                                    textAlign: TextAlign.right,
                                    controller: SPEBController,
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      enabled: false,
                                    ),
                                  ),
                                ),
                                Pda == true && Phone == false ? Expanded(
                                  child: Container(
                                    width: _size.width * 0.32,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff43A047), width: 3),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: accessOption == "3" ? TerspebTrue() : accessOption == "2" ? TerspebTrue() : accessOption == "1" ? TerspebFalse() : TerspebFalse()
                                  ),
                                ) : Pda == false && Phone == true ? Container(
                                    width: _size.width * 0.32,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff43A047), width: 3),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: accessOption == "3" ? TerspebTrue() : accessOption == "2" ? TerspebTrue() : accessOption == "1" ? TerspebFalse() : TerspebFalse()
                                ) : Container(
                                    width: _size.width * 0.32,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff43A047), width: 3),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: accessOption == "3" ? TerspebTrue() : accessOption == "2" ? TerspebTrue() : accessOption == "1" ? TerspebFalse() : TerspebFalse()
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    SharedPreferences pref = await SharedPreferences
                                        .getInstance();
                                    var res = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (
                                              context) => const SimpleBarcodeScannerPage(),
                                        ));
                                    print('------------------------------------------------');
                                    print(res);
                                    pref.setString('baxbarcode', res);
                                    setState(() {
                                      TerbcodeController.text = res;
                                    });
                                  },
                                  child: const Text('박스바코드'),
                                ),
                                Expanded(
                                  child: Container(
                                    width: _size.width * 0.65,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff43A047), width: 3),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: TerbcodeController,
                                      onTap:(){
                                        TerbcodeController.selection = TextSelection(baseOffset: TerbcodeController.text.length, extentOffset: 0);
                                      },
                                      style: TextStyle(fontSize: 20),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('내품수량', style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                              Container(
                                width: _size.width * 0.65,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color(0xff43A047), width: 3),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: TerbqtyController,
                                  style: TextStyle(fontSize: 20),
                                  onTap:(){
                                    TerbqtyController.selection = TextSelection(baseOffset: TerbqtyController.text.length, extentOffset: 0);
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
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
                                  Text('저장', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.white)),
                                ],
                              ),
                            ),
                            onTap: () async {
                              final SharedPreferences pref = await SharedPreferences
                                  .getInstance();
                              final now = DateTime.now();
                              String formatDate = DateFormat('yyyyMMdd').format(
                                  now);

                              if(pref.getInt('length') != 0 && pref.getString('URL') != null){
                                URL = pref.getString('URL')!;
                              } else {
                                URL = pref.getString('exist')!;
                              }


                              print('확인');
                              print(formatDate);
                              // TerbqtyController.text
                              try {
                                http.Response response = await http.patch(
                                    Uri.http(URL,
                                        'v1/hand/terminal'),
                                    body: json.encode({
                                      "str_code": "001",
                                      "ter_bcode": TerbcodeController.text,
                                      "ter_bqty": int.parse(TerbqtyController.text),
                                      "ter_code": TercodeController.text,
                                      "ter_date": formatDate,
                                      "ter_name": TernameController.text,
                                      "ter_ppbc": int.parse(TerppbcController.text.replaceAll(',', "")),
                                      "ter_ppcc": int.parse(TerppccController.text.replaceAll(',', "")),
                                      "ter_qty": int.parse(TerqtyController.text),
                                      "ter_seq": seqNo,
                                      "ter_spea": int.parse(TerspeaController.text.replaceAll(',', "")),
                                      "ter_speb": int.parse(TerspebController.text.replaceAll(',', "")),
                                      "ter_spec": TerspecController.text,
                                      "ter_tax": pref.getString('tax'),
                                      "ter_type": pref.getString(
                                          'BoxUpdateType'),
                                      "ter_vencd": pref.getString('ter_vencd'),
                                      "user_id": pref.getInt('id'),
                                    }),
                                    headers: {
                                      "Content-Type": "application/json",
                                      "Accept": "application/json",
                                      "Authorization": "bearer ${pref.getString(
                                          'access_token')}"
                                    }
                                );
                                var decodeResponse = jsonDecode(
                                    utf8.decode(response.bodyBytes));
                                print(decodeResponse);
                                if (decodeResponse['error'] == "") {
                                  alert(context, '저장완료', '확인', onTap: () {
                                    Modular.to.popAndPushNamed(RouteMap.BOX_UPDATE.page);
                                  });
                                }
                              } catch (e) {
                                print('에러');
                                print(e);
                              }
                            },
                          ),
                        ],
                      ),
                    ),

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
            onTap: () => Modular.to.pop(),
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

  Widget TerppbcTrue() {
    return TextField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.right,
      controller: TerppbcController,
      style: TextStyle(fontSize: 20),
      inputFormatters: [
        ThousandsFormatter()
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }

  Widget TerppbcFalse() {
    return TextField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.right,
      controller: TerppbcController,
      style: TextStyle(fontSize: 20),
      inputFormatters: [
        ThousandsFormatter()
      ],
      decoration: InputDecoration(
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          enabled: false
      ),
    );
  }

  Widget TerspeaTrue() {
    return TextField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.right,
      controller: TerspeaController,
      style: TextStyle(fontSize: 20),
      inputFormatters: [
        ThousandsFormatter()
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }

  Widget TerspeaFalse() {
    return TextField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.right,
      controller: TerspeaController,
      style: TextStyle(fontSize: 20),
      inputFormatters: [
        ThousandsFormatter()
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        enabled: false,
      ),
    );
  }

  Widget TerppccTrue() {
    return TextField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.right,
      controller: TerppccController,
      style: TextStyle(fontSize: 20),
      inputFormatters: [
        ThousandsFormatter()
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }

  Widget TerppccFalse() {
    return TextField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.right,
      controller: TerppccController,
      style: TextStyle(fontSize: 20),
      inputFormatters: [
        ThousandsFormatter()
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        enabled: false,
      ),
    );
  }

  Widget TerspebTrue() {
    return TextField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.right,
      controller: TerspebController,
      style: TextStyle(fontSize: 20),
      inputFormatters: [
        ThousandsFormatter()
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }

  Widget TerspebFalse() {
    return TextField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.right,
      controller: TerspebController,
      style: TextStyle(fontSize: 20),
      inputFormatters: [
        ThousandsFormatter()
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        enabled: false,
      ),
    );
  }







  Future<void> scanBarcodeNormal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('BoxUpdateType', widget.BoxUpdateType);
    String _scanBarcode = 'Unknown';
    String barcodeScanRes;

    if(pref.getInt('length') != 0 && pref.getString('URL') != null){
      URL = pref.getString('URL')!;
    } else {
      URL = pref.getString('exist')!;
    }

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', '취소', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    _scanBarcode = barcodeScanRes;
    final now = DateTime.now();
    String formatDate = DateFormat('yyyyMMdd').format(now);
    var params = {
      'user_id': pref.getString('user_id'),
      'str_code': '001',
      'date': formatDate,
      'type': pref.getString('BoxUpdateType'),
      'barcode': _scanBarcode,
    };
    http.Response response = await http.get(
        Uri.http(URL, 'v1/item/p01', params),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "bearer ${pref.getString('access_token')}"
        }
    );
    var decodeResponse = jsonDecode(utf8.decode(response.bodyBytes));
    if(decodeResponse[0]['itm_name'] == '미등록상품') {
      return setState(() {
        scanBarcode = _scanBarcode;
        selectTax = '1';
        TercodeController.text = _scanBarcode;
        TernameController.text = decodeResponse[0]['itm_name'];
        SPEAController.text = f.format(decodeResponse[0]['itm_spea']).toString();
        SPEBController.text = f.format(decodeResponse[0]['itm_speb']).toString();
        PPBController.text = f.format(decodeResponse[0]['itm_ppbc']).toString();
        PPCController.text = f.format(decodeResponse[0]['itm_ppcc']).toString();
        TerqtyController.text = decodeResponse[0]['itm_qty'].toString();
        TerspecController.text = decodeResponse[0]['itm_spec'].toString();
        TerbqtController.text = decodeResponse[0]['bqty'].toString();

        TerppbcController.text = f.format(0).toString();
        TerppccController.text = f.format(0).toString();
        TerspeaController.text = f.format(0).toString();
        TerspebController.text = f.format(0).toString();

        if((TerbqtyController.text = decodeResponse[0]['ter_bqty'].toString()) == "null") {
          TerbqtyController.text = 0.toString();
        }

        pref.setInt('seq_no', decodeResponse[0]['seq_no']);
        pref.setString('barcode', TercodeController.text);
        seq = pref.getInt('seq_no');

        if((scanBarcode == TercodeController.text) && (pref.getString('BoxUpdateType') == decodeResponse[0]['itm_type'].toString()) && (TerqtyController.text != 0.toString())) {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  content: Text('수정 및 추가'),
                  actions: [
                    TextButton(
                      child: Text('수정'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          seqNo = seq;
                          TerqtyController.selection;
                        });
                      },
                    ),
                    TextButton(
                      child: Text('추가'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        TerqtyController.selection;
                        TerqtyController.text = f.format(0).toString();
                        seqNo = 0;
                      },
                    ),
                  ],
                );
              }
          );
        }

      });
    }

    this._valueList = decodeResponse;
    _value = _valueList;
    print('재확인');
    print(_value);
    seq = pref.setInt('seq_no', _value[0]['seq_no']);
    setState(() {
      scanBarcode = _scanBarcode;

      TercodeController.text = _scanBarcode;
      TernameController.text = _value[0]['itm_name'];
      SPEAController.text = f.format(_value[0]['itm_spea']).toString();
      SPEBController.text = f.format(_value[0]['itm_speb']).toString();
      PPBController.text = f.format(_value[0]['itm_ppbc']).toString();
      PPCController.text = f.format(_value[0]['itm_ppcc']).toString();
      TerqtyController.text = _value[0]['itm_qty'].toString();
      TerspecController.text = _value[0]['itm_spec'].toString();
      TerbcodeController.text = _value[0]['itm_barcode'].toString();
      TerbqtController.text = _value[0]['bqty'].toString();
      selectTax = handvalue[0]['itm_tax'].toString();

      TerppbcController.text = f.format(0).toString();
      TerppccController.text = f.format(0).toString();
      TerspeaController.text = f.format(0).toString();
      TerspebController.text = f.format(0).toString();


      if((TerbqtyController.text = _value[0]['ter_bqty'].toString()) == "null") {
        TerbqtyController.text = 0.toString();
      }

      pref.setInt('seq_no', _value[0]['seq_no']);
      pref.setString('barcode', TercodeController.text);
      seq = pref.getInt('seq_no');
      print(seq);


    });
    pref.setString('barcode', _scanBarcode);
    print('바코드');
    print(_scanBarcode);

    if((scanBarcode == TercodeController.text) && (pref.getString('BoxUpdateType') == _value[0]['itm_type'].toString()) && (TerqtyController.text != 0.toString())) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext ctx) {
            return AlertDialog(
              content: Text('수정 및 추가'),
              actions: [
                TextButton(
                  child: Text('수정'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      seqNo = seq;
                      TerqtyController.selection;
                    });
                  },
                ),
                TextButton(
                  child: Text('추가'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    TerqtyController.selection;
                    TerqtyController.text = f.format(0).toString();
                    seqNo = 0;
                  },
                ),
              ],
            );
          }
      );
    }

  }

  Future<void> handItemList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('BoxUpdateType', widget.BoxUpdateType);
    final now = DateTime.now();
    String formatDate = DateFormat('yyyyMMdd').format(now);

    if(pref.getInt('length') != 0 && pref.getString('URL') != null){
      URL = pref.getString('URL')!;
    } else {
      URL = pref.getString('exist')!;
    }


    var params = {
      'user_id': pref.getString('user_id'),
      'str_code': '001',
      'date': formatDate,
      'type': pref.getString('BoxUpdateType'),
      'barcode': TercodeController.text,
    };
    http.Response response = await http.get(
        Uri.http(URL, 'v1/item/p01', params),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "bearer ${pref.getString('access_token')}"
        }
    );
    var decodeResponse = jsonDecode(utf8.decode(response.bodyBytes));

    this.handvalueList = decodeResponse;
    handvalue = handvalueList;

    print(decodeResponse);
    pref.setInt('seq_no', decodeResponse[0]['seq_no']);
    seq = pref.getInt('seq_no');

    if(decodeResponse[0]['itm_name'] == '미등록상품') {
      return setState(() {
        selectTax = '1';
        TernameController.text = handvalue[0]['itm_name'];
        SPEAController.text = f.format(handvalue[0]['itm_spea']).toString();
        SPEBController.text = f.format(handvalue[0]['itm_speb']).toString();
        PPBController.text = f.format(handvalue[0]['itm_ppbc']).toString();
        PPCController.text = f.format(handvalue[0]['itm_ppcc']).toString();
        TerqtyController.text = handvalue[0]['itm_qty'].toString();
        TerspecController.text = handvalue[0]['itm_spec'].toString();
        TerbqtController.text = handvalue[0]['bqty'].toString();

        TerppbcController.text = f.format(0).toString();
        TerppccController.text = f.format(0).toString();
        TerspeaController.text = f.format(0).toString();
        TerspebController.text = f.format(0).toString();

        if((TerbqtyController.text = decodeResponse[0]['ter_bqty'].toString()) == "null") {
          TerbqtyController.text = 0.toString();
        }

        TerqtyController.selection =  TextSelection(baseOffset: TerqtyController.text.length, extentOffset: 0);

        inputBarcode = TercodeController.text;

        if((inputBarcode == TercodeController.text || scanBarcode == TercodeController.text) && (pref.getString('BoxUpdateType') == handvalue[0]['itm_type'].toString()) && (TerqtyController.text != 0.toString())) {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  content: Text('수정 및 추가'),
                  actions: [
                    TextButton(
                      child: Text('수정'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          seqNo = seq;
                          print('수정 데이터');
                          print(seqNo);
                          TerqtyController.selection;
                        });
                      },
                    ),
                    TextButton(
                      child: Text('추가'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        TerqtyController.selection;
                        TerqtyController.text = f.format(0).toString();
                        seqNo = 0;
                        print('추가 데이터');
                        print(seqNo);
                      },
                    ),
                  ],
                );
              }
          );
        }

      });
    }


    setState(() {

      TernameController.text = handvalue[0]['itm_name'];
      SPEAController.text = f.format(handvalue[0]['itm_spea']).toString();
      SPEBController.text = f.format(handvalue[0]['itm_speb']).toString();
      PPBController.text = f.format(handvalue[0]['itm_ppbc']).toString();
      PPCController.text = f.format(handvalue[0]['itm_ppcc']).toString();
      TerqtyController.text = handvalue[0]['itm_qty'].toString();
      TerspecController.text = handvalue[0]['itm_spec'].toString();
      TerbcodeController.text = handvalue[0]['itm_barcode'].toString();
      TerbqtController.text = handvalue[0]['bqty'].toString();
      selectTax = handvalue[0]['itm_tax'].toString();

      TerppbcController.text = f.format(0).toString();
      TerppccController.text = f.format(0).toString();
      TerspeaController.text = f.format(0).toString();
      TerspebController.text = f.format(0).toString();

      TerqtyController.selection;
      inputBarcode = TercodeController.text;

      if((TerbqtyController.text = handvalue[0]['ter_bqty'].toString()) == "null") {
        TerbqtyController.text = 0.toString();
      }


      print('확인데이터');
      pref.setInt('seq_no', handvalue[0]['seq_no']);
      pref.setString('barcode', TercodeController.text);
      seq = pref.getInt('seq_no');
      print(seq);
    });

    if((inputBarcode == TercodeController.text || scanBarcode == TercodeController.text) && (pref.getString('BoxUpdateType') == handvalue[0]['itm_type'].toString()) && (TerqtyController.text != 0.toString())) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext ctx) {
            return AlertDialog(
              content: Text('수정 및 추가'),
              actions: [
                TextButton(
                  child: Text('수정'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      seqNo = seq;
                      print('수정 데이터');
                      print(seqNo);
                      TerqtyController.selection;
                    });
                  },
                ),
                TextButton(
                  child: Text('추가'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    TerqtyController.selection;
                    TerqtyController.text = f.format(0).toString();
                    seqNo = 0;
                    print('추가 데이터');
                    print(seqNo);
                  },
                ),
              ],
            );
          }
      );
    }


  }

  Widget Taxbody() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: selectTax,
        hint: Text('선택'),
        onChanged: (value) async {
          print('실행중');
          print(value);
          setState(() {
            selectTax = value;
          });
        },
        items: TaxList.values.map<DropdownMenuItem>((item){
          return DropdownMenuItem(
            key: ValueKey(item.ko),
            value: item.id,
            child: Text(item.ko),
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setInt('tax', item.id);
            },
          );
        }).toList(),
      ),
    );
  }

  Future Title() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    accessType = pref.getString('access_type');
    accessOption = pref.getString('access_option');
  }

}
enum TaxList {
  taxation(ko: '과세', id: 1),
  taxFree(ko: '면세', id: 0);

  final String ko;
  final int id;

  const TaxList({
    required this.ko,
    required this.id,
  });
}