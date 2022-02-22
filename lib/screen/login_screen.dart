// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:testmvc/screen/destination_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => LoginView();
}

class LoginView extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Color c = const Color(0xFF10b8e1);
    // print(dotenv.env.toString());
    return Scaffold(
      backgroundColor: c,
      body: Center(
        child: Column(
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
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                style: TextStyle(color: Color(0x000000)),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter your username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 40),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password'),
              ),
            ),
            ElevatedButton(
              onPressed: null,
              child: const Text('Login'),
            ),
            ElevatedButton(
              // onPressed: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => DestinationScreen()),
              //   );
              // },
              // onPressed: () {},
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DestinationScreen()),
                );
              },
              child: const Text('Skip'),
            ),
          ],
        ),
      ),
    );
  }
}
