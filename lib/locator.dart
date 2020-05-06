import 'package:get_it/get_it.dart';
import 'package:link_shortener/configuration.dart';
import 'package:link_shortener/infrastructure/firestore_client.dart';
import 'package:link_shortener/services/redirect_with_tracking.dart';
import 'package:link_shortener/services/reporting.dart';
import 'package:link_shortener/services/shortening.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingletonAsync(Configuration.load);

  locator.registerFactory(() => FirestoreClient());

  locator.registerFactory(() => ShorteningService());
  locator.registerFactory(() => RedirectWithTrackingService());
  locator.registerFactory(() => ReportingService());
}
