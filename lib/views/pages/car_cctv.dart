import 'package:flutter/material.dart';
import 'package:redcar/utils/style.dart';

class CarCctv extends StatefulWidget {
  @override
  _CarCctvState createState() => _CarCctvState();
}

class _CarCctvState extends State<CarCctv> {
  bool x=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xFF1E1E1E),
        centerTitle: true,
        title: Text(
          "监控",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image:DecorationImage(image: NetworkImage("http://project-redspace.com/images/photo-subcar-seating.jpg", ),fit: BoxFit.fitHeight),
          ),
        child: Column(
          children: <Widget>[
          Container(
            
            height: MediaQuery.of(context).size.height/1.2,
            width:MediaQuery.of(context).size.width, 
            child: Stack(children: <Widget>[
               buildRow(), Positioned(
                 top: 20,
                 
                 child: buildButton(),) ],),)  
           ],
        ),
      ),
    );
  }

  Widget buildRow() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey),
      height: 30,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: 40,
          ),
          Text(
            DateTime.now().toString(),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 30,
          ),
          Icon(
            Icons.live_tv,
            color: Colors.blue,
          ),
          Text("实况", style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }

 

  Widget buildButton() {
    return Container(
     
      height: MediaQuery.of(context).size.height ,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 130,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Container(
            height: 80,
            width: 70,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Style.raisedbuttonColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 4,
                      color: Colors.orange[200])
                ]),
            child: FloatingActionButton(
              heroTag: 1,
              backgroundColor: Style.raisedbuttonColor ,
               child: Icon(Icons.add_alert,color: Colors.orange[200],size: 40,),
             onPressed: (){},

            ),
          ),
          Text("警报",style:TextStyle(color: Colors.orange[200]))
          ],)  ,
    
            SizedBox( height: 150,
              width: 120,child:  FloatingActionButton(
                heroTag: 2,
                elevation: 10,
                backgroundColor: Style.raisedbuttonColor ,
                child: Icon(Icons.keyboard_voice,color: Colors.greenAccent[200],size: 60,),
                onPressed: (){},
              ),) ,
       GestureDetector(onTap:(){
         setState(() {
           x=!x;
         });
       } ,child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Container(
            height: 80,
            width: 70,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Style.raisedbuttonColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 4,
                      color: Colors.orange[200])
                ]),
            child: AnimatedSwitcher(
              duration: Duration(seconds: 2),
              child: x?Image.asset("assets/film.png",height: 40,color:Colors.orange[200] ,)
            :Image.asset("assets/circle.png",height: 40,color:Colors.red ,)
            ),
          ),
          Text("录制",style:TextStyle(color: Colors.orange[200]))
          ],) ,)    ,
        ],
      ),
    );
  }
  
}
