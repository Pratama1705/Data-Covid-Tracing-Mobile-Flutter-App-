// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  CardButton({
    Key? key,
  }) : super(key: key);

  String title = "";
  String jumlahKasus = "";
  String jumlahDirawat = "";
  String jumlahSembuh = "";
  String jumlahMeninggal = "";

  CardButton.fillData({
    Key? key,
    required this.title,
    required this.jumlahKasus,
    required this.jumlahDirawat,
    required this.jumlahSembuh,
    required this.jumlahMeninggal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: Center(
                child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            )),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text("Jumlah Kasus : $jumlahKasus"),
                  Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Text("Jumlah Dirawat : $jumlahDirawat")),
                  Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Text("Jumlah Sembuh : $jumlahSembuh")),
                  Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Text("Jumlah Meninggal : $jumlahMeninggal")),
                ],
              )),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Perform some action
                },
                child: const Text('Detail'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
