import 'package:flutter/material.dart';
import '../constants.dart';
import 'quizzes.dart';
import 'scoreboard.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = [Quizzez(), Spacer()];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Colors.white,
          unselectedItemColor: kPrimaryLightColor,
          selectedItemColor: kPrimaryColor,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.sort_by_alpha), title: Text('quizzes')),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_numbered_sharp),
                title: Text('scoreboard')),
          ],
        ),
        body: Stack(
          children: [
            Container(
              // Here the height of the container is 45% of our total height
              height: size.height * .35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFEBD8FF),
                image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
                ),
              ),
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment(-1, 1),
                    child: Text(
                      "Quizzes",
                      style: Theme.of(context).textTheme.display3.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFA587C7)),
                    ),
                  )
                ],
              ),
            )),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 200, 20, 0),
              child: _pages[_selectedPageIndex],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
                width: size.width * 0.4,
              ),
            ),
          ],
        ));
  }
}
