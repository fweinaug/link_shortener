import 'dart:convert';

import 'package:flutter/services.dart';

class Configuration {
  final String baseUrl;

  Configuration({
    this.baseUrl,
  });

  Configuration.fromJson(Map<String, dynamic> json)
    : baseUrl = json['baseUrl'];

  static Future<Configuration> load() async {
    final contents = await rootBundle.loadString(
      'assets/config/app.json',
    );

    final json = jsonDecode(contents);

    return Configuration.fromJson(json);
  }
}
