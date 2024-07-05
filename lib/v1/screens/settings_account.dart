import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:octo_image/octo_image.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/controllers/controllers.dart';
import 'package:zula/v1/screens/settings_liked_items.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/app_button.dart';
import 'package:zula/v1/widgets/image_blur_backdrop.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';

class AppAccountSection extends StatelessWidget {
  const AppAccountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Obx(() {
      return Column(
        children: [
          title(
              text: 'Account',
              fontSize: 46.sp,
              color: brandPrimaryColor,
              textAlign: TextAlign.center),
          30.ph,
          authController.profilePic.value.isNotEmpty
              ? SizedBox(
                  width: 180.w,
                  height: 180.w,
                  child: ClipOval(
                    child: OctoImage(
                      placeholderBuilder: OctoBlurHashFix.placeHolder(
                          'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                      errorBuilder: OctoError.icon(color: Colors.red),
                      image: CachedNetworkImageProvider(
                        authController.profilePic.value,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : CircleAvatar(
                  maxRadius: 80,
                  backgroundColor: brandSecondaryColor.withOpacity(0.6),
                  child: Icon(
                    LucideIcons.user,
                    size: 80,
                    color: brandPrimaryColor,
                  ),
                ),
                20.ph,
          Column(
            children: [
              headingBig(text: authController.name.value),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(LineIcons.birthdayCake),
                  10.pw,
                  paragraph(text: 'Since'),
                  10.pw,
                  paragraph(text: 'Jan, 2024'),
                ],
              ),
            ],
          ),
          30.ph,

          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
                color: brandPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(LineIcons.at),
                    10.pw,
                    paragraph(text: 'Email'),
                    const Spacer(),
                    paragraph(text: authController.emailAddress.value),
                  ],
                ),
                20.ph,
                Row(
                  children: [
                    const Icon(LineIcons.locationArrow),
                    10.pw,
                    paragraph(text: 'Location'),
                    const Spacer(),
                    paragraph(text: 'Kampala, Uganda'),
                  ],
                ),
                20.ph,
                Row(
                  children: [
                    const Icon(LineIcons.clock),
                    10.pw,
                    paragraph(text: 'Last Sign In'),
                    const Spacer(),
                    paragraph(text: authController.lastSignInDate.value),
                  ],
                ),
                20.ph,
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    ScreenOverlay.showAppSheet(context,
                        sheet: const SavedItems());
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        const Icon(LineIcons.heart),
                        10.pw,
                        paragraph(text: 'Saved Items'),
                        const Spacer(),
                        paragraph(text: 'View'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
         
         
          35.ph,
          AppButton(
              labelText: 'Log Out',
              action: () {
                ScreenOverlay.showConfirmationDialog(context,
                    titleText: 'Log out ',
                    description:
                        'Confirm if you would like to log out of the app.',
                    action: () {
                  authController.guestLogout();
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              }),
          30.ph,
        ],
      );
    });
  }
}
