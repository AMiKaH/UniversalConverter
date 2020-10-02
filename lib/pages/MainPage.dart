import 'dart:collection';

import 'package:baseconverter/classes/BaseConverterClass.dart';
import 'package:baseconverter/classes/UnitConverterClass.dart';
import 'package:baseconverter/constants/ColorConstants.dart';
import 'package:baseconverter/constants/StringsConstants.dart';
import 'package:baseconverter/pages/TabbedPage.dart';
import 'package:baseconverter/templates/CurrencyResultTemplate.dart';
import 'package:baseconverter/templates/ResultRowTemplate.dart';
import 'package:baseconverter/templates/UnitResultsTemplate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:oktoast/oktoast.dart';

import 'FExchangePage.dart';
import 'TranslationPage.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {
  final _currencyValueInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        home: Scaffold(
          appBar: getAppBar(context),
          extendBodyBehindAppBar: true,
          body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage ('assets/images/backgrounds/BG.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 25),
                      Row (
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 75,
                              child: RaisedButton(
                                color: Colors.transparent,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.swap_calls,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 20),
                                    Text (
                                      StringsConstants.ConverterButton,
                                      style: TextStyle(
                                        color: ColorConstants.buttonText,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => TabbedPage()),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      IntrinsicHeight(
                        child: Row (
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: 75,
                                child: RaisedButton(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.monetization_on,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 20),
                                      Text (
                                        StringsConstants.Exchange,
                                        style: TextStyle(
                                          color: ColorConstants.buttonText,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => FExchangePage()),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),

                      ),
                      SizedBox(height: 10),
                      IntrinsicHeight(
                        child: Row (
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: 75,
                                child: RaisedButton(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.translate,
                                        size: 50,
                                        color: ColorConstants.buttonText,
                                      ),
                                      SizedBox(width: 20),
                                      Text (
                                        StringsConstants.Translator,
                                        style: TextStyle(
                                          color: ColorConstants.buttonText,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => TranslationPage()),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ),
        ),
      ),
    );
  }

  Widget getAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
            StringsConstants.MainPage,
            style: TextStyle(
              fontSize: 30,
              height: 2,
              fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
        elevation: 0,
    );
  }
}