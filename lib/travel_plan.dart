// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:testmvc/Controller.dart' show Controller;
import 'package:testmvc/screen/accomdation.dart';

class TravelListPage extends StatefulWidget {
  TravelListPage({Key? key}) : super(key: key);

  @override
  TravelListPageState createState() => TravelListPageState();
}

class TravelListPageState extends State<TravelListPage> {
  final Controller con = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // ignore: avoid_unnecessary_containers
        body: new Container(
      child: new Center(
        child: new FutureBuilder(
            future: (null),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (con.FinalPage["low"]["hotels"] != []) {
                return new ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    var accomadations = con.FinalPage["low"];
                    var hotel_list = '';
                    var attraction_list = '';

                    (con.FinalPage["low"]["hotels"]).forEach((value) => {
                          hotel_list = hotel_list +
                              '${value.last.toString()}    \$${value[0].toString()} \n\n'
                        });

                    (con.FinalPage["low"]["attractions"]).forEach((value) => {
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






//#####################################################################
//#####################################################################
//#####################################################################
//#####################################################################
//#####################################################################








//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // ignore: avoid_unnecessary_containers
//         body: new Container(
//       child: new Center(
//         child: new FutureBuilder(
//             future: (null),
//             builder: (context, AsyncSnapshot<String> snapshot) {
//               if (con.FinalPage["low"]["hotels"] != []) {
//                 return new ListView.builder(
//                   itemBuilder: (BuildContext context, int index) {
//                     var accomadations = con.FinalPage["low"];

//                     return ListTile(
//                       title: Text('Accomdation'),
//                       subtitle: Text(
//                           '${accomadations["hotels"][index].last.toString()} \t ${accomadations["hotels"][index][0].toString()}'),
//                     );
//                   },
//                   itemCount: con.FinalPage["low"]["hotels"] == []
//                       ? 0
//                       : con.FinalPage["low"]["hotels"].length,
//                 );
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             }),
//       ),
//     ));
//   }
// }














//#####################################################################
//#####################################################################
//#####################################################################
//#####################################################################
//#####################################################################
//#####################################################################
//#####################################################################
//#####################################################################

//OLD METHOD USING CARDS.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // ignore: avoid_unnecessary_containers
//         body: new Container(
//       child: new Center(
//         child: new FutureBuilder(
//             future: (null),
//             builder: (context, AsyncSnapshot<String> snapshot) {
//               if (con.FinalPage["low"]["hotels"] != []) {
//                 return new ListView.builder(
//                   itemBuilder: (BuildContext context, int index) {
//                     var accomadations = con.FinalPage["low"]["hotels"][index];
//                     return new Card(
//                       child: new Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: <Widget>[
//                           new Text("Accomdation",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 24)),
//                           new Text(
//                               con.FinalPage["low"]["hotels"][index].last
//                                   .toString(),
//                               style: TextStyle(
//                                   fontWeight: FontWeight.normal, fontSize: 20)),
//                           new Text(
//                               '\$ $con.FinalPage["low"]["hotels"][index][0]'
//                                   .toString(),
//                               style: TextStyle(
//                                   fontWeight: FontWeight.normal, fontSize: 20)),
//                         ],
//                       ),
//                     );
//                   },
//                   itemCount: con.FinalPage["low"]["hotels"] == []
//                       ? 0
//                       : con.FinalPage["low"]["hotels"].length,
//                 );
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             }),
//       ),
//     ));
//   }
// }
