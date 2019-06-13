import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:redcar/utils/style.dart';

double screenWidth;
double screenHeight;
bool state = true;

class ProfilePanel extends StatefulWidget {
  _ProfilePanelState createState() => new _ProfilePanelState();
}

class _ProfilePanelState extends State<ProfilePanel>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
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
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      // appBar: AppBar(
      //   title: Text('车友圈', style: Style.appBarTitleStyle),
      //   centerTitle: true,
      //   backgroundColor: Style.backgroundColor,
      // ),
      body: Container(
        padding: EdgeInsets.only(top: 40),
        height: screenHeight,
        width: screenWidth,
        color: Style.backgroundColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              buildFirstRow(),
              Divider(color: Colors.grey[700]),
              buildSecondRow(),
              Divider(color: Colors.grey[700]),
              buildThirdRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFirstRow() {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.translationValues(
                0.0, animation.value * screenWidth, 0.0),
            child: Container(
              width: screenWidth,
              height: screenHeight / 2.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildUserImageAndName(),
                    buildUserInfoRow(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildUserImageAndName() {
    return Column(
      children: <Widget>[
        Container(
          width: screenHeight / 5.5,
          height: screenHeight / 5.5,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 3),
            image: DecorationImage(
              image: AssetImage("assets/elon.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            "Elon Mask",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Text(
            "CEO of Tesla Inc. Journey through space",
            style: TextStyle(
                color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w200),
          ),
        ),
      ],
    );
  }

  Widget buildUserInfoRow() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildInfoColumn("Friends", "525"),
          buildInfoColumn("Fan", "325"),
          buildInfoColumn("Followers", "25"),
        ],
      ),
    );
  }

  Widget buildInfoColumn(String title, String info) {
    return Column(
      children: <Widget>[
        Container(
          width: 80.0,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Text(
              info,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
        Container(
          width: 80.0,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700], fontSize: 15.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSecondRow() {
    return Container(
      width: screenWidth,
      height: 250,
      child: Column(
        children: <Widget>[
          buildTilteRow("Interests"),
          buildCardRow(),
        ],
      ),
    );
  }

  Widget buildTilteRow(String title) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Text(
              title,
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
          ),
          Material(
            color: Style.raisedbuttonColor,
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 30,
                width: 30,
                child: Icon(
                  Icons.add,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCardRow() {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(
              -animation.value * screenWidth, 0.0, 0.0),
          child: Container(
            width: screenWidth,
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                buildCard(Style.blueAndGreen, Color(0x2534edce),
                    "assets/profile/travel.png", "Travel"),
                buildCard(Style.orangeAndRed, Color(0x25FF4B2B),
                    "assets/profile/music.png", "Music"),
                buildCard(Style.orangeAndyellow, Color(0x25ED8F03),
                    "assets/profile/food.png", "Food"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCard(gradientColor, shadowColor, cardImage, cardTitle) {
    return Container(
      width: screenWidth / 2.5,
      margin: EdgeInsets.fromLTRB(5, 5, 5, 35),
      decoration: BoxDecoration(
        gradient: gradientColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: 20, offset: Offset(0, 10)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 80,
              padding: EdgeInsets.all(5),
              child: Image(
                image: AssetImage(cardImage),
              )),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(
              cardTitle,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget buildThirdRow() {
    return Container(
      width: screenWidth,
      height: 200,
      child: Column(
        children: <Widget>[
          buildTilteRow("Following"),
          buildFollowingRow(),
        ],
      ),
    );
  }

  Widget buildFollowingRow() {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(
              animation.value * screenWidth, 0.0, 0.0),
          child: Container(
            height: 120,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                buildFollowingCard("Mehedi", "assets/users/user1.jpg"),
                buildFollowingCard("Tanvir", "assets/users/user2.jpg"),
                buildFollowingCard("Ashique", "assets/users/user3.jpg"),
                buildFollowingCard("Ra Vien", "assets/users/user4.jpg"),
                buildFollowingCard("Mehedi", "assets/users/user1.jpg"),
                buildFollowingCard("Tanvir", "assets/users/user2.jpg"),
                buildFollowingCard("Ashique", "assets/users/user3.jpg"),
                buildFollowingCard("Ra Vien", "assets/users/user4.jpg"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildFollowingCard(userName, userImage) {
    return Container(
      height: 80,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage(userImage),
            radius: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              userName,
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
