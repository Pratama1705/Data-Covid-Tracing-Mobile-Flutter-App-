// ignore_for_file: avoid_init_to_null, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:project_flutter/detail_provinsi.dart';
import 'package:project_flutter/fileClassWidgets/card_nobutton.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class DataTotal extends StatefulWidget {
  const DataTotal({Key? key}) : super(key: key);

  @override
  _DataTotalState createState() => _DataTotalState();
}

class _DataTotalState extends State<DataTotal> {
  // DATA COVID DAN VAKSIN
  Future<dynamic> getData() async {
    var hasilGet = await http
        .get("https://apicovid19indonesia-v2.vercel.app/api/indonesia/harian");
    var hasilGetVaksin =
        await http.get("https://vaksincovid19-api.now.sh/api/vaksin");

    if (hasilGet.statusCode >= 200 &&
        hasilGet.statusCode < 300 &&
        hasilGetVaksin.statusCode >= 200 &&
        hasilGetVaksin.statusCode < 300) {
      var dataOutput = json.decode(hasilGet.body);
      var dataOutputVaksin = json.decode(hasilGetVaksin.body);
      List<dynamic> kumpulanData = [dataOutput, dataOutputVaksin];
      return kumpulanData;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 194, 255, 211),
        appBar: AppBar(
          title: const Center(child: Text("DATA COVID TRACING")),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.error != null) {
              return Center(
                child: Center(child: Text("${snapshot.error}")),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              var result = snapshot.data! as List<dynamic>;
              return Container(
                margin: const EdgeInsets.all(0),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                left: 36, top: 24, right: 36),
                            child: CardNoButton.data(
                              kode: 1,
                              title: "DATA COVID-19",
                              kasusPositif: result[0][result[0].length - 1]
                                      ["positif_kumulatif"]
                                  .toString(),
                              penambahanKasusPositif: result[0]
                                      [result[0].length - 1]["positif"]
                                  .toString(),
                              totalKesembuhan: result[0][result[0].length - 1]
                                      ["sembuh_kumulatif"]
                                  .toString(),
                              penambahanKesembuhan: result[0]
                                      [result[0].length - 1]["sembuh"]
                                  .toString(),
                              totalKematian: result[0][result[0].length - 1]
                                      ["meninggal_kumulatif"]
                                  .toString(),
                              penambahanKematian: result[0]
                                      [result[0].length - 1]["meninggal"]
                                  .toString(),
                              tanggal: result[0][result[0].length - 1]
                                      ["tanggal"]
                                  .toString(),
                            )),
                        Container(
                            margin: const EdgeInsets.only(
                                right: 36, top: 24, left: 36),
                            child: CardNoButton.vaksin(
                                kode: 2,
                                title: "DATA VAKSIN SAAT INI",
                                jumlahVaksinasi:
                                    result[1]["totalsasaran"].toString(),
                                vaksinasi1: result[1]["vaksinasi1"].toString(),
                                vaksinasi2: result[1]["vaksinasi2"].toString(),
                                tanggalVak:
                                    result[1]["lastUpdate"].toString())),
                        Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 15),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1, color: Colors.black),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text("DATA PROVINSI"),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const DataProvinsi();
                              }));
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
