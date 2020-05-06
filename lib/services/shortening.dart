import 'package:link_shortener/configuration.dart';
import 'package:link_shortener/infrastructure/firestore_client.dart';
import 'package:link_shortener/locator.dart';
import 'package:link_shortener/models/short_link.dart';

class ShorteningService {
  final Configuration configuration = locator<Configuration>();
  final FirestoreClient firestoreClient = locator<FirestoreClient>();

  Future<ShortLink> shortenUrl(String longUrl) async {
    final shortLink = ShortLink.create(longUrl, baseUrl: configuration.baseUrl);

    if (shortLink != null) {
      await firestoreClient.addLink(shortLink);
    }

    return shortLink;
  }

  bool validateLongUrl(String url) {
    return validateUrl(url, configuration.baseUrl);
  }
}
