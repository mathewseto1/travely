// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:testmvc/Controller.dart' show Controller;
import 'package:testmvc/screen/accomdation.dart';

class PremiumListPage extends StatefulWidget {
  PremiumListPage({Key? key}) : super(key: key);

  @override
  PremiumListPageState createState() => PremiumListPageState();
}

class PremiumListPageState extends State<PremiumListPage> {
  final Controller con = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // ignore: avoid_unnecessary_containers, unnecessary_new
        body: new Container(
      // ignore: unnecessary_new
      child: new Center(
        // ignore: unnecessary_new
        child: new FutureBuilder(
            future: (null),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (con.FinalPage["high"]["hotels"] != []) {
                return new ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    var hotel_list = '';
                    var attraction_list = '';

                    (con.FinalPage["high"]["hotels"]).forEach((value) => {
                          hotel_list = hotel_list +
                              '${value.last.toString()}    \$${value[0].toString()} \n\n'
                        });

                    (con.FinalPage["high"]["attractions"]).forEach((value) => {
                          attraction_list = attraction_list +
                              '${value.last.toString()}    \$${value[0].toString()} \n\n'
                        });

                    return new Card(
                        child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                          ListTile(
                            title: Text('Accomdation\n'),
                            subtitle: Text(hotel_list),
                          ),
                          ListTile(
                            title: Text('Attractions\n'),
                            subtitle: Text(attraction_list),
                          ),
                        ]));
                  },
                  itemCount: con.FinalPage["low"]["hotels"] == [] ? 0 : 1,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    ));
  }
}
