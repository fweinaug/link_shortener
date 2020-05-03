import 'package:flutter/material.dart';
import 'package:link_shortener/views/generate.dart';
import 'package:link_shortener/views/redirect.dart';
import 'package:link_shortener/views/report.dart';

class Router {
  static Route onGenerateRoute(RouteSettings settings) {
    final linkData = LinkData.parse(settings.name);

    if (linkData.hasEnding) {
      if (linkData.viewReport) {
        return MaterialPageRoute(builder: (context) => ReportPage(linkData.ending));
      } else {
        return MaterialPageRoute(builder: (context) => RedirectPage(linkData.ending));
      }
    }

    return MaterialPageRoute(builder: (context) => GeneratePage());
  }
}

class LinkData {
  LinkData(this.ending, this.viewReport);

  final String ending;
  final bool viewReport;

  bool get hasEnding => ending != null && ending.isNotEmpty;

  static LinkData parse(String s) {
    String ending = s.replaceAll('/', '');
    bool viewReport = false;

    if (ending.endsWith('~')) {
      viewReport = true;
      ending = ending.substring(0, ending.length - 1);
    }

    return LinkData(ending, viewReport);
  }
}
