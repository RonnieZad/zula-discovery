import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VirtualTourSheet extends StatelessWidget {
  const VirtualTourSheet({
    super.key,
    required this.webViewController,
  });

  final WebViewController webViewController;

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
