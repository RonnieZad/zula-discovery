import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/constants/strings.dart';
import 'package:zula/v1/screens/docs.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/link_parser.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/screen_overlay.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    Key? key,
    this.routeName,
    required this.iconData,
    required this.subHeading,
    required this.title,
  }) : super(key: key);

  final IconData iconData;
  final String subHeading;
  final String title;
  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        if (routeName != null) {
          switch (routeName) {
            case 'termsOfService':
            Navigator.push(context, MaterialPageRoute(builder: 
            (context)=>DocsPages(termsOfServie: termsOfServie, headingText: 'Zula App\nTerms of Service',)));
              break;

               case 'privacyPolicy':
            Navigator.push(context, MaterialPageRoute(builder: 
            (context)=>DocsPages(
              textAlign: TextAlign.left,
              termsOfServie: privacyPolicyText, headingText: 'Zula App\nPrivacy Policy',)));
              break;


              

            case 'helpCenter':
              ScreenOverlay.showConfirmationDialog(context,
                  titleText: 'Help Center via Whatsapp',
                  description:
                      'This action will open whatsapp to start a chat with our team',
                  action: () {
                LinkParser.launchWhatsappHelpCenter();
              });

              break;

            case 'changePassword':
              break;

            default:
              Navigator.pushNamed(context, routeName!, arguments: true);
          }
        }
      },
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.symmetric(vertical: 15.h),
        child: Column(
          children: [
            
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(iconData, size: 24.w, color: brandPrimaryColor),
                        10.pw,
                        heading(
                            text: title, fontSize: 24.sp, color: brandPrimaryColor)
                      ],
                    ),
                    6.ph,
                    SizedBox(
                        width: 390.w,
                        child: paragraph(
                            color: brandPrimaryColor.withOpacity(0.8),
                            text: subHeading,
                            fontSize: 21.sp))
                  ],
                ),
                Positioned(
                  top: 20.h,
                  right: 0.0,
                  child: Icon(
                    CupertinoIcons.right_chevron,
                    size: 20.w,
                    color: brandPrimaryColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



// class ResetPassword extends StatelessWidget {
//   const ResetPassword({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController resetTokenController = TextEditingController();
//     final TextEditingController newPasswordController = TextEditingController();
//     final TextEditingController confirmNewPasswordController =
//         TextEditingController();
//     final PageController pageController = PageController();
//     return Padding(
//       padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
//       child: ExpandablePageView(
//         physics: const NeverScrollableScrollPhysics(),
//         controller: pageController,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               captionBold(text: 'Reset Password'),
//               20.ph,
//               paragraph(
//                   text:
//                       'A reset token has been sent to your phone number ${GetStorage().read('user_phone_number').replaceRange(GetStorage().read('user_phone_number').length - 4, GetStorage().read('user_phone_number').length, '****')}'),
           
//               AppButton(
//                   buttonText: 'Continue',
//                   action: () {
//                     ApiService.postRequest(
//                         endPoint: '/verify_reset_token',
//                         service: Services.authentication,
//                         body: {
//                           "password_reset_token": resetTokenController.text
//                         }).then((response) async {
//                       print(response);
//                       if (response['payload']['status'] == 200) {
//                         pageController.nextPage(
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.linear);

//                         ScreenOverlay.showToast('Reset Token Verified',
//                             response['payload']['message']);
//                       } else {
//                         ScreenOverlay.showToast('Failed to verify token',
//                             'Enter correct token and try again',
//                             isError: true);
//                       }
//                     });
//                   }),
//               15.ph,
//             ],
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               captionBold(text: 'Set New Password'),
//               20.ph,
//               paragraph(
//                   text:
//                       'Set up a new password and write it down to remember it when logging in next time'),
//               25.ph,
//               AppTextBox(
//                   isPassword: true,
//                   textInputType: TextInputType.text,
//                   textController: newPasswordController,
//                   title: 'Enter New Password',
//                   hint: 'must at least be 6 characters'),
//               15.ph,
//               AppTextBox(
//                   isPassword: true,
//                   textInputType: TextInputType.text,
//                   textController: confirmNewPasswordController,
//                   title: 'Confirm New Password',
//                   hint: 'both passwords must match'),
//               25.ph,
//               AppButton(
//                   buttonText: 'Finish Updating Password',
//                   action: () {
//                     // Estimate the password's strength.
                 
//                   }),
//               15.ph,
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
