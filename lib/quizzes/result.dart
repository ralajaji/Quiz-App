import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final int totalQ;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler, this.totalQ);

  String get resultPhrase {
    String resultText = resultScore.toString();
    savePoints();

    return 'Your result is: ' + resultText + ' / ' + totalQ.toString();
  }

  savePoints() async {
    final _storage = FlutterSecureStorage();
    var id = await _storage.read(key: 'token');

    var url =
        "https://quiz-ksu-default-rtdb.asia-southeast1.firebasedatabase.app/users/${id}.json";
    final res = await http.get(Uri.parse(url));
    final body = json.decode(res.body);

    var oldPoints = body['user']['points'];
    var name = body['user']['name'];
    var newPoints = oldPoints + resultScore;

    var url2 =
        "https://quiz-ksu-default-rtdb.asia-southeast1.firebasedatabase.app/${id}.json";
    final res2 = await http.put(Uri.parse(url),
        body: json.encode({
          "user": {"points": newPoints, "name": name}
        }));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Center(
      child: Column(
        children: <Widget>[
          Text(' '),
          Center(
            child: Text(
              resultPhrase,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            width: deviceSize.width * 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: ElevatedButton(
                child: Text(
                  'Go back!',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: resetHandler,
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
