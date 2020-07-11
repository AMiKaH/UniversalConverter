import 'package:baseconverter/constants/StringsConstants.dart';
import 'dart:convert';
import 'dart:math';
import 'package:unit_converter/unit_converter.dart';

class UnitConverterClass {
  static final List<String> scale = <String>[
    'Select scale',
    'Temperature',
    'Distance/Length',
    'Area',
    'Mass',
    'Volume',
    'Speed',
  ];

  static final List<String> temparetureScale = [
    'Select unit',
    'Celsius',
    'Fahrenheight',
    'Kelvin'
  ];

  static final List<String> distanceScale = [
    'Select unit',
    'Millimetre',
    'Centimetre',
    'Metre',
    'Kilometre',
    'Inch',
    'Foot',
    'Yard',
    'Mile'
  ];

  static final List<String> areaScale = [
    'Select unit',
    'Millimetre²',
    'Centimetre²',
    'Metre²',
    'Kilometre²',
    'Inch²',
    'Foot²',
    'Yard²',
    'Mile²'
  ];

  static final List<String> massScale = [
    'Select unit',
    'Miligram',
    'Gram',
    'Kilogram',
    'Tonne',
    'Ounce',
    'Pound',
    'Stone',
    'Ton'
  ];

  static final List<String> volumeScale = [
    'Select unit',
    'Millilitre',
    'Litre',
    'Ounce',
    'Pint',
    'Quart',
    'Gallon'
  ];

  static final List<String> speedScale = [
    'Select unit',
    'Metre/Second',
    'Metre/Hour',
    'KM/Second',
    'KM/H',
    'Mile/Second',
    'Mile/Hour'
  ];

  static final List<String> nullScale = [
    'No units available'
  ];

  static final Map<String, double> unitsOffsetToMeter = {
    'Millimetre' : 0.001,
    'Centimetre' : 0.01,
    'Metre'      : 1,
    'Kilometre'  : 1000,
    'Inch'       : 0.0254,
    'Foot'       : 0.3048,
    'Yard'       : 0.9144,
    'Mile'       : 1609.34,
  };

  static final Map<String, double> unitsOffsetToKG = {
    'Milligram' : 0.0000001,
    'Gram'      : 0.001,
    'Kilogram'  : 1,
    'Tonne'     : 1000,
    'Ounce'     : 0.0283495,
    'Pound'     : 0.453592,
    'Stone'     : 6.35029,
  };

  static final Map<String, double> unitsOffsetToLitre = {
    'Millilitre' : 0.0000001,
    'Litre'      : 1,
    'Ounce'      : 0.0295735,
    'Pint'       : 0.473176,
    'Quart'      : 0.946353,
    'Gallon'     : 3.78541
  };

  static final Map<String, double> unitsOffsetToKPH = {
    'Metre/Second' : 3.6,
    'Metre/Hour'   : 0.001,
    'KM/Second'    : 3600,
    'KM/H'         : 1,
    'Mile/Second'  : 5794,
    'Mile/Hour'    : 1.609,
  };

  static final Map<String, double> unitsOffsetToCelsius = {
    'Celsius' : 1,
    'fahrenheit' : 33.8,
    'kelvin' : 274.15
  };

  static Map<String, double> convert(String scale, String unit, double inputValue) {
    switch (scale) {
      case 'Tempareture':
        return convertTemperature(unit, inputValue);
        break;
      case 'Distance/Length':
        return convertDistance(unit, inputValue);
        break;
      case'Area':
        return convertArea(unit, inputValue);
        break;
      case 'Mass':
        return convertMass(unit, inputValue);
        break;
      case 'Volume':
        return convertVolume(unit, inputValue);
        break;
      case 'Speed':
        return convertSpeed(unit, inputValue);
        break;
      default:
        return convertTemperature(unit, inputValue);
    }
  }

  static Map<String, double> convertTemperature(String unit, double inputValue){
    Map<String, double>  results = {};

    switch (unit) {
      case 'Celsius':
        results['Celsius'] = inputValue;
        results['Fahrenheight'] = double
            .parse((inputValue * 1.8 + 32)
            .toStringAsFixed(2));
        results['Kelvin'] = double
            .parse((inputValue + 273.15)
            .toStringAsFixed(2));
        break;
      case 'Fahrenheight':
        results['Celsius'] = double
            .parse(((inputValue - 32) / 1.8)
            .toStringAsFixed(2));
        results['Fahrenheight'] = inputValue;
        results['Kelvin'] = double
            .parse(((inputValue - 32) * (5/9) + 273.15)
            .toStringAsFixed(2));
        break;
      case 'Kelvin':
        results['Celsius'] = double
            .parse((inputValue - 273.15)
            .toStringAsFixed(2));
        results['Fahrenheight'] = double
            .parse(((inputValue - 273.15) * (9/5) + 32)
            .toStringAsFixed(2) );
        results['Kelvin'] = inputValue;
        break;
    }
    return results;
  }

  static Map<String, double> convertDistance(String unit, double inputValue){
    Map<String, double>  results = {};
    double baseUnit = 0;

    if (unit[unit.length - 1] == '²')
      unit = unit.substring(0, unit.length - 1);

    baseUnit = unitsOffsetToMeter[unit] * inputValue;

    unitsOffsetToMeter.forEach((key, value) {
      results[key] = (double.parse((baseUnit/value).toStringAsFixed(6)));
    });

    return results;
  }

  static Map<String, double> convertArea(String unit, double inputValue){
    Map<String, double>  results = convertDistance(unit, inputValue);
    Map<String, double>  newResults = {};

    results.forEach((key, value) {
      newResults[key + '²'] = value*value/100;
    });
    return newResults;
  }

  static Map<String, double> convertMass(String unit, double inputValue){
    Map<String, double>  results = {};
    double baseUnit = 0;

    baseUnit = unitsOffsetToKG[unit] * inputValue;

    unitsOffsetToKG.forEach((key, value) {
      results[key] = (double.parse((baseUnit/value).toStringAsFixed(6)));
    });

    return results;
  }

  static Map<String, double> convertVolume(String unit, double inputValue){
    Map<String, double>  results = {};
    double baseUnit = 0;

    baseUnit = unitsOffsetToLitre[unit] * inputValue;

    unitsOffsetToLitre.forEach((key, value) {
      results[key] = (double.parse((baseUnit/value).toStringAsFixed(6)));
    });

    return results;
  }

  static Map<String, double> convertSpeed(String unit, double inputValue){
    Map<String, double>  results = {};
    double baseUnit = 0;

    baseUnit = unitsOffsetToKPH[unit] * inputValue;

    unitsOffsetToKPH.forEach((key, value) {
      results[key] = (double.parse((baseUnit / value).toStringAsFixed(6)));
    });

    return results;
  }

  }