import 'package:flutter/material.dart';
import 'package:ortalama_hesapla/color_schemes.dart';
import 'package:ortalama_hesapla/widgets/ortalama_hesapla_body.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ortalama Hesapla",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: darkColorScheme,
      ),
      home: const OrtalamaHesaplaBody(),
    );
  }
}
