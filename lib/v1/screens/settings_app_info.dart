import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/app_button.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';
import 'package:zula/v1/widgets/sheets/share_sheet.dart';

class AppAboutSection extends StatelessWidget {
  const AppAboutSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title(
            text: 'About App',
            fontSize: 46.sp,
            color: brandPrimaryColor,
            fontFamily: 'Broncks',
            textAlign: TextAlign.center),
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
                  const Icon(LineIcons.boxOpen),
                  10.pw,
                  paragraph(text: 'App Name'),
                  const Spacer(),
                  paragraph(text: 'Zula Vibe'),
                ],
              ),
              20.ph,
              Row(
                children: [
                  const Icon(LineIcons.cog),
                  10.pw,
                  paragraph(text: 'App Version'),
                  const Spacer(),
                  paragraph(text: 'v1.0.11+33 Beta'),
                ],
              ),
              20.ph,
              Row(
                children: [
                  const Icon(LineIcons.clock),
                  10.pw,
                  paragraph(text: 'Last Updated'),
                  const Spacer(),
                  paragraph(text: '04/05/2024'),
                ],
              ),
            ],
          ),
        ),
        35.ph,
        AppButton(
            labelText: 'Share app',
            action: () {
              HapticFeedback.lightImpact();
              ScreenOverlay.showAppSheet(context,
                  playHomeVideoFrame: false, sheet: const ShareSheet());
            }),
        30.ph,
        paragraph(
          text: 'Made with ❤️ by\nZula Vibe LTD',
          textAlign: TextAlign.center,
        ),
        30.ph,
      ],
    );
  }
}
