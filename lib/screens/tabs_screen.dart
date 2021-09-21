import 'package:flutter/material.dart';
import 'quizzes.dart';
import 'scoreboard.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = [Quizzez(), Scoreboard()];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz App',
          style: TextStyle(
            color: Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.white,
        unselectedItemColor: Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
        selectedItemColor: Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.sort_by_alpha), title: Text('quizzes')),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_numbered_sharp),
              title: Text('scoreboard')),
        ],
      ),
    );
  }
}
