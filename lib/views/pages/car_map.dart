import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:redcar/utils/style.dart';
const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

class CarMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  new WebviewScaffold(
              url: "https://m.amap.com/",
              appBar: new AppBar(
                backgroundColor: Style.backgroundColor,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                centerTitle: true,
                title: new Text("汽车定位",style: Style.appBarTitleStyle,),
              ),
            );
     
  }
}
