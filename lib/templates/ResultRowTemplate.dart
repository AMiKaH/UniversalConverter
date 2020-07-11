
import 'package:baseconverter/constants/ColorConstants.dart';
import 'package:flutter/cupertino.dart';

class ResultRowTemplate extends  StatelessWidget {
  String label;
  String value;

  ResultRowTemplate (String label, String value) {
    this.label = label;
    this.value = value;
  }


  @override
  Widget build(BuildContext context) {
    return getResultRow(context, label, value);
  }

  Widget getResultRow(BuildContext context, String label, String value) {
    return Row (
      children: <Widget>[
        SizedBox(height: 50),
        Expanded (
          flex: 35,
          child: Text (
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorConstants.textWhite,
              ),
          )
        ),
        Expanded(
          flex: 60,
          child: Text (
              value,
              style: TextStyle(
                fontSize: 18,
                color: ColorConstants.textWhite,
              ),
          ),
        )
      ],
    );
  }
}