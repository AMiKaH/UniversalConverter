import 'package:baseconverter/pages/TabbedPage.dart';
import 'package:baseconverter/pages/FExchangePage.dart';
import 'package:baseconverter/pages/MainPage.dart';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/'   : (cotext) => MainPage(),
    '/converter'   : (cotext) => TabbedPage(),
    '/currency' : (context) => FExchangePage(),
  },
));
