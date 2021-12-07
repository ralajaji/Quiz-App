import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:teacher_app/screens/openItLater!/scoreboard.dart';
import '../constants.dart';
import '../../Api/NotificationApi.dart';
import 'quizzes.dart';

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

  void initState() {
    super.initState();

    NotificationApi.init();
    listenNotifications();

    // NotificationApi.showScheduledNotification(
    //   title: "test notification",
    //   body: "hey! this massage appears after 6 seconds",
    //   payload: "testNotification",
    //   scheduledDate: DateTime.now().add(Duration(seconds: 6)),
    // );
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen((onClickedNotification));

  void onClickedNotification(String payload) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Quizzez(),
      ));
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: Drawer(
          child: Material(
            color: kPrimaryColor,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: <Widget>[
                const SizedBox(
                  height: 48,
                ),
                buildMenuItem(
                  text: 'Logout',
                  icon: Icons.logout,
                ),
                // buildNotification(
                //   text: 'Sample Notification',
                //   icon: Icons.notification_add_sharp,
                // ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFFEBD8FF),
          elevation: 0.0,
          iconTheme: IconThemeData(color: kPrimaryColor),
        ),
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
              height: size.height * .25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
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
              margin: const EdgeInsets.fromLTRB(20, 150, 20, 0),
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

  Widget buildMenuItem({
    String text,
    IconData icon,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: () async {
        final _storage = FlutterSecureStorage();
        await _storage.deleteAll();

        Navigator.pushNamed(context, '/auth');
      },
    );
  }

  Widget buildNotification({
    String text,
    IconData icon,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
        leading: Icon(
          icon,
          color: color,
        ),
        title: Text(
          text,
          style: TextStyle(color: color),
        ),
        hoverColor: hoverColor,
        onTap: () => NotificationApi.showScheduledNotification(
              title: "test notification",
              body: "hey! this massage appears after 6 seconds",
              payload: "testNotification",
              scheduledDate: DateTime.now().add(Duration(seconds: 6)),
            ));
  }
}
