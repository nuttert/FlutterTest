// import 'dart:html';

import 'package:flutter/material.dart';
import 'components/card.dart';
import 'utils.dart';

import 'pages/animals.dart';
import 'pages/home.dart';

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key) {}
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Database db;
  String last_visit;

  _MyAppState() {
    openDatabase('time.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Time (time TEXT);');
    }).then((dbF) {
      setState(() {
        var now = new DateTime.now();
        db = dbF;
        db
            .rawInsert("INSERT INTO Time(time) VALUES ('${now}')")
            .then((e) async {
          db.rawQuery('SELECT * FROM Time').then((list) {
            setState(() {
              if (list.length <= 1) {
                last_visit = null;
              } else
                last_visit = list[list.length - 2]["time"];
              print("LAST ${last_visit}");
            });
          });
          List<Map> list = await db.rawQuery('SELECT * FROM Time');
          print("Time '${now}' inserted into db");
          print("DB: '${list}'");
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Animals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(last_visit_str: last_visit),
      routes: <String, WidgetBuilder>{
        '/animals': (BuildContext context) => AnimalsPage(),
      },
    );
  }
}
