import 'dart:collection';
import 'dart:convert';

import 'package:baseconverter/classes/BaseConverterClass.dart';
import 'package:baseconverter/classes/TranslationClass.dart';
import 'package:baseconverter/constants/Keys.dart';
import 'package:baseconverter/constants/ColorConstants.dart';
import 'package:baseconverter/constants/StringsConstants.dart';
import 'package:baseconverter/templates/CurrencyResultTemplate.dart';
import 'package:baseconverter/templates/ResultRowTemplate.dart';
import 'package:baseconverter/templates/UnitResultsTemplate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:translator/translator.dart';


class TranslationPage extends StatefulWidget {
  @override
  _TranslationPageState createState() => _TranslationPageState();

}

class _TranslationPageState extends State<TranslationPage> {
  final translator = GoogleTranslator();

  final _translateInput = TextEditingController();
  final _translateOutput = TextEditingController();

  String langFrom;
  String langTo;

  String langFromCode;
  String langToCode;

  void initState() {
    langFrom = TranslationClass.LANGUAGESFROM.values.elementAt(0);
    langFromCode = TranslationClass.LANGUAGESFROM.keys.firstWhere((langFROM) => true);

    langTo = TranslationClass.LANGUAGESTO.values.elementAt(0);
    langToCode = TranslationClass.LANGUAGESTO.keys.firstWhere((langTo) => true);


  }

  String getMapKey(String inValue, Map map) {
    String keyStr = '';
    map.forEach((key, value) {
      if (value == inValue) {
        return keyStr = key;
      }
    });
    return keyStr;
  }
  _translate () async {

    get('https://translation.googleapis.com/language/translate/v2?source=$langFromCode&target=$langToCode&key=${Keys.GCTKey}&q=${_translateInput.text}')
    .then((value) {
      Map jsonData = jsonDecode(value.body);
      TranslationData td = new TranslationData.fromJson(jsonData['data']);
      //final Map data = tt.translatedText;
      //final Map test = TranslationData.fromJson(data)

      //String input = _translateInput.text;
      setState(() {
        _translateOutput.text = td.translations[0].translatedText.toString();
      });
      //translator.translate(input, to:'ar').then((result) => _translateOutput.text = result.toString());
    });

  }

  Widget build(BuildContext context) {

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: getAppBar(),
      body: Container (
        width: double.infinity,
        height: double.infinity,
        child: Container (
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage ('assets/images/backgrounds/BGNoLogo.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding (
              padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
              child: Column (
                children: <Widget>[
                  Expanded(
                    flex: 0,
                    child: TextFormField(
                      maxLength: 100,
                      minLines: 7,
                      maxLines: 7,
                      controller: _translateInput,
                      keyboardType: TextInputType.text,
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
                        hintText: StringsConstants.translateHint,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container (
                        child: DropdownButton(
                          dropdownColor: Colors.teal[300],
                          //isExpanded: true,
                          icon: Icon (
                            Icons.unfold_more,
                            color: Colors.white,
                          ),
                          underline: Container(
                            height: 0,
                            color: Colors.white,
                          ),
                          items: TranslationClass.LANGUAGESFROM.map((description, value) {
                            return MapEntry(
                              description,
                              DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ) ,
                                ),
                              )
                            );
                          }).values
                            .toList(),
                          value: langFrom,
                          onChanged: (String newValue) {
                            setState(() {
                              langFrom = newValue;
                              langFromCode = getMapKey(langFrom, TranslationClass.LANGUAGESFROM);

                            });
                          },
                        ),
                      ),
                      Container (
                        width: 60,
                          child: RaisedButton (
                            child: Icon (
                              Icons.transform,
                              color: ColorConstants.textWhite,
                            ),

                            color: Colors.transparent,
                            onPressed: () {
                              _translate();
                              /*
                              setState(() {
                                //results = BaseConverterClass.convert(baseFrom, _baseConverterTextEdit.value.text);
                              });*/
                            },
                          )
                      ),
                      /*Container (
                          width: 60,
                          child: RaisedButton (
                            child: Icon (
                              Icons.swap_vert,
                              color: ColorConstants.textWhite,
                            ),
                            color: Colors.transparent,
                            onPressed: () {
                              setState(() {
                                //results = BaseConverterClass.convert(baseFrom, _baseConverterTextEdit.value.text);
                              });
                            },
                          )
                      ),*/
                      Container (
                        child: DropdownButton(
                          dropdownColor: Colors.teal[300],
                          //isExpanded: true,
                          icon: Icon (
                            Icons.unfold_more,
                            color: Colors.white,
                          ),
                          underline: Container(
                            height: 0,
                            color: Colors.white,
                          ),
                          items: TranslationClass.LANGUAGESTO.map((description, value) {
                            return MapEntry(
                                description,
                                DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ) ,
                                  ),
                                )
                            );
                          }).values
                            .toList(),
                          value: langTo,
                          onChanged: (String newValue) {
                            setState(() {
                              langTo = newValue;
                              langToCode = getMapKey(langTo, TranslationClass.LANGUAGESTO);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 0,
                    child: TextFormField(
                      readOnly: true,
                      enableInteractiveSelection: false,
                      minLines: 7,
                      maxLines: 7,
                      controller: _translateOutput,
                      keyboardType: TextInputType.text,
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
                ],
              )
            )
        )
        ),
      )
    );
  }

  Widget getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(StringsConstants.Translator),
      centerTitle: true,
      elevation: 1,
    );
  }
}

class TranslationData {
  final List<TranslatedText> translations;


  TranslationData({this.translations});

  factory TranslationData.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['translations'] as List;

    List<TranslatedText> translatedTextList = list.map((i) => TranslatedText.fromJson(i)).toList();

    return TranslationData(
      translations:translatedTextList,
    );
  }
}

class TranslatedText {
  final String translatedText;
  TranslatedText({this.translatedText});

  factory TranslatedText.fromJson(Map<String, dynamic> parsedJson){
    return TranslatedText(
      translatedText:parsedJson['translatedText'],
    );
  }
}