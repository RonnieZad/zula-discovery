import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/constants/strings.dart';
import 'package:zula/v1/controllers/auth_controller.dart';
import 'package:zula/v1/screens/docs.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:zula/v1/widgets/image_blur_backdrop.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  AuthController authController = Get.find();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    super.initState();
  }

  final deviceInfoPlugin = DeviceInfoPlugin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Stack(alignment: Alignment.bottomCenter, children: [
        Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 0.0,
          right: -250.0,
          child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.white, Colors.transparent],
                  stops: [0.6, 1],
                ).createShader(
                  Rect.fromLTRB(
                    0,
                    0,
                    bounds.width,
                    bounds.height,
                  ),
                );
              },
              // blendMode: BlendMode.dstATop,
              child: OctoImage(
                placeholderBuilder:
                    OctoBlurHashFix.placeHolder('LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                errorBuilder: OctoError.icon(color: Colors.red),
                image: CachedNetworkImageProvider(
                  imageUrlList[2],
                ),
                fit: BoxFit.cover,
              )),
        ),
        Positioned(
          bottom: 30.h,
          left: 20.w,
          right: 20.w,
          top: 0.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              SvgPicture.asset(
                'assets/images/zula_logo.svg',
                width: 300.w,
                color: Colors.white,
              ),
              20.ph,
              paragraph(
                  text: 'Discover endless adventures. Your journey begins here',
                  color: Colors.white,
                  textAlign: TextAlign.center,
                  fontSize: 24.sp),
              70.ph,
              CupertinoButton(
                  borderRadius: BorderRadius.circular(50.0),
                  color: brandPrimaryColor,
                  child: label(text: 'Get Started Already!'),
                  onPressed: () {
                    authController.guestLogin(context);
                  }),
              20.ph,
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DocsPages(
                                termsOfServie: termsCondtionsText,
                                headingText: 'Zula App\nTerms and Conditions',
                              )));
                },
                child: label(
                  text: 'See Terms and Conditions',
                  color: brandPrimaryColor,
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
