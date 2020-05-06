// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:link_shortener/infrastructure/firestore_client.dart';
import 'package:link_shortener/locator.dart';

class RedirectWithTrackingService {
  final FirestoreClient firestoreClient = locator<FirestoreClient>();

  Future<bool> trackClickAndRedirectToLink(String linkEnding) async {
    final redirectUrl = await firestoreClient.getRedirectUrl(linkEnding);

    if (redirectUrl != null && redirectUrl.isNotEmpty) {
      await firestoreClient.addLinkClick(linkEnding);

      html.window.location.href = redirectUrl;

      return true;
    }

    return false;
  }
}
