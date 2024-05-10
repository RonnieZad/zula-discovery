import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
import 'package:zula/v1/widgets/app_background.dart';
import 'package:zula/v1/widgets/app_button.dart';
import 'package:zula/v1/widgets/content_loading_widget.dart';
import 'package:zula/v1/widgets/image_blur_backdrop.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage>
    with TickerProviderStateMixin {
  AuthController authController = Get.find();
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     systemNavigationBarColor: Colors.white,
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //   ),
    // );
    super.initState();
  }

  List<String> rowOne = [imageUrlList[0], imageUrlList[1], imageUrlList[2]];
  List<String> rowTwo = [imageUrlList[3], imageUrlList[4], imageUrlList[5]];

  final deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // add setCurrentScreeninstead of initState because might not always give you the
    // expected results because initState() is called before the widget
    // is fully initialized, so the screen might not be visible yet.
    FirebaseAnalytics.instance
        .logScreenView(screenName: "GetStartedPageScreen");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Obx(() {
          return Stack(alignment: Alignment.bottomCenter, children: [
            const AppBackground(),
            RollingCards(
              controller: _controller,
              cards: rowOne,
              relativeRects: [
                RelativeRect.fromSize(Rect.fromLTWH(15.w, -80.h, 160.w, 10.h),
                    Size(420.w, 100.h)),
                RelativeRect.fromSize(
                    Rect.fromLTWH(15.w, 0.h, 160.w, 10.h), Size(420.w, 100.h)),
              ],
            ),
            RollingCards(
              controller: _controller,
              cards: rowTwo,
              relativeRects: [
                RelativeRect.fromSize(Rect.fromLTWH(245.w, -10.h, 160.w, 10.h),
                    Size(420.w, 100.h)),
                RelativeRect.fromSize(Rect.fromLTWH(245.w, -80.h, 160.w, 10.h),
                    Size(420.w, 100.h)),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.5, 0.7],
                      colors: [Colors.white10, Colors.white])),
            ),
            Positioned(
              bottom: 20.h,
              left: 20.w,
              right: 20.w,
              top: 0.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/images/app_logo.svg',
                    width: 380.w,
                    color: brandPrimaryColor,
                  ),
                  10.ph,
                  paragraph(
                      text:
                          'Discover endless adventures. Your journey begins here',
                      color: brandPrimaryColor.withOpacity(0.8),
                      textAlign: TextAlign.center,
                      fontSize: 22.sp),
                  30.ph,
                  AppButton(
                          hasPadding: false,
                          labelText: 'Get Started Already!',
                          action: () {
                            authController.signInWithGoogle();
                            // authController.guestLogin(context);

                            FirebaseAnalytics.instance
                                .logSignUp(signUpMethod: 'AnnoynmousLogin');
                          })
                      .animate()
                      .then(delay: 940.ms)
                      .slideY(
                          begin: 0.25,
                          end: 0,
                          delay: 600.ms,
                          duration: 7800.ms,
                          curve: Curves.elasticInOut),
                  15.ph,
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DocsPages(
                                    termsOfServie: termsCondtionsText,
                                    headingText:
                                        'Zula App\nTerms and Conditions',
                                  )));
                    },
                    child: label(
                      text: 'See Terms and Conditions',
                      color: brandPrimaryColor,
                    ),
                  )
                ]
                    .animate(interval: 300.ms)
                    .then(delay: 240.ms)
                    .blurXY(begin: 1, end: 0)
                    .slideY(begin: 0.2, end: 0.0)
                    .fade(duration: 500.ms),
              ),
            ),
            authController.isAuthLoading.value
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                    child: const ContentLoadingWidget(hasPadding: false))
                : const SizedBox.shrink()
          ]);
        });
      }),
    );
  }
}

class RollingCards extends StatelessWidget {
  const RollingCards({
    Key? key,
    required AnimationController controller,
    required this.cards,
    required this.relativeRects,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;
  final List<String> cards;
  final List<RelativeRect> relativeRects;

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: RelativeRectTween(begin: relativeRects[1], end: relativeRects[0])
          .animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      )),
      child: ListView.builder(
        itemCount: cards.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.w),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: OctoImage(
                  placeholderBuilder: OctoBlurHashFix.placeHolder(
                      'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                  errorBuilder: OctoError.icon(color: Colors.red),
                  image: CachedNetworkImageProvider(
                    cards[index],
                  ),
                  fit: BoxFit.cover,
                  height: 240.h,
                  width: 80.w,
                )),
          );
        },
      ),
    );
  }
}
