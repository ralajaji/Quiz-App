import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Result extends StatelessWidget {
  final int resultScore;
  final int totalQ;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler, this.totalQ);

  String get resultPhrase {
    String resultText = resultScore.toString();
    savePoints();

    return 'You got ' + resultText + ' / ' + totalQ.toString();
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
                // color: Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9)),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          FlatButton(
            child: Text(
              'Go back!',
            ),
            textColor: Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
            onPressed: resetHandler,
          ),
        ],
      ),
    );
  }
}
