// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:ortalama_hesapla/helper/data_helper.dart';

import '../model/ders.dart';
import '../page/first_route.dart';
import '../page/second_route.dart';
import '../widgets/ortalama_goster.dart';

class OrtalamaHesaplaBody extends StatefulWidget {
  const OrtalamaHesaplaBody({Key? key}) : super(key: key);

  @override
  State<OrtalamaHesaplaBody> createState() => _OrtalamaHesaplaBodyState();
}

class _OrtalamaHesaplaBodyState extends State<OrtalamaHesaplaBody> {
  List<Ders> tumDersler = [];

  double secilen = 1;
  double secilenKredi = 1;
  String girilenDersAdi = "Ders Adı Girilmemiş!";
  double krediDegeri = 1;
  double notDegeri = 4;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Ortalama Hesapla",
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: myForm(),
                ),
                Expanded(
                  child: OrtalamaGoster(
                    ortalama: ortalamaHesapla(),
                    dersSayisi: tumDersler.length,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: (tumDersler.length > 0)
                ? ListView.builder(
                    itemBuilder: (context, index) => Dismissible(
                        direction: DismissDirection.startToEnd,
                        onDismissed: (a) {
                          setState(() {
                            tumDersler.removeAt(index);
                          });
                        },
                        key: UniqueKey(),
                        child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                side: BorderSide(
                                    width: 1,
                                    color:
                                        Theme.of(context).colorScheme.outline),
                              ),
                              child: ListTile(
                                title: Text(tumDersler[index].ad),
                                subtitle: Text(
                                    "${tumDersler[index].krediDegeri} Kredi, Not Değeri: ${tumDersler[index].harfDegeri}"),
                                leading: CircleAvatar(
                                  child: Text((tumDersler[index].krediDegeri *
                                          tumDersler[index].harfDegeri)
                                      .toStringAsFixed(0)),
                                ),
                              ),
                            ))),
                    itemCount: tumDersler.length,
                  )
                : Container(
                    margin: const EdgeInsets.all(24),
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("Lütfen Ders Ekleyin"),
                        ),
                      ),
                    ),
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: ElevatedButton(
                  child: Row(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.light_mode),
                      ),
                      Text("Light Mode"),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FirstRoute()),
                    );
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: Row(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.dark_mode),
                      ),
                      Text("Dark Mode"),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecondRoute()),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Form myForm() {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _buildTextFormField(),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildHarfler(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildKrediler(),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      var eklenecekDers =
                          Ders(girilenDersAdi, secilen, secilenKredi);
                      tumDersler.insert(0, eklenecekDers);
                      ortalamaHesapla();
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.arrow_forward_ios_sharp, size: 30),
                ),
              ],
            ),
          ],
        ));
  }

  double ortalamaHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;

    for (var element in tumDersler) {
      toplamNot += (element.krediDegeri * element.harfDegeri);
      toplamKredi += element.krediDegeri;
    }

    return toplamNot / toplamKredi;
  }

  TextFormField _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        girilenDersAdi = deger!;
      },
      validator: (s) {
        if (s!.length <= 0) {
          return "Ders Adını Boş Bırakma";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: "Matematik",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
        filled: true,
      ),
    );
  }

  Widget _buildKrediler() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<double>(
        elevation: 16,
        items: DataHelper.tumKrediler(),
        underline: Container(),
        onChanged: (dd) {
          setState(() {
            secilenKredi = dd!;
            // print(dd)
          });
        },
        value: secilenKredi,
      ),
    );
  }

  Widget _buildHarfler() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<double>(
        elevation: 16,
        items: DataHelper.tumDersHarfleri(),
        underline: Container(),
        onChanged: (dd) {
          setState(() {
            secilen = dd!;
            //  print(dd);
          });
        },
        value: secilen,
      ),
    );
  }
}
