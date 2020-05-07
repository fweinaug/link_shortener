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

  bool notFound = false;

  @override
  void initState() {
    super.initState();

    _redirect();
  }

  void _redirect() async {
    final redirected = await _redirectWithTrackingService.trackClickAndRedirectToLink(widget.linkEnding);

    if (!redirected) {
      setState(() {
        notFound = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (notFound) {
      return Scaffold(
        body: Center(
          child: Text('URL not found'),
        ),
      );
    }

    return Container();
  }
}
