import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class Report extends StatelessWidget {

  var html;

   Report(this.html, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String _htmlContent = '''$html''';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            height: 1500,
            child: WebViewPlus(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                controller.loadString(_htmlContent);
              },
            ),
          ),
        ),
      ),
    );
  }
}