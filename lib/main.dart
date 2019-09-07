import 'dart:async';

import 'package:diagonal_scrollview/diagonal_scrollview.dart';
import 'package:dooboo_world/World.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final double _boxSize = 2000.0;
  final Color _boxColor = Colors.white70;
  Positioned fp = null;

  double _c= 10 ;
  List<Widget> _getChildren() {
    List<Widget> children = [];
    Color childColor = Colors.blueGrey;
    double childSize = 100.0;
    double childMargin = 1;
    double tmpNumChildrenRow = _boxSize / childSize;
    num numChildren = (_boxSize - tmpNumChildrenRow * childMargin) / childSize;

    for (num x = 0; x < numChildren; x++) {
      for (num y = 0; y < numChildren; y++) {
        Widget cube = Container(
          width: childSize,
          height: childSize,
          color: childColor,
          child: (x+y) % 2 ==0 ? SvgPicture.asset("assets/duckboon.svg") : SvgPicture.asset("assets/ducktack.svg"),
//          child: (x+y) % 2 ==0 ? Image.asset("assets/duckboon.png") : Image.asset("assets/ducktack.png"),
//          child: SvgPicture.asset("assets/duckboon.svg"),
//          child:  Center(child: Text("x:${x}, y:${y}")),
        );
        Positioned positioned = Positioned(
          left: childMargin + (childMargin + childSize) * x,
          top: childMargin + (childMargin + childSize) * y,
          child: cube,
        );
        if(fp==null){
          fp = positioned;
        }
        children.add(positioned);
      }
    }

    return children;
  }


  @override
  void initState() {
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      print(DateTime.now());
      setState(() {
        _c = _c + 5;
      });
    });
//    Timer(Duration(seconds: 3), () {
//      print("Yeah, this line is printed after 3 seconds");
//    });
//    init();
  }
  init() async{
//    var url = "https://raw.githubusercontent.com/dnfield/flutter_svg/master/example/assets/dart.svg";
    var url = "https://twitter.com/search?q=%23%EB%91%90%EB%B6%80%EC%84%B8%EC%83%81&src=typed_query";

    // Await the http get response, then decode the json-formatted responce.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print("--->  ${response.body}");
//      var jsonResponse = convert.jsonDecode(response.body);
//      var itemCount = jsonResponse['totalItems'];
//      print("Number of books about http: $itemCount.");
    } else {
//      print("Request failed with status: ${response.statusCode}.");
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
//      body: Center(child: SvgPicture.asset("assets/dart.svg")),
//      body: Center(child: SvgPicture.asset("assets/camera2.svg")),
//      body: Center(child: SvgPicture.asset("assets/ducktack.svg")),
//      body: Center(child: SvgPicture.asset("assets/duckboon.svg")),
      body: DiagonalScrollView(
        enableFling: true,
        enableZoom: true,
        maxHeight: _boxSize,
        maxWidth: _boxSize,
        child: Container(
          width: _boxSize,
          height: _boxSize,
          color: _boxColor,
          child: Stack(
            children: _getChildren()..add(Positioned(
              left: _c - 100,
              top: _c - 100,
              child: SvgPicture.asset("assets/ducktack.svg"),
            )),
          ),
        ),
      ),
    );
  }
}
