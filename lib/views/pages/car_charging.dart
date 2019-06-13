import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

double _screenHeight, _screenWidth;
bool _isCharging = true;
double x = 0;
double y = 0;

AssetImage carcharging;
AssetImage caruchargingicon;
String batteryState;

final _scaffoldKey = GlobalKey<ScaffoldState>();

class CarCharging extends StatefulWidget {
  @override
  _CarChargingState createState() => _CarChargingState();
}

class _CarChargingState extends State<CarCharging> {
//  double _percent = 0.5;
  bool animated = true;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: new Text(
          '充电',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 0,
      ),
      body: Container(
        height: _screenHeight,
        width: _screenWidth,
        color: Color(0xFF1E1E1E),
        child: Column(
          children: <Widget>[
            buildBackground(),
            buildMileage(),
            buildProgress(),
            buildBottomShhet(),
          ],
        ),
      ),
    );
  }

  Widget buildBackground() {
    return Container(
      height: _screenHeight/2.8,
      child: AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final offsetAnimation =
                Tween<Offset>(begin: Offset(-2.0, 0.0), end: Offset(0.0, 0.0))
                    .animate(animation);
            return SlideTransition(
              position: offsetAnimation,
              child:child,
            );
          },
          child:  _isCharging
                  ?Image.asset("assets/carcharging.png",key: ValueKey<String>("1"),) 
                  :Image.asset(
                    "assets/caruncharging.png",key: ValueKey<String>("2"),
                  
                  ) ,),
    );
  }

  Widget buildMileage() {
    return Container(
      width: _screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "当前续航：",
            style: TextStyle(color: Colors.white),
          ),
          Text("200", style: TextStyle(color: Color(0xff92fe9d), fontSize: 20)),
          SizedBox(
            width: 5,
          ),
          Text("km", style: TextStyle(color: Colors.grey))
        ],
      ),
    );
  }

  Widget buildBottomShhet() {
    return Container(
        height: _screenHeight / 2.7,
        width: _screenWidth - 40,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              const Color(0xFF1F252E),
              const Color(0x301F252E),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            buildInfoRow(),
            SizedBox(
              height: _screenHeight / 9,
            ),
            buildFinishButton(),
            // buildStartButton(),
          ],
        ));
  }

  Widget buildInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              "电流/电压",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w200),
            ),
            Text(
              "预计时间",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w200),
            ),
          ],
        ),
        Container(
            width: 80,
            height: 50,
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text(
                  "40A/300V",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
                Text(
                  "1小时",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                )
              ],
            )),
      ],
    );
  }

  Widget buildFinishButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isCharging = !_isCharging;
          _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text("充电已结束"),
            duration: Duration(seconds: 1),
          ));
        });
      },
      child: Container(
        width: 200,
        height: 40,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xff8e2de2), Color(0xff4a00e0)],
            ),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("结束充电", style: TextStyle(color: Colors.white, fontSize: 20))
          ],
        ),
      ),
    );
  }

  Widget buildProgress() {
    return Container(
      width: _screenWidth,
      child: new LinearPercentIndicator(
        alignment: MainAxisAlignment.center,
        width: MediaQuery.of(context).size.width - 180,
        animation: false,
        lineHeight: 30.0,
        animationDuration: 60000,
        percent: 0.5,
        center: Text("50.0%"),
        linearStrokeCap: LinearStrokeCap.butt,
        progressColor: Color(0xff92fe9d),
        trailing: buildBattery(),
      ),
    );
  }

  Widget buildBattery() {
    if (_isCharging == true) {
      caruchargingicon = AssetImage("assets/carcharicon.png");
      batteryState = "50%";
    } else {
      caruchargingicon = AssetImage("");
      batteryState = "";
    }
    return AnimatedContainer(
      duration: Duration(seconds: 4),
      child: Row(
        children: <Widget>[
          Image(
            image: caruchargingicon,
            height: 20,
          ),
          Text(
            batteryState,
            style: TextStyle(color: Color(0xff92fe9d), fontSize: 15),
          )
        ],
      ),
    );
  }
}
