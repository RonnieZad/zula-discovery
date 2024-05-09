import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/controllers/notification_controller.dart';
import 'package:zula/v1/controllers/ticket_controller.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/helper.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/app_button.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';

import '../widgets/content_loading_widget.dart';

class NotificationCenter extends StatefulWidget {
  const NotificationCenter({super.key});

  @override
  State<NotificationCenter> createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  NotificationController notificationController =
      Get.put(NotificationController());

  TickerController tickerController = Get.find();

  @override
  void initState() {
    notificationController.getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 0.8.sh,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            title(
                text: 'Notification Center',
                fontSize: 46.sp,
                color: brandPrimaryColor,
                fontFamily: 'Broncks',
                textAlign: TextAlign.center),
            20.ph,
            notificationController.notficationPageIsLoading.value
                ? const ContentLoadingWidget()
                : notificationController.retrievedNotifications.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          140.ph,
                          Icon(
                            LineIcons.bellSlash,
                            size: 120.w,
                          ),
                          15.ph,
                          label(text: 'You have notifications'),
                        ]
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                            )
                            .then(delay: 440.ms)
                            .slideY(
                                begin: 0.1,
                                end: 0,
                                delay: 600.ms,
                                duration: 3800.ms,
                                curve: Curves.elasticInOut),
                      )
                    : Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 15.h),
                            shrinkWrap: true,
                            itemCount: notificationController
                                .retrievedNotifications.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  ScreenOverlay.showAppSheet(context,
                                      playHomeVideoFrame: false,
                                      sheet: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: title(
                                                  text: 'Notification Details',
                                                  fontSize: 46.sp,
                                                  color: brandPrimaryColor,
                                                  fontFamily: 'Broncks',
                                                  textAlign: TextAlign.center),
                                            ),
                                            20.ph,
                                            heading(
                                                text: notificationController
                                                    .retrievedNotifications[
                                                        index]
                                                    .title),
                                            14.ph,
                                            paragraph(
                                                text: notificationController
                                                    .retrievedNotifications[
                                                        index]
                                                    .longDescription,
                                                fontSize: 18.sp),
                                            30.ph,
                                            AppButton(
                                                    hasPadding: false,
                                                    labelText: 'Get Update',
                                                    action: () {
                                                      launchUrl(Uri.parse(
                                                          notificationController
                                                              .retrievedNotifications[
                                                                  index]
                                                              .link!));
                                                    })
                                                .animate()
                                                .then(delay: 940.ms)
                                                .slideY(
                                                    begin: 0.25,
                                                    end: 0,
                                                    delay: 600.ms,
                                                    duration: 7800.ms,
                                                    curve: Curves.elasticInOut),
                                            40.ph,
                                          ],
                                        ),
                                      ));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                          color: brandPrimaryColor,
                                          width: 0.6)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 15.w),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Helper.getNotificationIcon(
                                            notificationController
                                                .retrievedNotifications[index]
                                                .category),
                                        size: 55.w,
                                      ),
                                      20.pw,
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            label(
                                                text: notificationController
                                                    .retrievedNotifications[
                                                        index]
                                                    .title),
                                            paragraph(
                                                text: notificationController
                                                    .retrievedNotifications[
                                                        index]
                                                    .description,
                                                fontSize: 18.sp),
                                            6.ph,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: brandPrimaryColor
                                                        .withOpacity(0.15),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r),
                                                  ),
                                                  padding:
                                                      EdgeInsets.all(2.5.w),
                                                  child: paragraph(
                                                      text: Helper.getDate(
                                                          notificationController
                                                              .retrievedNotifications[
                                                                  index]
                                                              .eventDate),
                                                      fontSize: 18.sp),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
          ],
        ),
      );
    });
  }
}


