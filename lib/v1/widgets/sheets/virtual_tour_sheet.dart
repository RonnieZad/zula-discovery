import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VirtualTourSheet extends StatefulWidget {
  const VirtualTourSheet({
    super.key,
    required this.virtualTourPreviewUrl,
  });

  final String virtualTourPreviewUrl;

  @override
  State<VirtualTourSheet> createState() => _VirtualTourSheetState();
}

class _VirtualTourSheetState extends State<VirtualTourSheet> {
  late WebViewController webViewController;

  @override
  void initState() {
     webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.virtualTourPreviewUrl));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: 1.sh,
            width: double.infinity,
            child: WebViewWidget(controller: webViewController)),
      ],
    );
  }
}
