import 'package:flutter/material.dart';
import 'package:redcar/views/pages/profile.dart';
import 'package:redcar/views/widgets/curved_nav_bar.dart';
import 'package:redcar/views/pages/newsfeed.dart';
import 'package:flutter/services.dart';
import 'package:redcar/views/pages/car_menu.dart';
import 'package:redcar/utils/style.dart';

class MainPage extends StatefulWidget {
  MainPage();
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xff00c9ff), Color(0xff92fe9d)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 80.0));
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int currentPage = 0;

  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    tabController = TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          new Icon(
            // set icon to the tab
            Icons.directions_car,
            // title: "Car",
            size: 30,
            color: Colors.grey,
          ),
          new Icon(
            // set icon to the tab
            Icons.home,
            size: 30,
            color: Colors.grey,
            // title: "Moment",
          ),
          new Icon(
            Icons.account_circle,
            size: 30,
            color: Colors.grey,
            // title: "Profile",
          ),
        ],
        key: bottomNavigationKey,
        initialIndex: 0,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        backgroundColor: Style.backgroundColor,
        color: Style.raisedbuttonColor,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
      body: _getPage(currentPage),
    );
  }

  _getPage(page) {
    switch (page) {
      case 0:
        return CarMenu();
      case 1:
        return Newsfeed();
      case 2:
        return ProfilePanel();
    }
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }
}
