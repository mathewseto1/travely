import 'package:flutter/material.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:testmvc/Controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import 'package:testmvc/screen/login_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  runApp(MyApp(key: const Key('MyApp')));
}

/// Main or first class to pass to the 'main.dart' file's runApp() function.
class MyApp extends AppMVC {
  /// Assign a 'fake' Controller to use in Unit Testing.
  MyApp({Key? key}) : super(key: key, con: FakeAppController());

  static String? homeStateKey;

  /// Supply an 'object' to be passed all the way down the Widget tree.
  @override
  Widget build(BuildContext context) => const AppView();
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => View();
}

class View extends ViewMVC<AppView> {
  factory View() => _this ??= View._();

  /// Demonstrate passing an 'object' down the Widget tree
  /// like in the Scoped Model
  View._()
      : super(
          controller: FakeAppController(),
          object: const Text(
            'Hello World!',
            style: TextStyle(color: Colors.red),
          ),
        );
  static View? _this;

  /// Allow for external access to is object.
  static View? get instance => _this;

  @override
  Widget buildApp(BuildContext context) => MaterialApp(
          home: MyHomePage(
        key: const Key('MyHomePage'),
        title: 'MVC Pattern Demo',
      ));

  /// Supply an error handler for Unit Testing.
  @override
  void onError(FlutterErrorDetails details) {
    /// Error is now handled.
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title = 'Flutter Demo'}) : super(key: key) {
    /// Creating a ambiguous StateMVC object merely for testing purposes.
    SecondState();
  }
  // Fields in a StatefulWidget should always be "final".
  final String title;

  @override
  // ignore: no_logic_in_create_state
  State createState() => MyHomePageState();
}

/// The State object is extended by its 'MVC version', StateMVC.
class MyHomePageState extends StateMVC<MyHomePage> {
  MyHomePageState() : super(Controller()) {
    /// Acquire a reference to the particular Controller.
    con = controller as Controller;

    /// For Unit testing. Adding a listener object to this State object.
    final listener = ListenTester();
    addAfterListener(listener);
    addBeforeListener(listener);
  }
  late Controller con;

  @override
  void initState() {
    super.initState();

    /// Testing the Controller's initState();
    con.initState();

    /// For testing purposes, supply this StateMVC object's unique identifier
    /// to its StatefulWidget.
    MyApp.homeStateKey = keyId;
  }

  @override
  Widget build(BuildContext context) {
    Color c = const Color(0xFF10b8e1);
    // print(dotenv.env.toString());
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
              padding: EdgeInsets.fromLTRB(0, 20, 0, 140),
              child: Icon(
                FontAwesome.paper_plane,
                color: Colors.white,
                size: 54.0,
                semanticLabel: 'Company Logo',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.fromLTRB(40, 00, 40, 0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }

  /// Supply an error handler for Unit Testing.
  @override
  void onError(FlutterErrorDetails details) {
    /// Error is now handled.
  }
}

class ListenTester with StateListener {
  factory ListenTester() => _this ??= ListenTester._();
  ListenTester._();
  static ListenTester? _this;

  /// Initialize any 'time-consuming' operations at the beginning.
  /// Initialize asynchronous items essential to the Mobile Applications.
  /// Typically called within a FutureBuilder() widget.
  @override
  Future<bool> initAsync() async => true;

  /// Supply an 'error handler' routine if something goes wrong
  /// in the corresponding initAsync() routine.
  /// Returns true if the error was properly handled.
  @override
  bool onAsyncError(FlutterErrorDetails details) {
    return false;
  }

  /// The framework will call this method exactly once.
  /// Only when the [StateMVC] object is first created.
  @override
  void initState() {}

  /// The framework calls this method whenever it removes this [StateMVC] object
  /// from the tree.
  @override
  void deactivate() {}

  /// The framework calls this method when this [StateMVC] object will never
  /// build again.
  /// Note: THERE IS NO GUARANTEE THIS METHOD WILL RUN in the Framework.
  @override
  void dispose() {
    super.dispose();
  }

  // ignore: comment_references
  /// Override this method to respond when the [widget] changes (e.g., to start
  /// implicit animations).
  @override
  void didUpdateWidget(StatefulWidget oldWidget) {}

  /// Called when a dependency of this [StateMVC] object changes.
  @override
  void didChangeDependencies() {}

  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  @override
  void reassemble() {}

  /// Called when the system tells the app to pop the current route.
  /// For example, on Android, this is called when the user presses
  /// the back button.
  @override
  Future<bool> didPopRoute() async => true;

  /// Called when the host tells the app to push a new route onto the
  /// navigator.
  @override
  Future<bool> didPushRoute(String route) async => true;

  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  @override
  void didChangeMetrics() {}

  /// Called when the platform's text scale factor changes.
  @override
  void didChangeTextScaleFactor() {}

  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {}

  /// Called when the system tells the app that the user's locale has changed.
  @override
  void didChangeLocale(Locale locale) {}

  /// Called when the system puts the app in the background or returns the app to the foreground.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  /// Called when the system is running low on memory.
  @override
  void didHaveMemoryPressure() {}

  /// Called when the system changes the set of active accessibility features.
  @override
  void didChangeAccessibilityFeatures() {}
}

/// A fake StateMVC object for testing purposes.
class SecondState extends StateMVC<MyHomePage> {
  factory SecondState() => _this ??= SecondState._();

  /// Pass 'null' to test the Controller with a null State object.
  // SecondState._() : super(Controller(null));
  SecondState._() : super(Controller());
  static SecondState? _this;

  @override
  Widget build(BuildContext context) => const Center();
}

/// A fake Controller object for testing purposes.
class FakeController extends ControllerMVC {
  factory FakeController() => _this ??= FakeController._();
  FakeController._();
  static FakeController? _this;
}

/// A fake 'App' Controller object for testing purposes.
class FakeAppController extends AppConMVC {
  factory FakeAppController() => _this ??= FakeAppController._();
  FakeAppController._();
  static FakeAppController? _this;

  /// Supply an error handler for Unit Testing.
  @override
  void onError(FlutterErrorDetails details) {
    super.onError(details);

    /// Error is now handled.
  }
}
