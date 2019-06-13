import 'package:flutter/material.dart';
import 'package:redcar/views/pages/car_charging.dart';
import 'package:flutter/cupertino.dart';
import 'package:redcar/utils/style.dart';
import 'package:redcar/views/pages/car_aircon_control.dart';
import 'package:redcar/views/pages/car_control.dart';
import 'package:redcar/views/pages/car_cctv.dart';
import 'package:redcar/views/pages/car_map.dart';
import 'package:redcar/views/pages/autodrive.dart';
double screenHeight, screenWidth;
String titleString, infoString, tagString;
var text2 = Material(
  color: Colors.transparent,
  child: Text(
    "已经是最新版本",
    style: TextStyle(fontSize: 20, color: Colors.white),
  ),
);

class CarMenu extends StatefulWidget {
  _CarMenuState createState() => _CarMenuState();
}

class _CarMenuState extends State<CarMenu> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: false,
              backgroundColor: Colors.black87,
              centerTitle: true,
              leading: Container(),
              title: Text(
                "Yusef Ma's REDS",
                style: Style.appBarTitleStyle,
              ),
            ),
          ];
        },
        body: Container(
            width: screenWidth,
            color: Style.backgroundColor,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: screenHeight / 2.5,
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            child: buildInfoRow(),
                          ),
                          Positioned(
                            top: 40,
                            child: buildBackground(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildDetailsData("距下次保养", "1800", "km"),
                          buildDevider(),
                          buildDetailsData("行驶里程统计", "2.5 ", "km"),
                          buildDevider(),
                          buildDetailsData("室外温度", "3", "℃"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: buildControl(context),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: buildList(context),
                    ),
                  ]),
            )),
      ),
    );
  }

  Widget buildInfoRow() {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.translationValues(
                0.0, animation.value * screenHeight, 0.0),
            child: Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Image.asset(
                        "assets/battery.png",
                        height: 20,
                        color: Color(0xff92fe9d),
                      ),
                      Text("80%", style: TextStyle(color: Colors.white))
                    ],
                  ),
                  Text(
                    "265",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      foreground: Paint()..shader = Style.textGradient,
                      fontSize: 100,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    height: 60,
                    child: Text(
                      "Km",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildBackground() {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform(
          transform:
              Matrix4.translationValues(animation.value * screenHeight, 0, 0.0),
          child: Container(
            padding: EdgeInsets.only(top: 50),
            child: Image.asset(
              "assets/carbackground.png",
              height: screenHeight / 3.5,
            ),
          ),
        );
      },
    );
  }

  Widget buildDetailsData(titleString, infoString, tagString) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(
              -animation.value * screenWidth, 0.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(titleString,
                  style: TextStyle(color: Colors.grey, fontSize: 18)),
              Row(
                children: <Widget>[
                  Text(infoString,
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Text(tagString,
                      style: TextStyle(
                        color: Colors.white,
                      ))
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildDevider() {
    return Container(
      height: 50,
      width: 1.0,
      color: Colors.white30,
    );
  }

  Widget buildControl(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(
              -animation.value * screenWidth, 0.0, 0.0),
          child: Container(
            margin: EdgeInsets.only(right: 18, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      new CupertinoPageRoute(
                          builder: (ctxt) => AirconControl()),
                    );
                  },
                  child: Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width / 3.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/shape1.png"),
                            fit: BoxFit.fill)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/air.png",
                          height: 30,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('空调已关', style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      new CupertinoPageRoute(builder: (ctxt) => CarCharging()),
                    );
                  },
                  child: Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width / 3.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/shape2.png"),
                            fit: BoxFit.fill)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/charging.png",
                          height: 30,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('充电管理', style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      new CupertinoPageRoute(builder: (ctxt) => CarControl()),
                    );
                  },
                  child: Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width / 3.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/shape3.png"),
                            fit: BoxFit.fill)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/carcontrol.png",
                          height: 30,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '车辆控制',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildList(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            onTap: () {
               Navigator.push(
                      context,
                      new CupertinoPageRoute(builder: (ctxt) => CarMap()),
                    );
            },
            leading: Image.asset(
              "assets/location.png",
              height: 30.0,
              fit: BoxFit.cover,
            ),
            title: Text(
              "汽车定位",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "北京市朝阳区国贸中服大厦停车场",
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            )),
        Container(
          height: 1.0,
          width: 300,
          color: Colors.white30,
          margin: EdgeInsets.only(
            left: 30,
          ),
        ),
        ListTile(
            onTap: () {Navigator.push(
                      context,
                      new CupertinoPageRoute(builder: (ctxt) => AutoDrive()),
                    );},
            leading: Image.asset(
              "assets/auto.png",
              height: 30.0,
              fit: BoxFit.cover,
            ),
            title: Text(
              "自动驾驶",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "未开启",
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            )),
        Container(
          height: 1.0,
          width: 300,
          color: Colors.white30,
          margin: EdgeInsets.only(
            left: 30,
          ),
        ),
        ListTile(
            onTap: () {
              Navigator.push(
                context,
                new CupertinoPageRoute(builder: (ctxt) => CarCctv()),
              );
            },
            leading: Image.asset(
              "assets/cctv.png",
              height: 30.0,
              fit: BoxFit.cover,
            ),
            title: Text(
              "实时监控",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(""),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            )),
        Container(
          height: 1.0,
          width: 300,
          color: Colors.white30,
          margin: EdgeInsets.only(
            left: 30,
          ),
        ),
        ListTile(
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  });
              await waitAction();
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 30,
                      child: Center(
                        child: text2,
                      ),
                    );
                  });
            },
            leading: Image.asset(
              "assets/update.png",
              height: 30.0,
              fit: BoxFit.cover,
            ),
            title: Text(
              "软件更新",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(""),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            )),
      ],
    );
  }

  Future<bool> waitAction() async {
    await new Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
