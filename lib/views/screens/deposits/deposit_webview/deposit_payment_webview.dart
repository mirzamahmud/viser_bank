import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viser_bank/core/route/route.dart';
import 'package:viser_bank/core/utils/my_color.dart';
import 'package:viser_bank/core/utils/my_strings.dart';
import 'package:viser_bank/core/utils/url.dart';
import 'package:viser_bank/views/components/snackbar/show_custom_snackbar.dart';
import 'package:webview_flutter/webview_flutter.dart';



class WebViewExample extends StatefulWidget {
  const WebViewExample({Key? key,required this.redirectUrl}) : super(key: key);
  final String redirectUrl;

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(builder: (BuildContext context) {
        return SafeArea(
          child: WebView(
            initialUrl: widget.redirectUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              if (kDebugMode) {
                //progress
              }
            },
            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {

              if(url=='${UrlContainer.domainUrl}user/deposit/history'){
                Get.offAndToNamed(RouteHelper.depositsScreen);
                CustomSnackBar.success(successList: [MyStrings.requestSuccess]);
              } else if(url=='${UrlContainer.baseUrl}user/deposit'){
                Get.back();
                CustomSnackBar.error(errorList: [MyStrings.requestFail]);
              }
            },
            onPageFinished: (String url) {
            },
            gestureNavigationEnabled: true,
            backgroundColor: const Color(0x00000000),
          ),
        );
      }),
      floatingActionButton: favoriteButton(),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
        });
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              backgroundColor: MyColor.colorRed,
              onPressed: () async {
                Get.back();
              },
              child: const Icon(Icons.cancel,color: MyColor.colorWhite,),
            );
          }
          return Container();
        });
  }
}

