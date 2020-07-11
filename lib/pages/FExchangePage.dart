import 'dart:collection';

import 'package:baseconverter/classes/BaseConverterClass.dart';
import 'package:baseconverter/classes/UnitConverterClass.dart';
import 'package:baseconverter/constants/ColorConstants.dart';
import 'package:baseconverter/constants/StringsConstants.dart';
import 'package:baseconverter/templates/CurrencyResultTemplate.dart';
import 'package:baseconverter/templates/ResultRowTemplate.dart';
import 'package:baseconverter/templates/UnitResultsTemplate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class FExchangePage extends StatefulWidget {
  @override
  _FExchangePageState createState() => _FExchangePageState();

}

class _FExchangePageState extends State<FExchangePage> {
  final _currencyValueInput = TextEditingController();
  Map<String, String> httpResult;
  List<String> currencies = [
    "USD","CAD","EUR","GBP","HKD","ISK","PHP","DKK","HUF","CZK","RON","SEK","IDR","INR",
    "BRL","RUB","HRK","JPY","THB","CHF","MYR","BGN","TRY","CNY","NOK",
    "NZD","ZAR","MXN","SGD","AUD","ILS","KRW","PLN"
  ];
  double amount;
  String selectedCurrency;
  ListView lV;

  void initState() {
    super.initState();
    selectedCurrency = currencies.first;
    lV = null;
    amount = 1;
    _currencyValueInput.addListener(() {
      final text = _currencyValueInput.text;
      _currencyValueInput.value = _currencyValueInput.value.copyWith(
        text: text,
        selection: TextSelection(
            baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  void update(ListView lv2) {
    setState(() {
      lV = lv2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: getAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
            decoration: BoxDecoration(
            image: DecorationImage(
            image: ExactAssetImage ('assets/images/backgrounds/BGNoLogo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 50,
                      child: TextFormField(
                        controller: _currencyValueInput,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: ColorConstants.borderActive,
                              width: 2.0,
                            ),

                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: ColorConstants.borderInactive,
                            ),
                          ),
                          border: OutlineInputBorder(),
                          hintText: StringsConstants.value,
                          hintStyle: TextStyle(
                            fontSize: 20,
                            color: ColorConstants.textWhite,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorConstants.textWhite,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: DropdownButton(
                        dropdownColor: Colors.teal[300],
                        //isExpanded: true,
                        value: selectedCurrency,
                        icon: Icon (
                          Icons.unfold_more,
                          color: Colors.white,
                        ),
                        underline: Container(
                          height: 0,
                          color: Colors.white,
                        ),
                        items: currencies.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ) ,
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            selectedCurrency = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Expanded (
                        child: RaisedButton (
                          child: Text (
                            StringsConstants.convert,
                            style: TextStyle(
                              color: ColorConstants.buttonText,
                            ),
                          ),
                          color: ColorConstants.actionButton,
                          onPressed: () async {
                            amount = _currencyValueInput.value.text.length > 0?
                              double.parse(_currencyValueInput.value.text):
                              amount;
                            lV = await CurrencyResultTemplate.getCurrnecies(selectedCurrency, amount);
                            update(lV);
//                        setState(() {
//                          lV = lV;
//                        });
                          },
                        )
                    ),
                  ],
                ),
                SizedBox(height: 20),
                if (lV != null)
                  Expanded (
                      flex  : 10,
                      child: lV,
                  ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  Widget getAppBar() {
    return AppBar(
        backgroundColor: Colors.transparent,
        title: Text(StringsConstants.CurrencyPage),
        centerTitle: true,
        elevation: 1,
    );
  }
}