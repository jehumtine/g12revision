import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/app_colors.dart';
import '../widgets/custom_text_styles.dart';

class WebScreen extends StatefulWidget {
  final String url;
  final String name;
  final bool? showAppbar;
  const WebScreen(
      {Key? key, required this.url, required this.name, this.showAppbar = true})
      : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen>
    with AutomaticKeepAliveClientMixin {
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  final UniqueKey _key = UniqueKey();

  @override
  bool get wantKeepAlive => true;
  late WebViewController controller;
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        } else {
          Get.back();
          return false;
        }
      },
      child: Scaffold(
        appBar: widget.showAppbar == true
            ? AppBar(
                backgroundColor: purpleColor,
                title: Text(
                  widget.name,
                  style: kHeaderTS,
                ),
                actions: [
                    IconButton(
                        onPressed: () async {
                          if (await controller.canGoBack()) {
                            controller.goBack();
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: whiteColor,
                        )),
                    IconButton(
                        onPressed: () {
                          controller.clearCache();
                          CookieManager().clearCookies();
                        },
                        icon: const Icon(
                          Icons.clear,
                          size: 20,
                          color: whiteColor,
                        )),
                  ])
            : null,
        body: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.black12,
              color: darkOrangeColor,
            ),
            Expanded(
              child: WebView(
                  gestureRecognizers: gestureRecognizers,
                  key: _key,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: widget.url,
                  onWebViewCreated: (controller) {
                    this.controller = controller;
                  },
                  // progress indicator
                  onProgress: (progress) => setState(() {
                        this.progress = progress / 100;
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
