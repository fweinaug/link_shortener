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

const _reportUrlSymbol = '~';

class LinkData {
  LinkData(this.ending, this.viewReport);

  final String ending;
  final bool viewReport;

  bool get hasEnding => ending != null && ending.isNotEmpty;

  static LinkData parse(String s) {
    String ending = s.replaceAll('/', '');
    bool viewReport = false;

    if (ending.endsWith(_reportUrlSymbol)) {
      viewReport = true;
      ending = ending.substring(0, ending.length - 1);
    }

    return LinkData(ending, viewReport);
  }
}

String buildShortUrl(String baseUrl, String ending) {
  var url = baseUrl;
  if (!url.endsWith('/')) {
    url += '/';
  }

  url += ending;

  return url;
}

String buildReportUrl(String baseUrl, String ending) {
  var url = buildShortUrl(baseUrl, ending);

  url += _reportUrlSymbol;

  return url;
}
