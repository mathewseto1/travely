// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:testmvc/screen/budget_screen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:testmvc/Controller.dart' show Controller;
import 'package:testmvc/screen/final_price.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class DateScreen extends StatefulWidget {
  @override
  _DateView createState() => _DateView();
}

class _DateView extends State<DateScreen> {
  String startdate = DateTime.now().toString();
  String _storeStartDate = '1/1/2021';
  String _storeEndDate = '1/1/2021';
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
            Center(
                child: Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(
                      "Start Date",
                    ))),
            DateTimePicker(
              type: DateTimePickerType.date,
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              decoration: InputDecoration(
                // hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                fillColor: Colors.white,
                filled: true,
              ),
              dateMask: 'd MMM, yyyy',
              // controller: _controller1,
              //initialValue: _initialValue,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: Icon(Icons.event),
              onChanged: (val) => _storeStartDate = val,
              // dateLabelText: 'Start Date',
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
            ),
            Center(
                child: Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(
                      "End Date",
                    ))),
            // Text("end date"),
            DateTimePicker(
                type: DateTimePickerType.date,
                dateMask: 'd MMM, yyyy',
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                decoration: InputDecoration(
                  // hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white,
                  filled: true,
                ),
                //########################################################
                // fieldLabelText:        // style: TextStyle(decorationColor: Colors.black),
                // controller: _controller1,
                //initialValue: _initialValue,
                firstDate: DateTime(2021),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                onChanged: (val) => _storeEndDate = val,
                validator: (value) {
                  return value!.contains(':') ? 'Do not use the : char.' : null;
                },
                // selectableDayPredicate: _decideWhichDayToEnable,
                // dateLabelText: 'End Date',
                style: TextStyle(color: Colors.black)),
            ElevatedButton(
              onPressed: () {
                _handleNextDatePressed(_storeStartDate, _storeEndDate)
                    .then(Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FinalPrice()),
                ));
              },
              child: const Text('Next'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BudgetScreen()),
                );
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }

  _handleNextDatePressed(startDate, endDate) {
    con.updateDateController(startDate, endDate);
  }
  // bool _decideWhichDayToEnable(DateTime day) {
  //   const oneDay = 24 * 60 * 60 * 1000;
  //   DateTime date1 = DateTime.parse(startdate);
  //   DateTime date2 = DateTime.now();
  //   int difference1 = (date2.difference(date1).inHours / 24).round(); //-1
  //   int difference2 = (date1.difference(date2).inHours / 24).round(); //1
  //   print(difference1);
  //   var dDay = DateTime.utc(2021, 10, 18);
  //   // if ((day.isAfter(DateTime.now().subtract(Duration(days: 2))) &&
  //   //     day.isBefore(DateTime.now().add(Duration(days: 2))))) {
  //   if (dDay.isAfter(date2)) {
  //     return true;
  //   }
  //   return false;
  // }
}






// ######################################
// ######################################
// ######################################
//OLD BUTTON

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Welcome to Flutter',
  //     home: Scaffold(
  //       appBar: AppBar(
  //         title: const Text('Welcome to Flutter'),
  //       ),
  //       body: const Center(
  //         child: Text('Date Page'),
  //       ),
  //     ),
  //   );
  // }

// ######################################
// ######################################
// ######################################
