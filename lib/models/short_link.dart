import 'package:shortid/shortid.dart';

class ShortLink {
  final String ending;
  final String url;
  final String redirectUrl;

  ShortLink({
    this.ending,
    this.url,
    this.redirectUrl,
  });

  static ShortLink create(String redirectUrl, {String baseUrl}) {
    if (baseUrl == null || baseUrl.isEmpty) {
      throw Exception('Unknown baseUrl');
    }

    if (!validateUrl(redirectUrl, baseUrl)) {
      throw Exception('Invalid redirectUrl');
    }

    final ending = shortid.generate();

    return ShortLink(
      ending: ending,
      url: buildShortUrl(ending, baseUrl),
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

String buildShortUrl(String baseUrl, String ending) {
  var url = baseUrl;
  if (!url.endsWith('/')) {
    url += '/';
  }

  url += ending;

  return url;
}
