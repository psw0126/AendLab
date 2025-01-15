import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dialog/alert.dart';
import '../router/routes_module.dart';
import 'package:http/http.dart' as http;

import '../wiget/button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}):super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  {

  final IdController = TextEditingController();
  final PwController = TextEditingController();
  final URLController = TextEditingController();



   String URL = 'aendsoft.com:7020';
   var length;
   String existURL = 'aendsoft.com:7020';
   String Urlcontroll = '';
   var login;
   late SharedPreferences _prefs;
   late SharedPreferences pref;
   late bool Pda = false;
   late bool Phone = false;
   late bool isChecked;

  _loadCheckBoxState() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      Phone = pref.getBool('Phone')!;
      Pda = pref.getBool('Pda')!;
    });
  }

  _saveCheckPhoneState(bool value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      Phone = value;
    });
    await pref.setBool('Phone', true);
    await pref.setBool('Pda', false);

  }

  _saveCheckPdaState(bool value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      Pda = value;
    });
    await pref.setBool('Pda', false);
    await pref.setBool('Phone', true);
  }


  @override
  void initState() {
    // this.IdController.addListener(() {
    //   setState(()  {
    //   });
    // });
    // this.PwController.addListener(() {
    //   setState(()  {
    //   });
    // });
    this.URLController.addListener(() {
      setState(() {});
    });
    StateService();
    super.initState();
    _loadLogin();
    _loadCheckBoxState();

  }

  _loadLogin() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      IdController.text = _prefs.getString('login_ID')!;
      PwController.text = _prefs.getString('login_PW')!;
    });
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [                  
                  InkWell(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Icon(Icons.settings, size: 40)
                      ),
                    onTap: (){
                      print('설정버튼 온');
                      showDialog(context: context, builder: (context){
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: FittedBox(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              width: MediaQuery.of(context).size.width - (28.0 * 2.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(12.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 30.0),
                                  Container(
                                    width: _size.width * 0.65,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff43A047), width: 3),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: URLController,
                                      style: TextStyle(fontSize: 20),
                                      decoration: InputDecoration(
                                        hintText: '서버 주소 입력',
                                        border: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 22.0),
                                  Container(
                                    width: double.infinity,
                                    child: CustomButton('변경',
                                        textColor: Colors.white, height: 52.0,
                                        onTap: () async {
                                          SharedPreferences pref = await SharedPreferences.getInstance();
                                          pref.setString('URL', URLController.text);
                                          pref.setString('data_url', URLController.text);
                                          length = URLController.text.length;
                                          pref.setInt('length', length);
                                          if(length != 0){
                                            URL = pref.getString('URL')!;
                                          } else {
                                            URL = pref.getString('exist')!;
                                          }
                                          // Map params = {
                                          //   'token' : null,
                                          //   'uri' : uri,
                                          // };
                                          // Modular.to.pushNamed(RouteMap.WEB_BROWSER.page, arguments: params);
                                          Navigator.of(context).pop();
                                        }),
                                  ),
                                  SizedBox(height: 16.0),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                      print('설정버튼 오프');
                    },
                  ),
                  SizedBox(width: 10),
                ],
              ),
              Container(
                height: _size.width,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('아 이 디', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            Container(
                              clipBehavior: Clip.hardEdge,
                              width: _size.width*0.55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: Color(0xff000000),width: 3),
                              ),
                              child: TypeAheadField(
                                  textFieldConfiguration: TextFieldConfiguration(
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                    ),
                                    controller: this.IdController,
                                  ),
                                  suggestionsCallback: (pattern) async {
                                    return await StateService.getSuggestions(pattern);
                                  },
                                  transitionBuilder:
                                      (context, suggestionsBox, controller) {
                                    return suggestionsBox;
                                  },
                                  itemBuilder: (context, suggestion) {
                                    return ListTile(
                                      title: Text(suggestion),
                                    );
                                  },
                                  onSuggestionSelected: (suggestion) {
                                    this.IdController.text = suggestion;
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('패스워드', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            Container(
                              width: _size.width*0.55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: Color(0xff000000),width: 3),
                              ),
                              child: TypeAheadField(
                                textFieldConfiguration: TextFieldConfiguration(
                                  obscureText: true,
                                  style: TextStyle(fontSize: 20),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
                                  controller: this.PwController,
                                ),
                                suggestionsCallback: (pattern) async {
                                  return await PwService.getSuggestions(pattern);
                                },
                                transitionBuilder:
                                    (context, suggestionsBox, controller) {
                                  return suggestionsBox;
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: Text(suggestion),
                                  );
                                },
                                onSuggestionSelected: (suggestion) {
                                  this.PwController.text = suggestion;
                                }),
                            ),
                          ],
                        ),
                        // Container(
                        //   child: InkWell(onTap: _Login, child: Text('api테스트')),
                        // ),
                        Row(
                          children: [
                            Row(
                              children:[
                                Checkbox(
                                  value: Phone,
                                  onChanged: (value) {
                                    setState(() {
                                      _saveCheckPhoneState(value!);
                                        Phone = true;
                                        Pda = false;
                                    });
                                  },
                                ),
                                Text('스마트모드'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: Pda,
                                  onChanged: (value) {
                                    setState(() {
                                      _saveCheckPdaState(value!);
                                        Phone = false;
                                        Pda = true;
                                    });
                                  }

                                ),
                                Text('PDA모드'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        _btnLogin(),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btnLogin() {
    Size _size = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: _size.width,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Color(0xff4FC9DE),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 10.0,
                color: Colors.grey.withOpacity(0.7),
                offset: Offset(0,6),
              )
            ]
        ),
        child: Text('로그인', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),),
      ),
      onTap: IdController.text.isEmpty  || PwController.text.isEmpty ? () => alert(context, "아이디와 비밀번호를 입력해주세요.","확인") : () async {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        setState(() {
          StateService.states.add(IdController.text);
          PwService.states.add(PwController.text);
          pref.setBool('Phone', Phone);
          pref.setBool('Pda', Pda);
          print('확인');
          print(StateService.states);
        });
        pref.setString('exist', existURL);
        try {
          http.Response response = await http.post(Uri.http(URL, 'v1/login'),
              body: json.encode({
                "account_id": IdController.text,
                "password": PwController.text
              }),
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              }
          );

          var decodeResponse = jsonDecode(utf8.decode(response.bodyBytes));
          var length = pref.getInt('length');
          print('로그인 정보');
          print(decodeResponse);
          print(length);
          print(length.runtimeType);


          if(URLController.text.length == 0){
            pref.remove('length');
            pref.remove('URL');
          }

          if (decodeResponse['error'] == "AD001") {
            alert(context, decodeResponse['error_description'], "확인");
          }else if (decodeResponse['access_type'] == 3 || decodeResponse['access_type'] == 4){
            pref.setString('login_ID',IdController.text);
            pref.setString('login_PW',PwController.text);
            print(StateService.states.toSet());
            // StateService.states.toSet().toList();
            Modular.to.pushNamed(RouteMap.HOME.page);
          }
          else {
            alert(context, "로그인 권한이 없습니다.", "확인");
          }



          pref.setInt('id', decodeResponse['user_id']);
          pref.setString('user_id', decodeResponse['user_id'].toString());
          pref.setString('access_token', decodeResponse['access_token']);
          pref.setString('access_type', decodeResponse['access_type'].toString());
          pref.setString('access_option', decodeResponse['access_option'].toString());
          print('확인 방법');
          print(pref.getString('access_option'));
        } catch (e) {
          print('에러');
          print(e);

        }
      },
    );
  }
  // Future<bool> _Login() async {
  //   try {
  //     APIClient client = APIClient();
  //     await client.login(IdController.text, PwController.text);
  //   } catch (e) {
  //     print(e);
  //     if (e != null) {
  //       alert(context, '아이디와 비밀번호가 틀렸습니다.', "확인");
  //     }
  //     else {
  //       alert(context, "알 수 없는 에러가 발생했습니다.", "확인");
  //     }
  //   }
  //   return true;
  // }

}
class StateService {
  static final List<String> states = [];


  static List<String> getSuggestions(String query) {
    Set _setstates = states.toSet();
    List<String> matches = [];
    matches.addAll(_setstates as Iterable<String>);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

class PwService {
  static final List<String> states = [];


  static List<String> getSuggestions(String query) {
    Set _setPw = states.toSet();
    List<String> matches = [];
    matches.addAll(_setPw as Iterable<String>);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}




