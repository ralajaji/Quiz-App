import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_app/constants.dart';
import '../quizzes/rootQuiz.dart';

class Quizzez extends StatefulWidget {
  @override
  State<Quizzez> createState() => QuizzezState();
}

class QuizzezState extends State<Quizzez> {
  var index = -1;

  @override
  Widget build(BuildContext context) {
    void setIndex(int i) {
      setState(() {
        index = i;
      });
    }

    void _resetQuiz() {
      setState(() {
        index = -1;
      });
    }

    final deviceSize = MediaQuery.of(context).size;

    return index == -1
        ? Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: .85,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 17),
                          blurRadius: 17,
                          spreadRadius: -23,
                        )
                      ]),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => setIndex(0),
                      child: Column(
                        children: [
                          Spacer(),
                          Image.asset(
                            "assets/images/AR and VR_ The future of work and play? | ZDNet.jpg",
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Text(
                              "TECHNOLOGY",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(fontSize: 15, color: kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 17),
                          blurRadius: 17,
                          spreadRadius: -23,
                        )
                      ]),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => setIndex(1),
                      child: Column(
                        children: [
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.asset(
                              "assets/images/Colorful Sport Icons.jpg",
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              "SPORT",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(fontSize: 15, color: kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 17),
                          blurRadius: 17,
                          spreadRadius: -23,
                        )
                      ]),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => setIndex(2),
                      child: Column(
                        children: [
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.asset(
                              "assets/images/Chemical Flask Icon Design Vector, Chemical Icons, Chemical, Flask PNG and Vector with Transparent Background for Free Download.jpg",
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              "CHEMISTRY",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(fontSize: 15, color: kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 17),
                          blurRadius: 17,
                          spreadRadius: -23,
                        )
                      ]),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => setIndex(3),
                      child: Column(
                        children: [
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child:
                                Image.asset("assets/images/Physics Icons.jpg"),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              "PHYSICS",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(fontSize: 15, color: kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: const EdgeInsets.fromLTRB(20, 135, 20, 0),
            child: RootQuiz(index, _resetQuiz),
          );
  }
}
