import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlanetController extends ChangeNotifier {
  List allPlanets = [];

  PlanetController() {
    loadPlanets();
  }

  loadPlanets() async {
    String res = await rootBundle.loadString("lib/assets/json/planets.json");

    allPlanets = jsonDecode(res);
    notifyListeners();
  }
}
