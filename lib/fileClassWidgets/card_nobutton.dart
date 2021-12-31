// ignore_for_file: must_be_immutable, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:intl/intl.dart';

class CardNoButton extends StatelessWidget {
  CardNoButton({
    Key? key,
  }) : super(key: key);

  int kode = 0;

  String title = "";
  String kasusPositif = "";
  String penambahanKasusPositif = "";
  String totalKesembuhan = "";
  String penambahanKesembuhan = "";
  String totalKematian = "";
  String penambahanKematian = "";
  String tanggal = "";
  CardNoButton.data({
    Key? key,
    required this.kode,
    required this.title,
    required this.kasusPositif,
    required this.penambahanKasusPositif,
    required this.totalKesembuhan,
    required this.penambahanKesembuhan,
    required this.totalKematian,
    required this.penambahanKematian,
    required this.tanggal,
  }) : super(key: key);

  String jumlahVaksinasi = "";
  String vaksinasi1 = "";
  String vaksinasi2 = "";
  String tanggalVak = "";
  CardNoButton.vaksin(
      {Key? key,
      required this.kode,
      required this.title,
      required this.jumlahVaksinasi,
      required this.vaksinasi1,
      required this.vaksinasi2,
      required this.tanggalVak})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: Center(child: Text(title)),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: (kode == 1)
                  ? CardDataCovid(
                      kasusPositif: kasusPositif,
                      penambahanKasusPositif: penambahanKasusPositif,
                      totalKesembuhan: totalKesembuhan,
                      penambahanKesembuhan: penambahanKesembuhan,
                      totalKematian: totalKematian,
                      penambahanKematian: penambahanKematian,
                      tanggal: tanggal,
                    )
                  : CardDataVaksin(
                      jumlahVaksinasi: jumlahVaksinasi,
                      vaksinasi1: vaksinasi1,
                      vaksinasi2: vaksinasi2,
                      tanggalVak: tanggalVak,
                    )),
        ],
      ),
    );
  }
}

class CardDataCovid extends StatelessWidget {
  const CardDataCovid({
    Key? key,
    required this.kasusPositif,
    required this.penambahanKasusPositif,
    required this.totalKesembuhan,
    required this.penambahanKesembuhan,
    required this.totalKematian,
    required this.penambahanKematian,
    required this.tanggal,
  }) : super(key: key);

  final String kasusPositif;
  final String penambahanKasusPositif;
  final String totalKesembuhan;
  final String penambahanKesembuhan;
  final String totalKematian;
  final String penambahanKematian;
  final String tanggal;

  @override
  Widget build(BuildContext context) {
    String textFormatter(String data) {
      MoneyFormatter fmf = MoneyFormatter(
          amount: double.parse(data),
          settings: MoneyFormatterSettings(
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 3,
          ));
      return fmf.output.withoutFractionDigits;
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 12, left: 12),
          child: Row(
            children: [
              const Text("Kasus Positif : "),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 237, 252, 255),
                      border: Border.all(color: Colors.black)),
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 17, left: 19, right: 18, bottom: 18),
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(textFormatter(kasusPositif)),
                        Text(
                          " (+${textFormatter(penambahanKasusPositif)})",
                          style: const TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 12, left: 12, top: 7),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Kesembuhan : "),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 237, 252, 255),
                      border: Border.all(color: Colors.black)),
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 17, left: 19, right: 18, bottom: 18),
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(textFormatter(totalKesembuhan)),
                        Text(
                          " (+${textFormatter(penambahanKesembuhan)})",
                          style: const TextStyle(color: Colors.green),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 12, left: 12, top: 7),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 8, right: 8.5),
                  child: const Text("Meninggal : ")),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 237, 252, 255),
                      border: Border.all(color: Colors.black)),
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 17, left: 19, right: 18, bottom: 18),
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(textFormatter(totalKematian)),
                        Text(
                          " (+${textFormatter(penambahanKematian)})",
                          style: const TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16, bottom: 16),
          child: Center(
              child: Text(
                  "Updated : ${DateFormat("d MMM, yyyy").format(DateTime.parse(tanggal))}")),
        )
      ],
    );
  }
}

class CardDataVaksin extends StatelessWidget {
  const CardDataVaksin({
    Key? key,
    required this.jumlahVaksinasi,
    required this.vaksinasi1,
    required this.vaksinasi2,
    required this.tanggalVak,
  }) : super(key: key);

  final String jumlahVaksinasi;
  final String vaksinasi1;
  final String vaksinasi2;
  final String tanggalVak;

  String textFormatter(String data) {
    MoneyFormatter fmf = MoneyFormatter(
        amount: double.parse(data),
        settings: MoneyFormatterSettings(
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 3,
        ));
    return fmf.output.withoutFractionDigits;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 12, left: 12, top: 7),
          child: Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(),
                  child: const Text("Vaksinasi Lengkap : ")),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 237, 252, 255),
                      border: Border.all(color: Colors.black)),
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 17, left: 19, right: 18, bottom: 18),
                    width: 116,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(textFormatter(jumlahVaksinasi)),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 12, left: 12, top: 7),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 3.5),
                  child: const Text("Vaksinasi Tahap 1 : ")),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 237, 252, 255),
                      border: Border.all(color: Colors.black)),
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 17, left: 19, right: 18, bottom: 18),
                    width: 116,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(textFormatter(vaksinasi1)),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16, bottom: 16),
          child: Center(
              child: Text(
                  "Updated : ${DateFormat("d MMM, yyyy").format(DateTime.parse(tanggalVak))}")),
        )
      ],
    );
  }
}
