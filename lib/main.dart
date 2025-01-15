import 'package:aendlab/api/client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:riverpod/riverpod.dart';

import 'router/routes_module.dart';
import 'package:http/http.dart' as http;
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await FlutterConfig.loadEnvVariables();
  //
  // APIClient(url: FlutterConfig.get('API_URL'));
  // ModularApp(module: RoutesModule(), child: MyApp()));
  runApp(
      ModularApp(module: RoutesModule(), child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ko', 'KR'),
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        )
    ).modular();
  }
}

// class MyHomePage extends StatefulWidget {

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('123'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text('123'),
//           ],
//         ),
//       ),// This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }