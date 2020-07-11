

import 'package:baseconverter/constants/StringsConstants.dart';
import 'dart:convert';
import 'dart:math';


class BaseConverterClass {
  static final Set<String> BASES = {
    'Select Base',
    '2',
    '8',
    '10',
    '16'
  };

  static final Map<String, int> base16Digits = {
    '0':0,
    '1':1,
    '2':2,
    '3':3,
    '4':4,
    '5':5,
    '6':6,
    '7':7,
    '8':8,
    '9':9,
    'A':10,
    'B':11,
    'C':12,
    'D':13,
    'E':14,
    'F':15
  };

  static final String ERROR1 = 'Base and value mismatch';
  static final String ERROR2 = 'Select a base';


  static List<String> convert (String baseFrom, String valueFrom) {
    int valueFromInt;
    List<String> convertedValues = [];

    if (baseFrom == "Select Base") {
      for (int i = 0; i < 4; ++i){
      convertedValues.add(ERROR2);
      }
      return convertedValues;
    }
    int baseFromInt = int.parse(baseFrom);



    if (!_validateInput(baseFrom, valueFrom) ){
      for (int i = 0; i < 4; ++i){
        convertedValues.add(ERROR1);
      }
      return convertedValues;
    } else {
      valueFromInt = toDecimal(baseFromInt, valueFrom);
      try {
        for (int i = 1; i < BASES.length; ++i) {
          convertedValues.add(valueFromInt.toRadixString(int.parse(BASES.elementAt(i))).toUpperCase());
        }
      } catch (e) {
        print(e);
      }

    }
    return convertedValues;
  }

  static int toDecimal (int baseFrom, String valueFrom) {
    int decimalVal = 0;

    for (int i = 0; i < valueFrom.length; ++i) {
      decimalVal += base16Digits[valueFrom[i]]  * pow(baseFrom, valueFrom.length - i - 1);
    }

    return decimalVal;
  }

  static bool _validateInput (String base, String input) {

    for (int i = 0; i < input.length; ++i) {
      if ((base16Digits[input[i]] == null) || (base16Digits[input[i]] >= int.parse(base))) {
        return false;
      }
    }
    return true;
  }
}