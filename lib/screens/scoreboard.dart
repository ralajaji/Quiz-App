import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future logoutTestPurpose() async {
  final _storage = FlutterSecureStorage();
  await _storage.deleteAll();
}

class Scoreboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: () => logoutTestPurpose(),
          child: Text('test'),
        ),
      ),
    );
  }
}
