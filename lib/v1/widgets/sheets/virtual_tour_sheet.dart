import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';

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
  bool showLoader = true;

  @override
  void initState() {
    webViewController = WebViewController()
    
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print(progress);
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              showLoader = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              showLoader = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.virtualTourPreviewUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
            height: 1.sh,
            width: double.infinity,
            child: WebViewWidget(controller: webViewController)),
        showLoader
            ? Center(
                child: Column(
                  children: [
                    240.ph,
                    Lottie.asset('splash_animation'.toJson,
                        width: 100.w, height: 100.w),
                    10.ph,
                    paragraph(text: 'Loading, please wait')
                  ],
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
