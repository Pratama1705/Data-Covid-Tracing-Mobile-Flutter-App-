// ignore_for_file: must_be_immutable, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:money_formatter/money_formatter.dart';

class DataProvinsi extends StatelessWidget {
  DataProvinsi({Key? key}) : super(key: key);

  Future<dynamic> getDataProv() async {
    var hasilGet =
        await http.get("https://data.covid19.go.id/public/api/prov.json");

    if (hasilGet.statusCode >= 200 && hasilGet.statusCode < 300) {
      var dataOutput = json.decode(hasilGet.body);
      return dataOutput;
    }

    return null;
  }

  late String namaProv;
  DataProvinsi.getData({Key? key, required this.namaProv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 194, 255, 211),
      appBar: AppBar(title: const Text("DETAIL DATA PROVINSI")),
      body: FutureBuilder(
        future: getDataProv(),
        builder: (context, snapshot) {
          if (snapshot.error != null) {
            return Center(
              child: Center(child: Text("${snapshot.error}")),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var result = (snapshot.data as Map<String, dynamic>)["list_data"];
          List<Map> resultSearchData = [];
          for (var i = 0; i < result.length; i++) {
            if (result[i]["key"]
                .toLowerCase()
                .contains(namaProv.toLowerCase())) {
              resultSearchData.add(result[i]);
            }
          }

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

          return ListView(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(36, 30, 36, 70),
                child: Card(
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        title: Center(child: Text(namaProv)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(right: 12, left: 12),
                              child: Row(
                                children: [
                                  const Text("Kasus Positif : "),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromARGB(
                                              255, 237, 252, 255),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 17,
                                            left: 19,
                                            right: 18,
                                            bottom: 18),
                                        width: 150,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(textFormatter(
                                                resultSearchData[0]
                                                        ["jumlah_kasus"]
                                                    .toString())),
                                            Text(
                                              " (+${textFormatter(resultSearchData[0]["penambahan"]["positif"].toString())})",
                                              style: const TextStyle(
                                                  color: Colors.red),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 12, left: 12, top: 7),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Kesembuhan : "),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromARGB(
                                              255, 237, 252, 255),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 17,
                                            left: 19,
                                            right: 18,
                                            bottom: 18),
                                        width: 150,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(textFormatter(
                                                resultSearchData[0]
                                                        ["jumlah_sembuh"]
                                                    .toString())),
                                            Text(
                                              " (+${textFormatter(resultSearchData[0]["penambahan"]["sembuh"].toString())})",
                                              style: const TextStyle(
                                                  color: Colors.green),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 12, left: 12, top: 7),
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                          left: 8, right: 8.5),
                                      child: const Text("Meninggal : ")),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromARGB(
                                              255, 237, 252, 255),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 17,
                                            left: 19,
                                            right: 18,
                                            bottom: 18),
                                        width: 150,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(textFormatter(
                                                resultSearchData[0]
                                                        ["jumlah_meninggal"]
                                                    .toString())),
                                            Text(
                                              " (+${textFormatter(resultSearchData[0]["penambahan"]["meninggal"].toString())})",
                                              style: const TextStyle(
                                                  color: Colors.red),
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 7, left: 12, right: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromARGB(255, 237, 252, 255),
                                  border: Border.all(color: Colors.black)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        border:
                                            Border.all(color: Colors.black)),
                                    margin: const EdgeInsets.only(
                                        top: 12, bottom: 12, right: 30),
                                    child: Container(
                                      margin: EdgeInsets.zero,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            child: const Text(
                                              "PRIA",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Text(textFormatter(
                                                resultSearchData[0]
                                                            ["jenis_kelamin"][0]
                                                        ["doc_count"]
                                                    .toString())),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        border:
                                            Border.all(color: Colors.black)),
                                    margin: const EdgeInsets.only(
                                        top: 12, bottom: 12, left: 30),
                                    child: Container(
                                      margin: EdgeInsets.zero,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            child: const Text(
                                              "WANITA",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Text(textFormatter(
                                                resultSearchData[0]
                                                            ["jenis_kelamin"][1]
                                                        ["doc_count"]
                                                    .toString())),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 7, left: 12, right: 12, bottom: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromARGB(255, 237, 252, 255),
                                  border: Border.all(color: Colors.black)),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 9, right: 8, top: 12),
                                    child: Row(
                                      children: [
                                        Container(
                                            margin:
                                                const EdgeInsets.only(right: 8),
                                            child:
                                                const Text("0 - 18 Tahun : ")),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.all(5),
                                            width: 160,
                                            child: Center(
                                                child: Text(textFormatter(
                                                    (resultSearchData[0][
                                                                    "kelompok_umur"][0]
                                                                ["doc_count"] +
                                                            resultSearchData[0][
                                                                    "kelompok_umur"]
                                                                [
                                                                1]["doc_count"])
                                                        .toString()))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 9, right: 8, top: 7),
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.zero,
                                            child:
                                                const Text("19 - 45 Tahun : ")),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.all(5),
                                            width: 160,
                                            child: Center(
                                                child: Text(textFormatter(
                                                    (resultSearchData[0][
                                                                    "kelompok_umur"][2]
                                                                ["doc_count"] +
                                                            resultSearchData[0][
                                                                    "kelompok_umur"]
                                                                [
                                                                3]["doc_count"])
                                                        .toString()))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 9, right: 8, top: 7),
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.zero,
                                            child:
                                                const Text("46 - 59 Tahun : ")),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.all(5),
                                            width: 160,
                                            child: Center(
                                                child: Text(textFormatter(
                                                    resultSearchData[0][
                                                                "kelompok_umur"]
                                                            [4]["doc_count"]
                                                        .toString()))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 9, right: 8, top: 7, bottom: 12),
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.only(
                                                right: 15.9),
                                            child: const Text("> 59 Tahun : ")),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.all(5),
                                            width: 160,
                                            child: Center(
                                                child: Text(textFormatter(
                                                    resultSearchData[0][
                                                                "kelompok_umur"]
                                                            [5]["doc_count"]
                                                        .toString()))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
