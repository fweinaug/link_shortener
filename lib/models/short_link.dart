import 'package:link_shortener/router.dart';
import 'package:shortid/shortid.dart';

class ShortLink {
  final String ending;
  final String url;
  final String reportUrl;
  final String redirectUrl;

  ShortLink({
    this.ending,
    this.url,
    this.reportUrl,
    this.redirectUrl,
  });

  static ShortLink create(String redirectUrl, {String baseUrl}) {
    if (baseUrl == null || baseUrl.isEmpty) {
      return null;
    }

    if (!validateUrl(redirectUrl, baseUrl)) {
      return null;
    }

    final ending = shortid.generate();

    return ShortLink(
      ending: ending,
      url: buildShortUrl(baseUrl, ending),
      reportUrl: buildReportUrl(baseUrl, ending),
      redirectUrl: redirectUrl,
    );
  }
}

bool validateUrl(String url, String baseUrl) {
  if (url == null || url.isEmpty) {
    return false;
  }

  final uri = Uri.tryParse(url);
  if (uri == null) {
    return false;
  }

  if (!uri.isScheme("HTTPS")) {
    return false;
  }

  final baseUri = Uri.parse(baseUrl);
  if (uri.host == baseUri.host) {
    return false;
  }

  return true;
}
