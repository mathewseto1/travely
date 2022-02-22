import 'package:flutter/material.dart';
import 'package:testmvc/screen/date_screen.dart';
import 'package:testmvc/screen/destination_screen.dart';
import 'package:testmvc/screen/final_price.dart';
import 'package:testmvc/Controller.dart' show Controller;
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class BudgetScreen extends StatefulWidget {
  @override
  State<BudgetScreen> createState() => BudgetView();
}

class BudgetView extends State<BudgetScreen> {
  void initState() {
    super.initState();
    print("was started");
    con.checkBudgetController();
  }

  final Controller con = Controller();
  @override
  Widget build(BuildContext context) {
    Color c = const Color(0xFF10b8e1);
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
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                onChanged: (text) {
                  con.updateBudgetController(text);
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: "Budget",
                  hintText: 'Enter your budget in NZD',
                  // errorText: con.validateInput,
                  errorText: con.budgetErrorText,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                checkBudgetInput();
              },
              child: const Text('Next'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DestinationScreen()),
                );
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }

  void checkBudgetInput() {
    if (con.budgetInput.isEmpty) {
      con.checkBudgetController();
    } else if (con.budgetInput.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DateScreen()),
      );
    }
  }
}
