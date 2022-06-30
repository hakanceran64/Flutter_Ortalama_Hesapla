import 'package:flutter/material.dart';

class OrtalamaGoster extends StatelessWidget {
  final double ortalama;
  final int dersSayisi;

  const OrtalamaGoster({
    required this.ortalama,
    required this.dersSayisi,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          dersSayisi > 0 ? "$dersSayisi Ders Girildi" : "Ders Seçiniz",
        ),
        Text(
          ortalama >= 0 ? ortalama.toStringAsFixed(2) : "0.0",
        ),
        const Text(
          "Ortalama",
        ),
      ],
    );
  }
}
