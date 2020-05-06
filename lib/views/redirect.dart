import 'package:flutter/material.dart';
import 'package:link_shortener/locator.dart';
import 'package:link_shortener/services/redirect_with_tracking.dart';

class RedirectPage extends StatefulWidget {
  RedirectPage(this.linkEnding);

  final String linkEnding;

  @override
  _RedirectPageState createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  final _redirectWithTrackingService = locator<RedirectWithTrackingService>();

  @override
  void initState() {
    super.initState();

    _redirectWithTrackingService.trackClickAndRedirectToLink(widget.linkEnding);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
