import 'package:flutter/material.dart';
import 'package:sortedmap/sortedmap.dart';
import 'dart:async';
import 'package:testmvc/Controller.dart' show Controller;
import 'package:testmvc/travel_plan.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testmvc/screen/plus_list.dart';
import 'package:testmvc/screen/premium_list.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class FinalPrice extends StatefulWidget {
  //old method.
  _FinalPriceView createState() => _FinalPriceView();
}

class _FinalPriceView extends State<FinalPrice> {
  final Controller con = Controller();
  String pathPDF = "";
  //new
  final int _pageCount = 2;
  int current_tab = 0;
  var _selectedPageIndex;
  List<Widget>? _pages;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();

    _selectedPageIndex = 0;
    _pages = [
      TravelListPage(),
      Text(
        'Index 1: Normal',
        style: optionStyle,
      ),
      Text(
        'Index 2: Luxury',
        style: optionStyle,
      ),
    ];

    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController?.dispose();

    super.dispose();
  }
  //new

  Future<String> callAsyncFetch() async => (await con.pricePageController());

  int currentTabIndex = 0;

  static const TextStyle optionStyle = TextStyle(fontSize: 15);

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  //##########################################
  //##########################################
  //##########################################
  //##########################################

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: callAsyncFetch(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData & (con.FinalPage["low"]["hotels"] != [])) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Your Itinerary'),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: _pressedDownload,
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  setState(() {
                    current_tab = index;
                  });
                },
                currentIndex: current_tab,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Budget travel',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.business),
                    label: 'Plus travel',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.money),
                    label: 'Premium travel',
                  ),
                ],
              ),
              body: IndexedStack(
                children: <Widget>[
                  TravelListPage(),
                  PlusListPage(),
                  PremiumListPage(),
                ],
                index: current_tab,
              ),
            );
          } else {
            return Scaffold(
                body: Center(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(child: CircularProgressIndicator())),
              ],
            )));
          }
        });
  }

  void _pressedDownload() {
    // var test1 = con.controllercreatePDF();
  }
}










































//###############################################################
//###############################################################
//###############################################################
//old method
//   @override
//   Widget build(context) {
//     Color c = const Color(0xFF10b8e1);
//     final ButtonStyle style =
//         TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
//     return FutureBuilder<String>(
//         future: callAsyncFetch(),
//         builder: (context, AsyncSnapshot<String> snapshot) {
//           if (snapshot.hasData & (con.FinalPage["low"]["hotels"] != [])) {
//             List<Widget> tabs = [
//               new TravelListPage(),
//               Text(
//                 'Index 1: Normal',
//                 style: optionStyle,
//               ),
//               Text(
//                 'Index 2: Luxury',
//                 style: optionStyle,
//               ),
//             ];

//             return Scaffold(
//               backgroundColor: c,
//               appBar: AppBar(
//                 title: const Text('Your Itinerary'),
//                 actions: <Widget>[
//                   IconButton(
//                     icon: const Icon(Icons.download),
//                     onPressed: _pressedDownload,
//                   ),
//                 ],
//               ),
//               body: Center(
//                 child: tabs[currentTabIndex],
//               ),

//               // body: IndexedStack(
//               //    index: currentTabIndex,
//               //   children: widget.screens,
//               // ),

//               bottomNavigationBar: BottomNavigationBar(
//                 items: const <BottomNavigationBarItem>[
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.home),
//                     label: 'Saving',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.business),
//                     label: 'Normal',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.school),
//                     label: 'Luxury',
//                   ),
//                 ],
//                 currentIndex: currentTabIndex,
//                 selectedItemColor: Colors.amber[800],
//                 onTap: onTapped,
//               ),
//             );
//           } else {
//             return Scaffold(
//                 body: Center(
//                     child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                     height: MediaQuery.of(context).size.height / 1.3,
//                     child: Center(child: CircularProgressIndicator())),
//               ],
//             )));
//           }
//         });
//   }

//   void _pressedDownload() {
//     var test1 = con.controllercreatePDF();
//   }


// }