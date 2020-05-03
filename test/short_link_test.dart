import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/models/short_link.dart';

void main() {
  const baseUrl = 'https://shortie.io';

  group('Validate URL', () {
    test('Validate empty URL as invalid', () {
      expect(validateUrl(null, baseUrl), false);
      expect(validateUrl('', baseUrl), false);
    });

    test('Validate wrong URL as invalid', () {
      expect(validateUrl('shortie', baseUrl), false);
      expect(validateUrl('shortie.io', baseUrl), false);
    });

    test('Validate URL with wrong schema as invalid', () {
      expect(validateUrl('http://shortie.io', baseUrl), false);
      expect(validateUrl('file://shortie.io', baseUrl), false);
      expect(validateUrl('mailto:hello@shortie.io', baseUrl), false);
    });

    test('Validate URL on same host as invalid', () {
      expect(validateUrl('https://shortie.io', baseUrl), false);
      expect(validateUrl('https://shortie.io/test', baseUrl), false);
    });

    test('Validate correct URL as valid', () {
      expect(validateUrl('https://google.com', baseUrl), true);
      expect(validateUrl('https://www.google.com/search?source=hp&ei=pNauXopvzrKTBb_ilNAG&q=link+shortener&oq=link+shortener&gs_lcp=CgZwc3ktYWIQAzICCAAyAggAMgIIADICCAAyAggAMgIIADICCAAyAggAMgIIADICCAA6BQgAEIMBOg4IABDqAhC0AhCaARDlAlC7BViTH2DsIGgAcAB4AIABogGIAYMJkgEEMTUuMZgBAKABAaoBB2d3cy13aXqwAQY&sclient=psy-ab&ved=0ahUKEwiK0aCV9ZfpAhVO2aQKHT8xBWoQ4dUDCAk&uact=5', baseUrl), true);
      expect(validateUrl('https://stackoverflow.com/questions/tagged/flutter', baseUrl), true);
    });
  });

  test('Create ShortLink', () {
    final link = ShortLink.create('https://stackoverflow.com/questions/tagged/flutter', baseUrl: baseUrl);

    expect(link.ending, isNotEmpty);
    expect(link.url, 'https://shortie.io/${link.ending}');
    expect(link.redirectUrl, 'https://stackoverflow.com/questions/tagged/flutter');
  });
}
