
import 'package:baseconverter/constants/ColorConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CurrencyCardTemplate extends  StatelessWidget {
  String currencyCode;
  String value;

  CurrencyCardTemplate (String currencyCode, String value) {
    this.currencyCode = currencyCode;
    this.value = value;
  }


  @override
  Widget build(BuildContext context) {
    return getResultRow(context, currencyCode, value);
  }

  Widget getResultRow(BuildContext context, String currencyCode, String value) {
    return Padding(

      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4),
      child: Card(
        color: Colors.transparent,
        child: ListTile(
          onTap: () {
          },
          title: Row(
            children: <Widget>[
              Expanded(
                flex: 25,
                child: Text(
                  currencyCode + ' ',
                  style: TextStyle (
                    color: ColorConstants.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 100,
                child: Text(
                  value,
                  style: TextStyle (
                    color: ColorConstants.textWhite,
                  ),
                ),
              ),
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: AssetImage(
                'assets/currency/${currencyCode.toLowerCase()}.png'
            ),
          ),
        ),
      ),
    );
  }
}