import 'package:baseconverter/constants/StringsConstants.dart';
import 'dart:convert';
import 'dart:math';
import 'package:unit_converter/unit_converter.dart';

class TranslationClass {
  static final Map<String, String> LANGUAGESFROM = <String, String> {
    ''    : 'Auto'   ,
    'en'  : 'English',
    'zh'  : 'Chinese',
    'ar'  : 'Arabic' ,
    'es'  : 'Spanish',
    'fr'  : 'French' ,
    'de'  : 'German' ,
  };

  static final Map<String, String> LANGUAGESTO = <String, String> {
    'en'  : 'English',
    'zh'  : 'Chinese',
    'ar'  : 'Arabic' ,
    'es'  : 'Spanish',
    'fr'  : 'French' ,
    'de'  : 'German' ,
  };
}
