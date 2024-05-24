import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';

class PaymentSheet extends StatefulWidget {
  const PaymentSheet({
    super.key,
    required this.virtualTourPreviewUrl,
  });

  final String virtualTourPreviewUrl;

  @override
  State<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
        
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 40.h, bottom: 100.h),
              child: WebViewWidget(controller: webViewController),
            ),
            showLoader
                ? Center(
                    child: Column(
                      children: [
                        240.ph,
                        Lottie.asset('splash_animation'.toJson,
                            width: 100.w, height: 100.w),
                        10.ph,
                        paragraph(text: 'Loading, please wait')
                      ]
                    ),
                  )
                : const SizedBox.shrink(),
                   Positioned(
                bottom: 30.h,
                left: 120.0,
                right: 120.0,
                child: FilledButton.icon(
                  style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 15)),
                      backgroundColor: WidgetStatePropertyAll(
                          brandPrimaryColor.withOpacity(0.2))),
                  label: paragraph(text: 'Close', color: brandPrimaryColor),
                  icon: Icon(
                    CupertinoIcons.multiply,
                    color: brandPrimaryColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
