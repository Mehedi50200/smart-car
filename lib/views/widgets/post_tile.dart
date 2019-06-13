import 'package:flutter/material.dart';

bool liked = false;

class PostTile extends StatefulWidget {
  const PostTile(
      this.userName, this.userImage, this.imageData, this.textData, this.like);
  final String userName;
  final AssetImage userImage;
  final AssetImage imageData;
  final String textData;
  final bool like;

  @override
  PostTileState createState() =>
      PostTileState(userName, userImage, imageData, textData, like);
}

class PostTileState extends State<PostTile> {
  PostTileState(
      this.userName, this.userImage, this.imageData, this.textData, this.like);
  final String userName;
  final AssetImage userImage;
  final AssetImage imageData;
  final String textData;
  final bool like;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return new Card(
      elevation: 15,
      color: Color(0x00FFFFFF),
      child: new InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            image: new DecorationImage(
              image: imageData,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      liked = !liked;
                      print(liked);
                    });
                  },
                  tooltip: 'like',
                  child: Icon(
                    Icons.favorite_border,
                    color: liked? Colors.white.withOpacity(0.80):Colors.red.withOpacity(0.80),
                  ),
                  backgroundColor: liked? Colors.red.withOpacity(0.6):Colors.white.withOpacity(0.6),
                  elevation: 0,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF000000).withOpacity(0.80),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        textData,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[100],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5),
                            child: CircleAvatar(
                                radius: 15.0, backgroundImage: userImage),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Text(
                              userName,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Text(
                              '09:30am',
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 12),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
