// ignore_for_file: prefer_const_constructors
// ignore_for_file: avoid_init_to_null, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:project_flutter/fileClassWidgets/card_button.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class DataProvinsi extends StatefulWidget {
  const DataProvinsi({Key? key}) : super(key: key);

  @override
  _DataProvinsiState createState() => _DataProvinsiState();
}

class _DataProvinsiState extends State<DataProvinsi> {
  Future<dynamic> getDataProv() async {
    var hasilGet =
        await http.get("https://data.covid19.go.id/public/api/prov.json");

    if (hasilGet.statusCode >= 200 && hasilGet.statusCode < 300) {
      var dataOutput = json.decode(hasilGet.body);
      return dataOutput;
    }

    return null;
  }

  Widget myWidget = Text("DATA COVID TRACING");
  TextEditingController controller = TextEditingController();
  void searchData() {
    setState(() {
      myWidget = TextField(
        onChanged: (value) {
          setState(() {});
        },
        decoration: const InputDecoration(
            hintText: "Cari Provinsi",
            hintStyle: TextStyle(color: Colors.white)),
        controller: controller,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 194, 255, 211),
        appBar: AppBar(
          title: myWidget,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child:
                  IconButton(onPressed: searchData, icon: Icon(Icons.search)),
            ),
          ],
          backgroundColor: Colors.blue,
        ),
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
            if (controller.text.isEmpty) {
              return ListView.builder(
                itemCount: result.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: CardButton.fillData(
                        title: result[index]["key"],
                        jumlahKasus: result[index]["jumlah_kasus"].toString(),
                        jumlahDirawat:
                            result[index]["jumlah_dirawat"].toString(),
                        jumlahSembuh: result[index]["jumlah_sembuh"].toString(),
                        jumlahMeninggal:
                            result[index]["jumlah_meninggal"].toString()),
                  );
                },
              );
            }

            var resultSearch =
                (snapshot.data as Map<String, dynamic>)["list_data"];

            List<Map> resultSearchData = [];
            for (var i = 0; i < resultSearch.length; i++) {
              if (resultSearch[i]["key"]
                  .toLowerCase()
                  .contains(controller.text.toLowerCase())) {
                resultSearchData.add(resultSearch[i]);
              }
            }
            return ListView.builder(
              itemCount: resultSearchData.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: CardButton.fillData(
                      title: resultSearchData[index]["key"],
                      jumlahKasus:
                          resultSearchData[index]["jumlah_kasus"].toString(),
                      jumlahDirawat:
                          resultSearchData[index]["jumlah_dirawat"].toString(),
                      jumlahSembuh:
                          resultSearchData[index]["jumlah_sembuh"].toString(),
                      jumlahMeninggal: resultSearchData[index]
                              ["jumlah_meninggal"]
                          .toString()),
                );
              },
            );
          },
        ));
  }
}
