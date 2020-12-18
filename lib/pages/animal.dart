import 'package:flutter/material.dart';
import '../components/card.dart';
import '../utils.dart';

import 'dart:async';
import 'package:like_button/like_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class AnimalPage extends StatefulWidget {
  AnimalPage({
    Key key,
    this.name,
    this.city,
    this.photo,
    this.text,
    this.sex,
    this.likes,
    this.docRef,
  }) : super(key: key);

  final void Function(Map<String, dynamic>) docRef;
  final int likes;
  final String sex;
  final String name;
  final String city;
  final String photo;
  final String text;

  @override
  _AnimalPageState createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  int likes;
  void initState() {
    super.initState();
    likes = widget.likes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: hexToColor("#FFFFFF"),
        appBar: AppBar(
          backgroundColor: hexToColor("#57419D"),
          title: Text("${likes} 💛"),
        ),
        floatingActionButton: Container(
            width: 55,
            height: 55,
            child: LikeButton(
              size: 50,
              isLiked: widget.likes != likes,
              onTap: (e) {
                widget.docRef({
                  "photo": widget.photo,
                  "name": widget.name,
                  "sex": widget.sex,
                  "city": widget.city,
                  "text": widget.text,
                  "likes": widget.likes + 1,
                });
                setState(() {
                  likes = (widget.likes + 1);
                });

                return Future<bool>(() => true);
              },
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(children: [
              Expanded(
                  flex: 1,
                  child: Center(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              image: DecorationImage(
                                  alignment: Alignment.center,
                                  image: AssetImage(
                                      "assets/images/background.png"),
                                  fit: BoxFit.cover)),
                          child: Column(children: [
                            SizedBox(height: 150),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Container(
                                    height: 250,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            alignment: Alignment.topRight,
                                            image:
                                                NetworkImage(widget.photo))))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 30),
                                      child: Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text.rich(TextSpan(
                                                    text: widget.name,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: "Lato",
                                                        color: hexToColor(
                                                            "#333333")))),
                                              ]),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Icon(Icons.location_pin,
                                                    color:
                                                        hexToColor("#BDBDBD")),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text.rich(
                                                  TextSpan(
                                                    text: widget.city,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: hexToColor(
                                                            "#333333")),
                                                  ),
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                  child: Container(
                                                      // color: Colors.black,
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color
                                                                  .fromARGB(
                                                                      50,
                                                                      255,
                                                                      255,
                                                                      255),
                                                              blurRadius: 10.0,
                                                              offset: Offset(
                                                                  -5, -5),
                                                            ),
                                                            BoxShadow(
                                                              color: Color
                                                                  .fromARGB(
                                                                      25,
                                                                      170,
                                                                      170,
                                                                      204),
                                                              blurRadius: 10,
                                                              offset:
                                                                  Offset(5, 5),
                                                            ),
                                                            BoxShadow(
                                                              color: Color
                                                                  .fromARGB(
                                                                      25,
                                                                      170,
                                                                      170,
                                                                      204),
                                                              blurRadius: 20,
                                                              offset: Offset(
                                                                  10, 10),
                                                            ),
                                                            BoxShadow(
                                                              color:
                                                                  Colors.white,
                                                              blurRadius: 20,
                                                              offset: Offset(
                                                                  -10, -10),
                                                            ),
                                                          ]),
                                                      child: CircleAvatar(
                                                          backgroundColor:
                                                              hexToColor(
                                                                  "#F5F5F9"),
                                                          backgroundImage:
                                                              AssetImage(
                                                                  "assets/images/kind.png")))),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text.rich(TextSpan(
                                                  text: widget.name,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "Lato",
                                                      color: hexToColor(
                                                          "#333333")))),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              CircleAvatar(
                                                  child: Container(
                                                      // color: Colors.black,
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color
                                                                  .fromARGB(
                                                                      50,
                                                                      255,
                                                                      255,
                                                                      255),
                                                              blurRadius: 10.0,
                                                              offset: Offset(
                                                                  -5, -5),
                                                            ),
                                                            BoxShadow(
                                                              color: Color
                                                                  .fromARGB(
                                                                      25,
                                                                      170,
                                                                      170,
                                                                      204),
                                                              blurRadius: 10,
                                                              offset:
                                                                  Offset(5, 5),
                                                            ),
                                                            BoxShadow(
                                                              color: Color
                                                                  .fromARGB(
                                                                      25,
                                                                      170,
                                                                      170,
                                                                      204),
                                                              blurRadius: 20,
                                                              offset: Offset(
                                                                  10, 10),
                                                            ),
                                                            BoxShadow(
                                                              color:
                                                                  Colors.white,
                                                              blurRadius: 20,
                                                              offset: Offset(
                                                                  -10, -10),
                                                            ),
                                                          ]),
                                                      child: CircleAvatar(
                                                          radius: 20.0,
                                                          backgroundColor:
                                                              hexToColor(
                                                                  "#F5F5F9"),
                                                          backgroundImage:
                                                              AssetImage(
                                                            "assets/images/sex.png",
                                                          )))),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text.rich(TextSpan(
                                                  text: widget.sex.capitalize(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "Lato",
                                                      color: hexToColor(
                                                          "#333333")))),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  child: Flexible(
                                                      child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                strutStyle:
                                                    StrutStyle(fontSize: 12.0),
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    text: widget.text),
                                              )))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ))),
                          ]))))
            ])));
  }
}
