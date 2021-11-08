import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Scoreboard extends StatefulWidget {
  @override
  State<Scoreboard> createState() => ScoreboardState();
}

class ScoreboardState extends State<Scoreboard> {
  List<Object> strings = [];

  @override
  Widget build(BuildContext context) {
    void setList() async {
      var url =
          "https://quiz-ksu-default-rtdb.asia-southeast1.firebasedatabase.app/users.json";
      final res = await http.get(Uri.parse(url));
      final body = json.decode(res.body);

      Map<String, dynamic> a = body;
      List<Object> b = List<Object>();

      print(strings.length);

      a.forEach((key, val) {
        if (val['user'] != null) {
          b.add(val['user']);
        }
      });

      setState(() {
        strings = b;
        print(strings);
      });
    }

    void logOut() async {
      final _storage = FlutterSecureStorage();
      await _storage.deleteAll();

      Navigator.pushNamed(context, '/auth');
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Text(''),
        Padding(
          padding: EdgeInsets.only(bottom: 5, top: 25),
          child: ButtonTheme(
            height: 56,
            child: RaisedButton(
              child: Text('See Scoreboard ',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              color: Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              onPressed: () => setList(),
            ),
          ),
        ),
        Text(''),
        Column(
            children: strings
                .map((item) => Padding(
                      padding: EdgeInsets.only(bottom: 5, top: 25),
                      child: ButtonTheme(
                        height: 56,
                        child: RaisedButton(
                          child: Text(
                              item.toString().split('{')[1].split('}')[0],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          color:
                              Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () => setList(),
                        ),
                      ),
                    ))
                .toList()),
        Text(''),
        Padding(
          padding: EdgeInsets.only(bottom: 5, top: 500),
          child: ButtonTheme(
            height: 56,
            child: RaisedButton(
              child: Text('Logout',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              color: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              onPressed: () => logOut(),
            ),
          ),
        ),
      ],
    );
  }
}

// void logOut() async {
//   final _storage = FlutterSecureStorage();
//   await _storage.deleteAll();

//   Navigator.pushNamed(context, '/auth');
// }
