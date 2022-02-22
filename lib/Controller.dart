import 'dart:ffi';

import 'package:google_maps_webservice/places.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:testmvc/Model.dart';
import 'package:testmvc/Model.dart' show Model;
import 'package:testmvc/main.dart' show MyApp;

class Controller extends ControllerMVC {

  factory Controller() {
    return _this ??= Controller._();
  }
  static Controller? _this;

  Controller._();

  /// Allow for easy access to 'the Controller' throughout the application.
  static Controller get con => Controller.con;

  static final model = Model();



  int get counter => model.counter;

  String get budgetErrorText => model.budgetErrorText;

  String get budgetInput => model.budgetInput;

  Prediction get locationItem => model.location;

  // ###################################################
  // ###################################################

  String get startDateInput => model.startDateInput;
  String get endDateInput => model.endDateInput;

  // ###################################################
  // ###################################################
  Map<String, dynamic> get FinalPage => model.destinationJson;
  // ###################################################
  // ###################################################
  int get amountOfDays => model.amountOfDays;

  void setlocationcontroller(locationItem) {
    model.sendlocationmodel(locationItem);
  }

  void updateBudgetController(String Budget) {
    model.updateBudgetModel(Budget);
  }

  void budget(String budgetItem) {
    model.getbudget(budgetItem);
  }

  void checkBudgetController() {
    model.checkBudgetmodel();
  }

  void updateDateController(String startDate, String endDate) {
    model.updateDateModel(startDate, endDate);
  }


  Future<String> pricePageController() {
    Future<String> testing = model.priceStuffModel();
    return testing;
  }


}
