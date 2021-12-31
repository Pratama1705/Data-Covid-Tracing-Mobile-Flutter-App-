// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:project_flutter/provinsi.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:intl/intl.dart';

class CardButton extends StatelessWidget {
  CardButton({
    Key? key,
  }) : super(key: key);

  String title = "";
  String jumlahKasus = "";
  String jumlahDirawat = "";
  String jumlahSembuh = "";
  String jumlahMeninggal = "";
  String tanggal = "";

  CardButton.fillData({
    Key? key,
    required this.title,
    required this.jumlahKasus,
    required this.jumlahDirawat,
    required this.jumlahSembuh,
    required this.jumlahMeninggal,
    required this.tanggal,
  }) : super(key: key);

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

  // Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Column(
  //               children: [
  //                 Text("Jumlah Kasus : $jumlahKasus"),
  //                 Container(
  //                     margin: const EdgeInsets.only(top: 15),
  //                     child: Text("Jumlah Dirawat : $jumlahDirawat")),
  //                 Container(
  //                     margin: const EdgeInsets.only(top: 15),
  //                     child: Text("Jumlah Sembuh : $jumlahSembuh")),
  //                 Container(
  //                     margin: const EdgeInsets.only(top: 15),
  //                     child: Text("Jumlah Meninggal : $jumlahMeninggal")),
  //               ],
  //             )),
  //         ButtonBar(
  //           alignment: MainAxisAlignment.center,
  //           children: [
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.push(context, MaterialPageRoute(builder: (context) {
  //                   return DataProvinsi.getData(namaProv: title);
  //                 }));
  //               },
  //               child: const Text('Detail'),
  //             ),
  //           ],
  //         ),

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
            child: Column(
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
                                Text(textFormatter(jumlahKasus)),
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
                                Text(textFormatter(jumlahSembuh),
                                    style:
                                        const TextStyle(color: Colors.green)),
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
                                Text(textFormatter(jumlahMeninggal),
                                    style: const TextStyle(color: Colors.red)),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 7),
                  child: Center(
                      child: Text(
                          "Updated : ${DateFormat("d MMM, yyyy").format(DateTime.parse(tanggal))}")),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 1, color: Colors.black),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DataProvinsi.getData(namaProv: title);
                        }));
                      },
                      child: const Text('DETAIL'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
