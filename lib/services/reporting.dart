import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:link_shortener/infrastructure/firestore_client.dart';
import 'package:link_shortener/locator.dart';

class ReportingService {
  final FirestoreClient firestoreClient = locator<FirestoreClient>();

  LinkReport buildReport(String linkEnding) {
    final link = firestoreClient.getLinkSnapshot(linkEnding);
    final clicks = firestoreClient.getLinkClicks(linkEnding);

    return LinkReport(link, clicks);
  }
}

class LinkReport {
  final Stream<DocumentSnapshot> link;
  final Stream<QuerySnapshot> clicks;

  LinkReport(this.link, this.clicks);
}

class TimeSeriesClicks {
  final DateTime time;
  final int totalClicks;

  TimeSeriesClicks(this.time, this.totalClicks);
}

List<TimeSeriesClicks> groupClicksByDate(List<DocumentSnapshot> clicks) {
  final clicksByDate = groupBy(clicks, (click) {
    final timestamp = click['date'] as Timestamp;
    final date = timestamp.toDate();

    return DateTime(date.year, date.month, date.day);
  });

  return clicksByDate.entries.map((e) => TimeSeriesClicks(e.key, e.value.length)).toList();
}
