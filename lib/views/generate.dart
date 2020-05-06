import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_shortener/locator.dart';
import 'package:link_shortener/models/short_link.dart';
import 'package:link_shortener/services/shortening.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneratePage extends StatefulWidget {
  @override
  _GeneratePageState createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  final _formKey = GlobalKey<FormState>();
  final _shorteningService = locator<ShorteningService>();

  final longUrlController = TextEditingController();
  final generatedLinks = List<ShortLink>();

  @override
  void dispose() {
    longUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Link Shortener'),
      ),
      body: Container(
        constraints: BoxConstraints(
          maxWidth: 800.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: longUrlController,
                      decoration: InputDecoration(
                        hintText: 'Paste a long URL',
                      ),
                      validator: (text) {
                        return _shorteningService.validateLongUrl(text) ? null : 'Invalid URL';
                      },
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final longUrl = longUrlController.value.text;
                          final shortUrl = await _shorteningService.shortenUrl(longUrl);

                          setState(() {
                            generatedLinks.insert(0, shortUrl);
                          });
                        }
                      },
                      child: Text('Shorten URL'),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Expanded(
                child: ListView.builder(
                  itemCount: generatedLinks.length,
                  itemBuilder: (context, index) {
                    final link = generatedLinks[index];

                    return ListTile(
                      title: Text(link.url),
                      trailing: Wrap(
                        children: <Widget>[
                          FlatButton(
                            child: Icon(Icons.content_copy),
                            onPressed: () => Clipboard.setData(ClipboardData(text: link.url)),
                          ),
                          FlatButton(
                            child: Icon(Icons.open_in_new),
                            onPressed: () => launch(link.url),
                          ),
                          FlatButton(
                            child: Icon(Icons.show_chart),
                            onPressed: () => launch(link.reportUrl),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
