import 'package:flutter/material.dart';
import '../components/card.dart';
import '../utils.dart';

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';

class AnimalsPage extends StatefulWidget {
  AnimalsPage({Key key}) : super(key: key);

  @override
  _AnimalsPageState createState() => _AnimalsPageState();
}

class _AnimalsPageState extends State<AnimalsPage> {
  static const List<String> sections = ["Cats", "Dogs", "Birds", "Other"];

  DocumentSnapshot docSnapshot;
  String currentSection = "Dogs";
  Position _currentPosition;

  void initState() {
    super.initState();
    updateLocation();
    updateCardsList();
  }

  updateCardsList() {
    getCardsList().then((results) {
      setState(() {
        docSnapshot = results;
      });
    });
  }

  updateLocation() async {
    // final location = await _determinePosition();
    // setState(() {
    //   _currentPosition = location;
    // });
  }

  //get firestore instance
  getCardsList() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection('Animals')
        .doc(currentSection)
        .get();
  }

  getCurrentCollection() {
    Firebase.initializeApp();
    return FirebaseFirestore.instance.collection('Animals');
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    print("Determine position");
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      print("Request location permissions");
      ;

      PermissionStatus permission =
          await LocationPermissions().checkPermissionStatus();
      if (permission != PermissionStatus.granted) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
      print(permission);
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: new Container(
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                              radius: 36,
                              backgroundColor: hexToColor("#F5F5FA"),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://unsplash.com/photos/kmMcoPif0bc/download?force=true&w=640'),
                                radius: 32,
                              ))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Center(
                      child: Icon(Icons.location_pin, color: Colors.purple),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text.rich(
                        TextSpan(
                          text: "New York city",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: hexToColor("#333333")),
                        ),
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 50.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: (sections
                        .map((title) => Row(children: [
                              FlatButton(
                                  splashColor: hexToColor("#F0EEEE"),
                                  highlightColor: Colors.transparent,
                                  onPressed: () {
                                    setState(() {
                                      currentSection = title;
                                    });
                                    updateCardsList();
                                    print("PRESSED " + title);
                                    // Navigator.pushNamed(context, '/a');
                                  },
                                  child: Container(
                                      width: 100.0,
                                      child: Center(
                                          child: Text.rich(TextSpan(
                                              text: title,
                                              style: TextStyle(
                                                  fontFamily: "Lato",
                                                  color:
                                                      hexToColor("#7878AB"))))),
                                      decoration: BoxDecoration(
                                          color: hexToColor("#F5F5FA"),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))))),
                            ]))
                        .toList()),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                            child: ListView(
                          scrollDirection: Axis.vertical,
                          children: (docSnapshot != null
                              ? docSnapshot.data() != null
                                  ? docSnapshot.data()[currentSection] != null
                                      ? enumerate(
                                          docSnapshot.data()[currentSection],
                                          (index, dog) {
                                          print(index);
                                          var docRef = getCurrentCollection()
                                              .document(currentSection);
                                          return Center(
                                              child: AnimalCard(
                                            docRef: (updatedDog) {
                                              var data = docSnapshot.data();
                                              data[currentSection][index] =
                                                  updatedDog;
                                              print(updatedDog);
                                              docRef.set(data);
                                              updateCardsList();
                                            },
                                            likes: dog["likes"],
                                            sex: dog["sex"],
                                            name: dog["name"],
                                            text: dog["text"],
                                            city: dog["city"],
                                            photo: dog["photo"],
                                          ));
                                        }).toList()
                                      : [
                                          Center(
                                              child: Text.rich(TextSpan(
                                                  text: "Loading",
                                                  style: TextStyle(
                                                      fontFamily: "Lato",
                                                      fontSize: 20,
                                                      color: hexToColor(
                                                          "#7878AB")))))
                                        ]
                                  : [
                                      Center(
                                          child: Text.rich(TextSpan(
                                              text:
                                                  "There are no ${currentSection}",
                                              style: TextStyle(
                                                  fontFamily: "Lato",
                                                  fontSize: 20,
                                                  color:
                                                      hexToColor("#7878AB")))))
                                    ]
                              : [Text("Loading")]),
                        )))),
              ],
            )));
  }
}
