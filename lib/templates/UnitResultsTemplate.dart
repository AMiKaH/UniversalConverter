
import 'package:baseconverter/constants/ColorConstants.dart';
import 'package:baseconverter/templates/ResultRowTemplate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnitResultTemplate extends  StatelessWidget {
  Map<String, double> results;
  //String scale;

  UnitResultTemplate (Map<String, double>  results) {
    this.results = results;
    //this.scale = scale;
  }


  @override
  Widget build(BuildContext context) {
    return getResultRow(context, results);
  }

  Widget getResultRow(BuildContext context, Map<String, double> results) {
    return ListView.builder(
            itemCount: results.length,
            itemBuilder: (BuildContext context, int index) {
              String key = results.keys.elementAt(index).toString();
              String value = results.values.elementAt(index).toString();
              return ResultRowTemplate(key, value);
            }
        );
  }
}