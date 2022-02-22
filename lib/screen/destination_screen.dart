import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:testmvc/Controller.dart' show Controller;

import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:testmvc/screen/budget_screen.dart';
import 'package:testmvc/screen/login_screen.dart';

class DestinationScreen extends StatefulWidget {
  @override
  // State<DestinationScreen> createState() => DestnationView();
  _DestnationView createState() => _DestnationView();
}

class _DestnationView extends State<DestinationScreen> {
  final TextEditingController textController = TextEditingController();
  // String kGoogleApiKey = "AIzaSyCVYN-T13FmdsrZi8qMTWugc2Or0ABlAb0";
  final Controller con = Controller();
  final GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: "AIzaSyCVYN-T13FmdsrZi8qMTWugc2Or0ABlAb0");

  @override
  Widget build(BuildContext context) {
    Color c = const Color(0xFF10b8e1);
    return Scaffold(
      backgroundColor: c,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 110, 20, 9),
                    child: Text('Travely',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)))),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 70),
              child: Icon(
                FontAwesome.paper_plane,
                color: Colors.white,
                size: 54.0,
                semanticLabel: 'Company Logo',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 40),
              child: TextField(
                controller: textController,
                onTap: handlePressButton,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Location'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BudgetScreen()),
                );
              },
              child: const Text('Next'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: "AIzaSyCVYN-T13FmdsrZi8qMTWugc2Or0ABlAb0",
      radius: 10000000,
      types: [],
      strictbounds: false,
      mode: Mode.overlay,
      language: "en",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "nz")],
    );
    textController.value = textController.value.copyWith(
      text: p!.description.toString(),
    );
    sendPrediction(p);
  }

  Future<Null> sendPrediction(Prediction? p) async {
    if (p != null) {
      con.setlocationcontroller(p);
    }
  }
}

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Container(
//       alignment: Alignment.center,
//       child: ElevatedButton(
//         onPressed: () async {
//           Prediction? p = await PlacesAutocomplete.show(
//             context: context,
//             apiKey: "AIzaSyCVYN-T13FmdsrZi8qMTWugc2Or0ABlAb0",
//             radius: 10000000,
//             types: [],
//             strictbounds: false,
//             mode: Mode.overlay,
//             language: "en",
//             decoration: InputDecoration(
//               hintText: 'Search',
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 borderSide: BorderSide(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             components: [Component(Component.country, "nz")],
//           );
//           // displayPrediction(p);
//           // before we just executed the function but we want to execute funcitons after all screens.
//           // con.location(p);
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(builder: (context) => BudgetScreen()),
//           // );
//         },
//         child: Text('Find address'),
//       ),
//     ),
//   );
// }

// old method that prints the longtitude and latitude
// Future<Null> displayPrediction(Prediction? p) async {
//   if (p != null) {
//     PlacesDetailsResponse detail =
//         await _places.getDetailsByPlaceId(p.placeId.toString());

//     double lat = detail.result.geometry!.location.lat;
//     double lng = detail.result.geometry!.location.lng;
//   }
// }

// this passes information to the controller
  // Future<Null> displayPrediction(Prediction? p) async {
  //   if (p != null) {
  //     print("this is the place id");
  // print(p.description);
  // con.location(p.description);
  // }































// #####################################################
// #####################################################
// #####################################################
// #####################################################
// OLD METHOD NEED TO MAKE THE SEARCH BAR WORK FIRST.

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: TextField(
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Destination',
//                     hintText: 'Enter your Destination'),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: null,
//               child: const Text('Next'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// #####################################################
// #####################################################