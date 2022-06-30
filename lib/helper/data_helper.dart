import 'package:flutter/material.dart';

class DataHelper {
  static List<String> _createDersHarfNotlari() {
    return ["AA", "BA", "BB", "CB", "CC", "DC", "DD", "FD", "FF"];
  }

  static double _harfiNotaCevir(String harf) {
    switch (harf) {
      case "AA":
        return 4.0;
      case "BA":
        return 3.5;
      case "BB":
        return 3.0;
      case "CB":
        return 2.5;
      case "CC":
        return 2.0;
      case "DC":
        return 1.5;
      case "DD":
        return 1.0;
      case "FD":
        return 0.5;
      case "FF":
        return 0.0;
      default:
        return 1;
    }
  }

  static List<int> _tumKrediler() {
    return List.generate(10, (index) => index + 1).toList();
  }

  static List<DropdownMenuItem<double>> tumDersHarfleri() {
    return _createDersHarfNotlari()
        .map((e) => DropdownMenuItem(
              value: _harfiNotaCevir(e),
              child: Text(e),
            ))
        .toList();
  }

  static List<DropdownMenuItem<double>> tumKrediler() {
    return List.generate(10, (index) => (index + 1))
        .toList()
        .map((e) => DropdownMenuItem(
              value: e.toDouble(),
              child: Text(e.toString()),
            ))
        .toList();
  }
}
