import 'package:flutter/material.dart';
import 'package:redcar/views/widgets/post_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:redcar/utils/style.dart';

class Newsfeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeItem();
  }
}

double screenWidth;
double screenHeight;

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 3),
  const StaggeredTile.count(2, 3),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 3),
  const StaggeredTile.count(2, 3),
  const StaggeredTile.count(2, 2),
];

List<Widget> _tiles = const <Widget>[
  const PostTile(('Mehedi'), AssetImage('assets/users/user1.jpg'),
      AssetImage('assets/posts/post1.jpg'), ('小红车聚会'), true),
  const PostTile(('Tanvir'), AssetImage('assets/users/user2.jpg'),
      AssetImage('assets/posts/post2.jpg'), ('新车打折啦'),true),
  const PostTile(('Yusuf'), AssetImage('assets/users/user3.jpg'),
      AssetImage('assets/posts/post3.jpg'), ('收藏的地点'),false),
  const PostTile(('Faris'), AssetImage('assets/users/user4.jpg'),
      AssetImage('assets/posts/post4.jpg'), ('今天计划全乱了'),true),
  const PostTile(('Apu'), AssetImage('assets/users/user5.jpg'),
      AssetImage('assets/posts/post5.jpg'), ('新车打折啦'),true),
  const PostTile(('Dipu'), AssetImage('assets/users/user6.jpg'),
      AssetImage('assets/posts/post6.jpg'), ('开着车去吃好吃的！'),false),
  const PostTile(('Niloy'), AssetImage('assets/users/user7.jpg'),
      AssetImage('assets/posts/post7.jpg'), ('开车去兜兜风'),false),
  const PostTile(('Emon'), AssetImage('assets/users/user8.jpg'),
      AssetImage('assets/posts/post8.jpg'), ('开车，注意安全'),false),
];

class HomeItem extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeItem>
    with SingleTickerProviderStateMixin {
  bool visible = false;
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
      appBar: AppBar(
        title: Text('车友圈', style: Style.appBarTitleStyle),
        centerTitle: true,
        backgroundColor: Style.backgroundColor,
      ),
      floatingActionButton: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.translationValues(
                   -animation.value * screenWidth,0.0, 0.0),
              child:new FloatingActionButton(
        onPressed: () {
          setState(() {
            visible = !visible;
          });
        },
        tooltip: 'like',
        child: new Icon(
          Icons.add,
          color: Color(0xFFFFFFFF),
        ),
        backgroundColor: Style.raisedbuttonColor,
        elevation: 10,
      ),);}),
      body: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.translationValues(
                  0.0, -animation.value * screenHeight, 0.0),
              child: Container(
                color: Style.backgroundColor.withOpacity(0.5),
                child: Column(
                  children: <Widget>[
                    visible
                        ? Expanded(
                            flex: 2,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.fromLTRB(7, 10, 7, 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0x88858687),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 4,
                                    child: TextField(
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            hintText: 'whats on your mind',
                                            hintStyle: TextStyle(
                                                fontSize: 17.0,
                                                color: Colors.grey,
                                                fontStyle: FontStyle.italic),
                                            fillColor: Colors.blue),
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: 40.0,
                                      height: 40.0,
                                      child: new RawMaterialButton(
                                        shape: new CircleBorder(),
                                        elevation: 0.0,
                                        fillColor: Colors.black,
                                        child: new Icon(
                                          Icons.attach_file,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: 40.0,
                                      height: 40.0,
                                      child: new RawMaterialButton(
                                        shape: new CircleBorder(),
                                        elevation: 0.0,
                                        fillColor: Colors.black,
                                        child: new Icon(
                                          Icons.send,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            visible = !visible;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    Expanded(
                      flex: 4,
                      child: new StaggeredGridView.count(
                        crossAxisCount: 4,
                        staggeredTiles: _staggeredTiles,
                        children: _tiles,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        padding: const EdgeInsets.all(4.0),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
      
    );
  }
}
