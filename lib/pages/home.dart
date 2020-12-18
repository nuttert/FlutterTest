import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import '../utils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final minWidth = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    final minHeight = max(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: hexToColor("#F5F5FA"),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(children: [
              SizedBox(height: height / 6),
              Center(
                  child: Container(
                      width: width,
                      height: 400,
                      decoration: BoxDecoration(
                          // color: Colors.red,
                          image: DecorationImage(
                              alignment: Alignment.centerLeft,
                              image: NetworkImage(
                                  "https://i.ibb.co/Br6Tvhp/Group-6812.png"),
                              fit: BoxFit.fitWidth)))),
              Text.rich(TextSpan(
                  text: "Pets",
                  style: TextStyle(
                      fontSize: 24,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Lato",
                      color: hexToColor("#333333")))),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text.rich(TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Text(
                              "Taking care of a pet is my favorite, it helps me to gaimr stress and fatigue.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Lato",
                                  color: hexToColor("#828282")))),
                    ],
                  ))),
              SizedBox(
                height: 40,
              ),
              FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: hexToColor("#57419D"),
                  splashColor: hexToColor("#F0EEEE"),
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    print("PRESSED");
                    Navigator.pushNamed(context, '/animals');
                  },
                  child: Container(
                    width: width - 90,
                    child: Center(
                        child: Text.rich(TextSpan(
                            text: "Find pets",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Lato",
                                color: hexToColor("#FFFFFF"))))),
                  ))
            ])));
  }
}
