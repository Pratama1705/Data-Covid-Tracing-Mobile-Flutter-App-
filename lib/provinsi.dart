// ignore_for_file: must_be_immutable, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

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
      appBar: AppBar(title: Text(namaProv)),
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
          return Container(
            margin: const EdgeInsets.fromLTRB(35, 30, 35, 70),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    title: Center(child: Text(namaProv)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Total Kasus : ${resultSearchData[0]["jumlah_kasus"]}")),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Penambahan Kasus Positif : ${resultSearchData[0]["penambahan"]["positif"]}")),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Total Kesembuhan : ${resultSearchData[0]["jumlah_sembuh"]}")),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Penambahan Kasus Kesembuhan : ${resultSearchData[0]["penambahan"]["sembuh"]}")),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Total Dirawat : ${resultSearchData[0]["jumlah_dirawat"]}")),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Penambahan Kasus Kematian : ${resultSearchData[0]["penambahan"]["meninggal"]}")),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Total Kematian : ${resultSearchData[0]["jumlah_meninggal"]}")),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Total Pria Positif : ${resultSearchData[0]["jenis_kelamin"][0]["doc_count"]}")),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Total Wanita Positif : ${resultSearchData[0]["jenis_kelamin"][1]["doc_count"]}")),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Total Usia 0-5 Tahun : ${resultSearchData[0]["kelompok_umur"][0]["doc_count"]}")),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Total Usia 6-18 Tahun : ${resultSearchData[0]["kelompok_umur"][1]["doc_count"]}")),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Total Usia 19-30 Tahun : ${resultSearchData[0]["kelompok_umur"][2]["doc_count"]}")),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Total Usia 31-45 Tahun : ${resultSearchData[0]["kelompok_umur"][3]["doc_count"]}")),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Total Usia 46-59 Tahun : ${resultSearchData[0]["kelompok_umur"][4]["doc_count"]}")),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Total Usia >=60 Tahun : ${resultSearchData[0]["kelompok_umur"][5]["doc_count"]}")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
