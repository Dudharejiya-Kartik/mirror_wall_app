import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../provider/web_provider.dart';
import 'components/app_bar.dart';
import 'components/bottom_bar.dart';

class WebPage extends StatelessWidget {
  const WebPage({super.key});

  @override
  Widget build(BuildContext context) {
    final providerTrue = Provider.of<WebProvider>(context);
    final providerFalse = Provider.of<WebProvider>(context, listen: false);

    TextEditingController txtSearchedText = TextEditingController();
    return Scaffold(
      appBar: WebViewAppBar(providerTrue, providerFalse, context),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri('https://www.google.com/'),
            ),
            onWebViewCreated: (controller) =>
                providerTrue.webViewController = controller,
            onProgressChanged: (controller, progress) =>
                providerFalse.onProgressChanged(progress),
            onLoadStop: (controller, url) async {
              await providerFalse.updateSearchedUrl(url, controller.getTitle());

              providerFalse.pullToRefreshController!.endRefreshing();
            },
            pullToRefreshController: providerTrue.pullToRefreshController,
          ),
          if (providerTrue.progress < 1)
            Align(
              alignment: Alignment.bottomCenter,
              child: LinearProgressIndicator(
                value: providerTrue.progress,
                color: Colors.blueAccent,
              ),
            ),
        ],
      ),
      bottomNavigationBar:
          BottomBar(providerTrue: providerTrue, providerFalse: providerFalse),
    );
  }
}
