import 'dart:convert';


import 'package:aendlab/router/routes_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../dialog/alert.dart';



class StoreBuyEnterPage extends StatefulWidget {
  @override
  _StoreBuyEnterPageState createState() => _StoreBuyEnterPageState();
}

class _StoreBuyEnterPageState extends State<StoreBuyEnterPage> {
  String? StorePointCheck;
  final TextEditingController _typeAheadController = TextEditingController();
  List<dynamic> _valueList = [];
  var _value;
  var _cnamevalue;
  String URL = '';
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
    super.initState();
    StrName();
    _Mode();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                            child: Text('점간매입 입력', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          ) : Pda == false && Phone == true ? Container(
                            margin: EdgeInsets.symmetric(vertical: 30),
                            child: Text('점간매입 입력', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                          ) : Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Text('점간매입 입력', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          );
                        },
                      )
                  ),
                  // Container(
                  //     margin: EdgeInsets.symmetric(vertical: 30),
                  //     child: Text('점간매입 입력', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                  // ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      child: FutureBuilder(
                        future: _Mode(),
                        builder: (context, snapshot) {
                          return Pda == true && Phone == false ? Container(
                            child: Text('점포', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          ) : Pda == false && Phone == true ? Container(
                            child: Text('점포', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                          ) : Container(
                            child: Text('점포', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          );
                        },
                      )
                  ),
                  // Text('점포', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  auto(),
                ],
              ),
              SizedBox(height: 50),
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
                        offset: Offset(0,6),
                      )
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [                      
                      Text('확인', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white)),
                    ],
                  ),
                ),
                onTap: () async {
                  // if (_typeAheadController.text == '' || _typeAheadController.text == null) {
                  //   alert(context, '점포를 입력해주세요', '확인');
                  // }else if(_cnamevalue != _typeAheadController.text){
                  //   alert(context, '검색 후 리스트를 선택해주세요', '확인');
                  // }else
                  if(_value == null){
                    alert(context, '점포를 선택해주세요', '확인');
                  }else{
                    Modular.to.pushNamed(RouteMap.STORE_BUY_INPUT.page);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


// Widget Body() {
//   return DropdownButtonHideUnderline(
//     child: DropdownButton(
//       value: _value,
//       hint: Text('선택'),
//       onChanged: (value) async {
//         SharedPreferences pref = await SharedPreferences.getInstance();
//         print('실행중');
//         print(value);
//         setState(() {
//           _value = value;
//           pref.setString('ter_vencd', _value);
//           print('동작중');
//           print(_value);
//         });
//       },
//       items: _valueList.map((value){
//         return DropdownMenuItem(
//           value: value['str_code'],
//           child: Text(value['ven_name']),
//           onTap: () async {
//             SharedPreferences pref = await SharedPreferences.getInstance();
//             pref.setString('StoreTitle', value['ven_name']);
//           },
//         );
//       }).toList(),
//     ),
//   );
// }
  Widget auto() {
    Size _size = MediaQuery.of(context).size;
    return Container(
        width: _size.width*0.65,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xff43A047),width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TypeAheadField<Company?>(
          textFieldConfiguration:  TextFieldConfiguration(
              controller: this._typeAheadController,
              onTap: () {
                this._typeAheadController.clear();
              },
              decoration: InputDecoration(
                border: InputBorder.none,
              )
          ),
          suggestionsCallback: CompanyApi.StrName,
          itemBuilder: (context, Company? sugestion){
            final company = sugestion!;
            return ListTile(
              title: Text(company.cname),
            );
          },
          noItemsFoundBuilder: (context) => Container(
            height: 100,
            child: Center(
              child: Text(
                'Not Found.',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),

          onSuggestionSelected: (Company? suggestion) async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            final company = suggestion!;
            _value = company.strcode;
            _cnamevalue = company.cname;
            this._typeAheadController.text = company.cname;
            pref.setString('StoreTitle', company.cname);
            pref.setString('ter_vencd', company.strcode);


            // ScaffoldMessenger.of(context)
            // ..removeCurrentSnackBar()
            // ..showSnackBar(SnackBar(
            //   content: Text('Selected user: ${company.vencode}'),
            // ));
          },
        )
    );
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


Future<void> StrName() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();

  if(pref.getInt('length') != 0 && pref.getString('URL') != null){
    URL = pref.getString('URL')!;
  } else {
    URL = pref.getString('exist')!;
  }

  var params = {
    'user_id': pref.getString('user_id'),
    'str_code': '001',
  };

  http.Response response = await http.get(Uri.http(
      URL, 'v1/ven/strname', params),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "bearer ${pref.getString('access_token')}"
      }
  );
  var decodeResponse = jsonDecode(utf8.decode(response.bodyBytes));
  setState(() {
    this._valueList = decodeResponse;
  });
}
}

class Company{
  final String cname;
  final String strcode;

  const Company({
    required this.cname,
    required this.strcode,
  });

  static Company fromJson(Map<String, dynamic> json) => Company(
    cname: json['ven_name'],
    strcode: json['str_code'],
  );
}

class CompanyApi {
  static Future<List<Company>> StrName(String query) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String URL = '';
    if(pref.getInt('length') != 0 && pref.getString('URL') != null){
      URL = pref.getString('URL')!;
    } else {
      URL = pref.getString('exist')!;
    }

    var params = {
      'user_id': pref.getString('user_id'),
      'str_code': '001',
    };

    http.Response response = await http.get(Uri.http(URL, 'v1/ven/strname', params),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "bearer ${pref.getString('access_token')}"
        }
    );
    final List company  = jsonDecode(utf8.decode(response.bodyBytes));

    return company.map((json) => Company.fromJson(json)).where((company) {
      final cnameLower = company.cname.toLowerCase();
      final queryLower = query.toLowerCase();
      return cnameLower.contains(queryLower);
    }).toList();
  }
}