import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'ResultRowTemplate.dart';
import 'package:baseconverter/pages/FExchangePage.dart';
import 'CurrencyCard.dart';

class CurrencyResultTemplate {
  String selectedCurrency;
  double amount;


  CurrencyResultTemplate({this.selectedCurrency, this.amount});

  static Future<Widget> getCurrnecies(String selectedCurrency, double amount) async{
    try{
      // make request
      Response response = await get('https://api.exchangeratesapi.io/latest?base=$selectedCurrency');
      Map jsonData = jsonDecode(response.body);
      //print(data);
      final Map data = jsonData['rates'];
      return ListView.builder(

            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
            String key = data.keys.elementAt(index).toString();
            String value = (data.values.elementAt(index) * amount).toStringAsFixed(6);
            return CurrencyCardTemplate(key, value);
            //return ResultRowTemplate(key, value);
          }
      );


    } catch(e) {
      print('cought error: $e');
    }
  }
}