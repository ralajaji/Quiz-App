import 'package:flutter/material.dart';
import './screens/tabs_screen.dart';
import './screens/auth_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'constants.dart';

void main() {
  runApp(MyApp());
}

final _storage = FlutterSecureStorage();
Future checkAuth() async {
  var token = await _storage.read(key: 'token');
  return token;
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _token = null;

  @override
  Widget build(BuildContext context) {
    checkAuth().then((value) => setState(() {
          _token = value;
        }));

    return MaterialApp(
      home: _token == null ? AuthScreen() : TabsScreen(),
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        '/home': (_) => TabsScreen(),
        '/auth': (_) => AuthScreen(),
      },
    );
  }
}
