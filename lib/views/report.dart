import 'package:charts_flutter/flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:link_shortener/locator.dart';
import 'package:link_shortener/services/reporting.dart';

class ReportPage extends StatefulWidget {
  ReportPage(this.linkEnding);

  final String linkEnding;

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _reportingService = locator<ReportingService>();

  LinkReport _report;

  @override
  void initState() {
    super.initState();

    _report = _reportingService.buildReport(widget.linkEnding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          StreamBuilder<DocumentSnapshot>(
            stream: _report.link,
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading...');
              }

              if (!snapshot.data.exists) {
                return Text('Link not found');
              }

              return Column(
                children: <Widget>[
                  Text(
                    snapshot.data['url'],
                  ),
                  Text(
                    snapshot.data['totalClicks'].toString(),
                  ),
                ],
              );
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _report.clicks,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                return TimeSeriesChart(
                  [
                    Series<TimeSeriesClicks, DateTime>(
                      id: 'Clicks',
                      data: groupClicksByDate(snapshot.data.documents),
                      colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
                      domainFn: (TimeSeriesClicks clicks, _) => clicks.time,
                      measureFn: (TimeSeriesClicks clicks, _) => clicks.totalClicks,
                    ),
                  ],
                  animate: true,
                  dateTimeFactory: LocalDateTimeFactory(),
                  behaviors: [
                    ChartTitle('Clicks',
                      behaviorPosition: BehaviorPosition.top,
                      titleOutsideJustification: OutsideJustification.middle,
                      innerPadding: 30,
                    ),
                    LinePointHighlighter(
                        showHorizontalFollowLine:
                        LinePointHighlighterFollowLineType.none,
                        showVerticalFollowLine:
                        LinePointHighlighterFollowLineType.nearest
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
