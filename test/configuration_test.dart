import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/configuration.dart';

void main() {
  test('Load app configuration', () async {
    TestWidgetsFlutterBinding.ensureInitialized();

    final configuration = await Configuration.load();

    expect(configuration.baseUrl, isNotEmpty);
  });
}
