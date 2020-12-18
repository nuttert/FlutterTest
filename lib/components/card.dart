import 'package:flutter/material.dart';
import '../utils.dart';
import 'package:like_button/like_button.dart';
import '../pages/animal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalCard extends StatefulWidget {
  const AnimalCard({
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
  _CardState createState() => _CardState();
}

class _CardState extends State<AnimalCard> {
  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width - 70.0;
    final cardHeight = 150.0;

    return Column(children: [
      Center(
          child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return AnimalPage(
                    docRef: widget.docRef,
                    likes: widget.likes,
                    sex: widget.sex,
                    name: widget.name,
                    city: widget.city,
                    photo: widget.photo,
                    text: widget.text,
                  );
                }));
              },
              child: Container(
                  width: cardWidth,
                  height: cardHeight,
                  child: Row(children: [
                    Center(
                        child: Container(
                            width: cardWidth / 2,
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    alignment: Alignment.centerLeft,
                                    image: NetworkImage(widget.photo),
                                    fit: BoxFit.fitHeight)))),
                    Center(
                        child: Container(
                            width: cardWidth / 2,
                            height: cardHeight,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
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
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Lato",
                                                color: hexToColor("#333333")))),
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    LikeButton(),
                                                    SizedBox(width: 20),
                                                  ]),
                                            )),
                                      ]),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Icon(Icons.location_pin,
                                            color: hexToColor("#BDBDBD")),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text.rich(
                                          TextSpan(
                                            text: widget.city,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal,
                                                color: hexToColor("#333333")),
                                          ),
                                          style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          child: Flexible(
                                              child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        strutStyle: StrutStyle(fontSize: 12.0),
                                        text: TextSpan(
                                            style:
                                                TextStyle(color: Colors.black),
                                            text: widget.text),
                                      )))
                                    ],
                                  ),
                                ]))),
                  ]),
                  decoration: BoxDecoration(
                      color: hexToColor("#F5F5FA"),
                      borderRadius: BorderRadius.all(Radius.circular(15)))))),
      SizedBox(height: 55),
    ]);
  }
}
