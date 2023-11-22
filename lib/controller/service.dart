import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AllServices {
  static void showSuccessMsg(BuildContext ctx, String msg) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getItemFromCsv() async {
    final String rawData = await rootBundle.loadString("assets/data/fruit_prices.csv");
    final List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(rawData);
    List<Map<String, dynamic>> fruitsList = [];
    for (int i = 1; i < rowsAsListOfValues.length; i++) {
      Map<String, dynamic> map = {
        rowsAsListOfValues[0][0].toString(): rowsAsListOfValues[i][0],
        rowsAsListOfValues[0][1].toString(): rowsAsListOfValues[i][1],
        rowsAsListOfValues[0][2].toString(): rowsAsListOfValues[i][2],
        rowsAsListOfValues[0][3].toString(): rowsAsListOfValues[i][3],
        rowsAsListOfValues[0][4].toString(): rowsAsListOfValues[i][4],
        rowsAsListOfValues[0][5].toString(): rowsAsListOfValues[i][5],
        rowsAsListOfValues[0][6].toString(): rowsAsListOfValues[i][6],
        rowsAsListOfValues[0][7].toString(): rowsAsListOfValues[i][7],
        rowsAsListOfValues[0][8].toString(): rowsAsListOfValues[i][8],
        rowsAsListOfValues[0][9].toString(): rowsAsListOfValues[i][9],
      };
      fruitsList.add(map);
    }
    return fruitsList;
  }
}
