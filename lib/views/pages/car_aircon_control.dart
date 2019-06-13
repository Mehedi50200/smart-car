import 'package:flutter/material.dart';
import 'package:redcar/views/widgets/circular_slider.dart';
import 'package:redcar/utils/style.dart';

double _screenHeight, _screenWidth;
bool isAcOn = false;
int _temparature = 0;
bool isAutoOn = false;

final _scaffoldKey = GlobalKey<ScaffoldState>();

String acMessage, autoMessgae, lockStatus;
Color gifColor, acgifColor;

class AirconControl extends StatefulWidget {
  AirconControl();
  @override
  _AirconControlState createState() => _AirconControlState();
}

class _AirconControlState extends State<AirconControl> {
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
          '车门控制',
          style: Style.appBarTitleStyle,
        ),
        backgroundColor: Style.backgroundColor,
        elevation: 0,
      ),
      body: Container(
        height: _screenHeight,
        width: _screenWidth,
        color: Color(0xFF1E1E1E),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              child: buildBackground(),
            ),
            Positioned(
              bottom: 20,
              child: buildBottomShhet(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBackground() {
    return Container(
      height: _screenHeight / 2,
      width: _screenWidth,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/aircon_control/background.png"))),
    );
  }

  Widget buildBottomShhet() {
    return Container(
      height: _screenHeight / 2,
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
              const Color(0x991F252E),
              const Color(0x501F252E),
            ],
          ),
          boxShadow: [
            BoxShadow(
                color: Color(0x60000000), blurRadius: 10, offset: Offset(2, 0))
          ]),
      child: Column(
        mainAxisAlignment:
            isAcOn ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
        children: <Widget>[
          buildInfoRow(),
          buildCircularSlider(),
          buildPowerButton(),
        ],
      ),
    );
  }

  Widget buildInfoRow() {
    if (isAutoOn == true) {
      autoMessgae = "Auto temparature control is disabled";
      gifColor = Colors.red;
    } else {
      autoMessgae = "Auto temparature control is enabled";
      gifColor = Colors.green;
    }
    return isAcOn
        ? AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Temparature",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w200),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      isAutoOn ? "Auto" : _temparature.toString(),
                      style: TextStyle(
                          color: isAutoOn ? Colors.blueAccent : Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAutoOn = !isAutoOn;
                      buildSnackBar(autoMessgae,
                          "assets/aircon_control/aircon.gif", gifColor);
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: isAutoOn ? 85 : 75,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white, width: 0.3),
                      gradient:
                          isAutoOn ? Style.blueAndGreen : Style.transparent,
                    ),
                    child: Text(
                      isAutoOn ? "Auto Off" : "Auto On",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          )
        : AnimatedContainer(
            duration: Duration(milliseconds: 200),
          );
  }

  Widget buildCircularSlider() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isAcOn ? _screenHeight / 3 : 0,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: isAcOn ? 1 : 0,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          margin: EdgeInsets.all(isAutoOn ? 15 : 0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isAutoOn ? Style.blueAndGreen : Style.transparent,
          ),
          child: isAutoOn
              ? Text("Auto",
                  style: TextStyle(fontSize: 28, color: Colors.white))
              : DurationPicker(
                  temparature: _temparature,
                  onChange: (val) {
                    this.setState(() {
                      _temparature = val;
                    });
                  },
                ),
        ),
      ),
    );
  }

  Widget buildPowerButton() {
    if (isAcOn == true) {
      acMessage = "Aircondition is turned off";
      acgifColor = Colors.red;
    } else {
      acMessage = "Aircondition is turned on";
      acgifColor = Colors.green;
    }
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: _screenWidth,
      height: isAcOn ? 35 : 50,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.red,
              Colors.orange[800],
            ],
          ),
          boxShadow: [
            BoxShadow(
                color: Color(0xFF000000), blurRadius: 10, offset: Offset(1, 5))
          ]),
      child: IconButton(
        alignment: Alignment.center,
        onPressed: () {
          setState(() {
            isAcOn = !isAcOn;
            buildSnackBar(
                acMessage, "assets/aircon_control/aircon.gif", acgifColor);
          });
        },
        icon: Image.asset("assets/aircon_control/powericon3x.png"),
      ),
    );
  }

  buildSnackBar(String snackMessage, image, gifColor) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(snackMessage, style: TextStyle(color: gifColor)),
          CircleAvatar(
            backgroundImage: AssetImage(image),
            radius: 15,
            backgroundColor: gifColor,
          )
        ],
      ),
      duration: Duration(seconds: 2),
    ));
  }
}
