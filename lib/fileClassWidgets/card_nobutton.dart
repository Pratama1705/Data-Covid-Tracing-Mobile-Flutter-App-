// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

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
  }) : super(key: key);

  String jumlahVaksinasi = "";
  String vaksinasi1 = "";
  String vaksinasi2 = "";
  CardNoButton.vaksin(
      {Key? key,
      required this.kode,
      required this.title,
      required this.jumlahVaksinasi,
      required this.vaksinasi1,
      required this.vaksinasi2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: Center(child: Text(title)),
          ),
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: (kode == 1)
                  ? CardDataCovid(
                      kasusPositif: kasusPositif,
                      penambahanKasusPositif: penambahanKasusPositif,
                      totalKesembuhan: totalKesembuhan,
                      penambahanKesembuhan: penambahanKesembuhan,
                      totalKematian: totalKematian,
                      penambahanKematian: penambahanKematian)
                  : CardDataVaksin(
                      jumlahVaksinasi: jumlahVaksinasi,
                      vaksinasi1: vaksinasi1,
                      vaksinasi2: vaksinasi2)),
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
  }) : super(key: key);

  final String kasusPositif;
  final String penambahanKasusPositif;
  final String totalKesembuhan;
  final String penambahanKesembuhan;
  final String totalKematian;
  final String penambahanKematian;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Kasus Positif : $kasusPositif"),
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text("Penambahan Kasus Positif : $penambahanKasusPositif")),
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text("Total Kesembuhan : $totalKesembuhan")),
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text("Penambahan Kesembuhan : $penambahanKesembuhan")),
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text("Total Kematian : $totalKematian")),
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text("Penambahan Kematian : $penambahanKematian")),
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
  }) : super(key: key);

  final String jumlahVaksinasi;
  final String vaksinasi1;
  final String vaksinasi2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Jumlah Vaksinasi : $jumlahVaksinasi"),
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text("Vaksinasi Tahap 1 : $vaksinasi1")),
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text("Vaksinasi Tahap 2 : $vaksinasi2")),
      ],
    );
  }
}
