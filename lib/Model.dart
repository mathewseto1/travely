import 'dart:collection';

import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:convert' show json;
import 'package:sortedmap/sortedmap.dart';
import 'package:quiver/iterables.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:core';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Model extends ModelMVC {
  // Model([StateMVC? state]) : super(state);
  Model([StateMVC? state]) : super(state);

  Prediction get location => _location;
  int get counter => _counter;
  int _counter = 0;
  Prediction _location = new Prediction();
  int incrementCounter() => ++_counter;
// ###################################################
// ###################################################
// ###################################################
  String get budgetInput => _budgetInput;
  String _budgetInput = '';
  // ###################################################
  // ###################################################
  String get budgetErrorText => _budgetErrorText;
  String _budgetErrorText = '';
  // ###################################################
  // ###################################################
  String get startDateInput => _startDateInput;
  String _startDateInput = '1/1/2021';
  String get endDateInput => _endDateInput;
  String _endDateInput = '1/1/2021';
  int get amountOfDays => _amountOfDays;
  int _amountOfDays = 0;
  int get running_count => _counter;
  int _running_count = 0;
  // ###################################################
  // ###################################################
  String get lngInput => _lngInput;
  String get latInput => _latInput;
  String _lngInput = '';
  String _latInput = '';
  // ###################################################
  // ###################################################
  Map<String, dynamic> get destinationJson => _destinationJson;
  Map<String, dynamic> _destinationJson = {
    "low": {"hotels": [], "attractions": []},
    "medium": {"hotels": [], "attractions": []},
    "high": {"hotels": [], "attractions": []}
  };

  void sendlocationmodel(received) async {
    print("hello this is send location");
    this._location = received;
    final GoogleMapsPlaces _places =
        GoogleMapsPlaces(apiKey: dotenv.env['GOOGLE_MAP_PLACES_API']);

    if (received != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(received.placeId.toString());

      double lat = detail.result.geometry!.location.lat;
      double lng = detail.result.geometry!.location.lng;
      // _lngInput = lng.toString();
      // _latInput = lat.toString();
      _lngInput = lng.toStringAsFixed(2);
      _latInput = lat.toStringAsFixed(2);
    }
  }

  void updateBudgetModel(BudgetValue) {
    this._budgetInput = BudgetValue;
  }

  void getbudget(budget) {
    print(budget);
  }

  void checkBudgetmodel() {
    if (_budgetInput == 'Starting') {
      _budgetErrorText;
    } else if (_budgetInput.isEmpty) {
      _budgetErrorText = "Please enter your budget";
    }
  }

  void updateDateModel(startDate, endDate) {
    _startDateInput = startDate;
    _endDateInput = endDate;
  }

  Future<String> priceStuffModel() async {
    if (_running_count == 0) {
      await attractionApi();

      return 'Done';
    } else {
      return 'nothing';
    }
  }

  Future<void> attractionApi() async {
    await dotenv.load();
    String rapid_api = dotenv.get('RAPID_API_KEY');
    var list_of_attractions = [];
    var list_of_most_expensive_flights = [];
    var list_of_hotels = [];

    try {
      var uri = Uri.parse(
          "https://travel-advisor.p.rapidapi.com/attractions/list-by-latlng?longitude=${_lngInput}&latitude=${_latInput}&lunit=km&currency=NZD&lang=en_US");

      http.Response response = await http.get(uri, headers: {
        "x-rapidapi-host": "travel-advisor.p.rapidapi.com",
        "x-rapidapi-key": rapid_api
      });

      var hoteluri = Uri.parse(
          "https://travel-advisor.p.rapidapi.com/hotels/list-by-latlng?latitude=${_latInput}&longitude=${_lngInput}&lang=en_US&adults=1&rooms=1&currency=NZD&distance=9007199254740991");

      http.Response hotel_response = await http.get(hoteluri, headers: {
        "x-rapidapi-host": "travel-advisor.p.rapidapi.com",
        "x-rapidapi-key": rapid_api
      });

      Map<String, dynamic> data = json.decode(response.body);
      Map<String, dynamic> hotelData = json.decode(hotel_response.body);

      list_of_most_expensive_flights = [
        [
          [0, "Airport 1", 100, 250, 1000],
          [1, "Airport 2", 80, 200]
        ],
        [
          [0, "Airport 1", 100, 250, 1000],
          [1, "Airport 2", 200, 600, 1000]
        ]
      ]; //this holds selection for flight to place and return.

//this is the attraction section
      data["data"].asMap().forEach((index, value) =>
          value.containsKey("offer_group") == true
              ? addAttraction(list_of_attractions, index, value)
              : null);
      list_of_attractions.sort((a, b) => a[0].compareTo(b[0]));

//this is the hotel api section
      hotelData["data"].asMap().forEach((index, value) =>
          value.containsKey('price') == true
              ? addHotel(list_of_hotels, index, value)
              : null);

      list_of_hotels.sort((a, b) => a[0].compareTo(b[0]));
    } catch (e) {
      print(e);
    }
    //generating the json to be sent back to the display.
    int count = 0;

    const oneDay = 24 * 60 * 60 * 1000;
    DateTime startDateConverted = DateTime.parse(_startDateInput);
    DateTime endDateConverted = DateTime.parse(_endDateInput);
    final totalNumberofDays =
        endDateConverted.difference(startDateConverted).inDays +
            1; //want to include the arrival and departure date
    final flightDays = 2;
    int hotelAndAttractionDays = totalNumberofDays - flightDays;
    _amountOfDays = hotelAndAttractionDays;

    populateLow(list_of_hotels, list_of_attractions, hotelAndAttractionDays);
    _running_count = _running_count + 1;
  }

  populateLow(list_of_hotels, list_of_attractions, hotelAndAttractionDays) {
    var temp_days = hotelAndAttractionDays;

    var testing = _destinationJson["low"]["hotels"];
    for (int i = 0; i < hotelAndAttractionDays; i++) {
      // print("inside the for loop");
      _destinationJson["low"]["hotels"].add(list_of_hotels[i]);

      _destinationJson["low"]["attractions"].add(list_of_attractions[i]);

      int tempHotelInt = list_of_hotels.length - i - 1;
      int tempAttractionInt = list_of_attractions.length - i - 1;

      _destinationJson["high"]["hotels"]
          .insert(0, list_of_hotels[tempHotelInt]);

      _destinationJson["high"]["attractions"]
          .insert(0, list_of_attractions[tempAttractionInt]);
    }

    //getting the middle of the hotels and attraction.
    var temp_hotels = list_of_hotels.sublist(hotelAndAttractionDays + 1,
        (list_of_hotels.length - hotelAndAttractionDays - 1));

    var temp_attractions = list_of_attractions.sublist(
        hotelAndAttractionDays + 1,
        (list_of_attractions.length - hotelAndAttractionDays - 1));

    _destinationJson["medium"]["hotels"] =
        temp_hotels.sublist(0, hotelAndAttractionDays);

    _destinationJson["medium"]["attractions"] =
        temp_attractions.sublist(0, hotelAndAttractionDays);

    // #########################################################
    // #########################################################
    //##########################################################
  }

  addAttraction(list_of_attractions, index, value) {
    var temp1 = value["offer_group"]["lowest_price"].toString().substring(
        value["offer_group"]["lowest_price"].indexOf('\$') + 1,
        value["offer_group"]["lowest_price"].toString().length);

    list_of_attractions.add([double.parse(temp1), index, value["name"]]);
  }

  addHotel(list_of_most_expensive_hotels, index, value) {
    var first = value["price"].toString().substring(
        value["price"].indexOf('\$') + 1, value["price"].indexOf(' '));
    var second = value["price"].toString().substring(
        value["price"].lastIndexOf('\$') + 1, value["price"].toString().length);
    var average = (int.parse(first) + int.parse(second)) / 2;

    list_of_most_expensive_hotels.add([average, index, value["name"]]);
  }
}
