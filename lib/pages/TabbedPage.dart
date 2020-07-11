


import 'package:baseconverter/classes/BaseConverterClass.dart';
import 'package:baseconverter/classes/UnitConverterClass.dart';
import 'package:baseconverter/constants/ColorConstants.dart';
import 'package:baseconverter/constants/StringsConstants.dart';
import 'package:baseconverter/templates/ResultRowTemplate.dart';
import 'package:baseconverter/templates/UnitResultsTemplate.dart';
import 'package:flutter/material.dart';

class TabbedPage extends StatefulWidget {
  @override
  _TabbedPageState createState() => _TabbedPageState();
}

class _TabbedPageState extends State<TabbedPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  final _baseConverterTextEdit = TextEditingController();
  final _unitConverterTextEdit = TextEditingController();

  String baseFrom;
  String baseTo;
  String selectedScale;
  String selectedUnit;
  List<String> results;
  Map<String, double>  unitsResults;
  bool isScaleSelected;
  bool isUnitSelected;
  List<String> units;

  final List<Tab> tabs = <Tab>[
    Tab(text: 'Base Converter'),
    Tab(text: 'Unit Converter')
  ];


  void initState(){
    super.initState();
    baseFrom = BaseConverterClass.BASES.first;
    selectedScale = UnitConverterClass.scale.first;
    isScaleSelected = false;
    isUnitSelected = false;
    results = ['0', '0', '0', '0'];
    _baseConverterTextEdit.addListener(() {
      final text = _baseConverterTextEdit.text;
      _baseConverterTextEdit.value = _baseConverterTextEdit.value.copyWith(
        text: text,
        selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });

    _unitConverterTextEdit.addListener(() {
      final text = _unitConverterTextEdit.text;
      _unitConverterTextEdit.value = _unitConverterTextEdit.value.copyWith(
        text: text,
        selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });

    tabController = TabController(vsync: this, length: tabs.length);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal[400],
        resizeToAvoidBottomPadding: false,
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
            child: TabBarView(
                controller: tabController,
                children: [
                  getConverter(context),
                  getUnitConverter(context),
                ],
              ),
          ),
              ),
        ),
    );
  }


  Widget getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(StringsConstants.ApplicationName),
      centerTitle: true,
      elevation: 1,
      bottom: TabBar(
        controller: tabController,
        tabs: tabs,
      )
    );
  }

  Widget getConverter(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _baseConverterTextEdit,
                     keyboardType: baseFrom != 'Select Base'
                         && double.parse(baseFrom) < 16?
                         TextInputType.number: TextInputType.text,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: ColorConstants.borderActive,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: ColorConstants.borderInactive,
                          ),
                        ),
                      border: OutlineInputBorder(),
                      hintText: StringsConstants.value,
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.textWhite,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.textWhite,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                      StringsConstants.selectBase,
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.textWhite,
                        fontWeight: FontWeight.bold,
                      ),

                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  //width: 100,
                  child: DropdownButton(
                    dropdownColor: Colors.teal[300],
                    //isExpanded: true,
                    value: baseFrom,
                    icon: Icon (
                      Icons.unfold_more,
                      color: Colors.white,
                    ),
                    underline: Container(
                      height: 0,
                      color: Colors.white,
                    ),
                    items: BaseConverterClass.BASES.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,

                            ) ,
                        ),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        baseFrom = newValue;
                      });
                    },
                  ),
                ),
                Container (
                    child: RaisedButton (
                      child: Text (
                        StringsConstants.convert,
                        style: TextStyle(
                          color: ColorConstants.buttonText,
                          fontSize: 18,
                        ),
                      ),
                      color: ColorConstants.actionButton,
                      onPressed: () {
                        setState(() {
                          results = BaseConverterClass.convert(baseFrom, _baseConverterTextEdit.value.text);
                        });
                      },
                    )
                ),
              ],
            ),
            SizedBox(height: 20),
            ResultRowTemplate(StringsConstants.base2 + ':', results[0]),
            ResultRowTemplate(StringsConstants.base8 + ':', results[1]),
            ResultRowTemplate(StringsConstants.base10 + ':', results[2]),
            ResultRowTemplate(StringsConstants.base16 + ':', results[3]),
          ],
        )
    );
  }

  Widget getUnitConverter(BuildContext context) {
    Map<String, double> testMap = {
      'Test1' : 1,
      'Test2' : 2
    };

    return Padding(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Column (
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 5),
                  //width: 100,
                  child: DropdownButton(
                    dropdownColor: Colors.teal[300],
                    //isExpanded: true,
                    value: selectedScale,
                    icon: Icon (
                      Icons.unfold_more,
                      color: Colors.white,
                    ),
                    underline: Container(
                      height: 0,
                      color: Colors.white,
                    ),
                    items: UnitConverterClass.scale.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                      value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ) ,
                        ),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      newValue != UnitConverterClass.scale.first?
                      isScaleSelected = true:
                      isScaleSelected = false;

                      switch (newValue){
                        case 'Tempareture':
                          units = UnitConverterClass.temparetureScale;
                          break;
                        case 'Distance/Length':
                          units = UnitConverterClass.distanceScale;
                          break;
                        case 'Area':
                          units = UnitConverterClass.areaScale;
                          break;
                        case 'Mass':
                          units = UnitConverterClass.massScale;
                          break;
                        case 'Volume':
                          units = UnitConverterClass.volumeScale;
                          break;
                        case 'Speed':
                          units = UnitConverterClass.speedScale;
                          break;
                        default:
                          units = UnitConverterClass.nullScale;
                      }
                      selectedUnit = units[0];
                      setState(() {
                        selectedScale = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            if (isScaleSelected && units != null)
              Container(
                margin: EdgeInsets.only(left: 5),
                //width: 100,
                child: DropdownButton(
                  dropdownColor: Colors.teal[300],
                  //isExpanded: true,
                  value: selectedUnit,
                  icon: Icon (
                    Icons.unfold_more,
                    color: Colors.white,
                  ),
                  underline: Container(
                    height: 0,
                    color: Colors.white,
                  ),
                  items: units.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ) ,
                      ),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    newValue != units.first?
                    isUnitSelected = true:
                    isUnitSelected = false;
                    switch (newValue){
                      case 'areaScale':
                        units = UnitConverterClass.areaScale;
                        break;
                    }
                    setState(() {
                      selectedUnit = newValue;
                    });
                  },
                ),
              ),
            if (isUnitSelected)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 50,
                  child: TextFormField(
                    controller: _unitConverterTextEdit,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(8),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: ColorConstants.borderActive,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: ColorConstants.borderInactive,
                        ),
                      ),
                      border: OutlineInputBorder(),
                      hintText: StringsConstants.value,
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.textWhite,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.textWhite,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded (
                  flex: 25,
                    child: RaisedButton (
                      child: Text (
                        StringsConstants.convert,
                        style: TextStyle(
                          color: ColorConstants.buttonText,
                          fontSize: 18,
                        ),
                      ),
                      color: ColorConstants.actionButton,
                      onPressed: () {
                        setState(() {
                          unitsResults = UnitConverterClass.convert(selectedScale,selectedUnit, double.parse(_unitConverterTextEdit.value.text));
                        });
                      },
                    )
                ),
              ],
            ),
            SizedBox(height: 20),
            if (unitsResults != null)
              Expanded (
                  flex  : 10,
                  child: UnitResultTemplate(unitsResults)
              ),
          ],
        )
    );
  }
}
