// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:testmvc/Controller.dart' show Controller;

class AccomdationListPage extends StatefulWidget {
  @override
  State createState() => new AcommdationListPageState();
}

class AcommdationListPageState extends State<AccomdationListPage> {
  final Controller con = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
      child: new Center(
        child: new FutureBuilder(
            future: (null),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (con.FinalPage["low"]["hotels"] != []) {
                return new ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("hi hello there"),
                    );
                  },
                  itemCount: con.FinalPage["low"]["hotels"] == []
                      ? 0
                      : con.FinalPage["low"]["hotels"].length,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    ));
  }
}
