import 'package:flutter/material.dart';
import 'package:redcar/views/widgets/swipe_button.dart';
import 'package:redcar/utils/style.dart';

double _screenHeight, _screenWidth;
final _scaffoldKey = GlobalKey<ScaffoldState>();

String onMessage, lockMessgae, lockStatus;

bool _isOn = true;
bool _isLocked = true;

AssetImage carOnOrOff;
AssetImage doorLockedOrUnlocked;
AssetImage lockOrUnlockImage;
Color gifColor;

LinearGradient lockOrUnlockColor;

class AutoDrive extends StatefulWidget {
  AutoDrive();
  @override
  _AutoDriveState createState() => _AutoDriveState();
}

class _AutoDriveState extends State<AutoDrive> {
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
        title: new Text('自动驾驶', style: Style.appBarTitleStyle,),
        backgroundColor: Style.backgroundColor,
        elevation: 0,
      ),
      body: Container(
        height: _screenHeight,
        width: _screenWidth,
        color: Color(0xFF1E1E1E),
        child: Column(
          children: <Widget>[
          
            buildBackground(),
            buildStartButton(),
            buildLockButton(),
          ],
        ),
      ),
    );
  }

  Widget buildStartButton() {
    if (_isLocked == true) {
      carOnOrOff = AssetImage("");
      onMessage = "自动驾驶关闭";
      // gifColor = Colors.red;
    } else {
      carOnOrOff = AssetImage("assets/car_control/gear.gif");
      onMessage = "自动驾驶开启";
      // gifColor = Colors.green;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _isOn = !_isOn;
          buildSnackBar(onMessage, 'assets/car_control/power.gif');
        });
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        height: _screenWidth / 3.5,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: carOnOrOff,
          ),
        ),
      ),
    );
  }

  Widget buildBackground() {
    if (_isLocked == true) {
      doorLockedOrUnlocked = AssetImage("assets/car_control/door_unlocked.png");
      lockOrUnlockImage = AssetImage("assets/car_control/handdrive.png");
      lockMessgae = "自动驾驶开启 !";
      lockStatus = "手动驾驶模式";
      lockOrUnlockColor = LinearGradient(
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
        colors: [
          Colors.red,
          Colors.orange[800],
        ],
      );
    } else {
      doorLockedOrUnlocked = AssetImage("assets/car_control/door_unlocked.png");
      lockOrUnlockImage = AssetImage("assets/car_control/drive.png");
      lockMessgae = "自动驾驶关闭";
      lockStatus = "自动驾驶模式";
      lockOrUnlockColor = LinearGradient(
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
        colors: [
          Colors.green,
          Colors.green[800],
        ],
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        height: _screenHeight / 2.2,
        width: _screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(image: doorLockedOrUnlocked),
        ),
      ),
    );
  }

  Widget buildLockButton() {
    return Container(
      width: _screenWidth,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SwipeButton(
        bg: _isLocked,
        thumb: Align(
          widthFactor: 0.33,
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            height: 80,
            width: 80,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: lockOrUnlockColor,
            ),
            child: Image(image: lockOrUnlockImage),
          ),
        ),
        content: Center(
          child: Text(
            lockStatus,
            style: TextStyle(
                fontSize: 17,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w200),
          ),
        ),
        onChanged: (result) {
          if (result == SwipePosition.SwipeLeft) {
            setState(() {
              _isLocked = true;
              buildSnackBar(lockMessgae,'assets/car_control/handdrive.png');
            });
          } else {
            setState(() {
              _isLocked = false;
              buildSnackBar(lockMessgae,'assets/car_control/drive.png' );
            });
          }

          print('onChanged $result');
        },
      ),
    );
  }

  buildSnackBar(String snackMessage, image) {
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
      duration: Duration(seconds: 3),
    ));
  }
}
