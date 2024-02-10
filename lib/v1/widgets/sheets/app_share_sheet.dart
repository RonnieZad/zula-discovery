// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:lucide_icons/lucide_icons.dart';
// import 'package:nyumba/v1/constants/strings.dart';
// import 'package:nyumba/v1/utils/colors.dart';
// import 'package:nyumba/v1/utils/input_formatter.dart';
// import 'package:nyumba/v1/utils/screen_overlay.dart';
// import 'package:nyumba/v1/utils/utils.dart';
// import 'package:nyumba/v1/widgets/set_up_pocket.dart';
// import 'package:nyumba/v1/widgets/widgets.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class ReedemPerkSheet extends StatelessWidget {
//   const ReedemPerkSheet(
//       {super.key,
//       required this.linkToShare,
//       required this.title,
//       required this.subtitle,
//       required this.voucherLogo});

//   final String linkToShare, title, subtitle, voucherLogo;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           captionBold(text: 'Reedem'),
//           20.ph,
//           Row(
//             children: [
//               CachedNetworkImage(
//                 imageUrl: voucherLogo,
//                 fit: BoxFit.cover,
//                 width: 100,
//               ),
//               10.pw,
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     heading(text: title, fontSize: 25.sp),
//                     5.ph,
//                     paragraph(text: subtitle, fontSize: 21.5.sp),
//                     2.ph,
//                     paragraph(
//                         text:
//                             'Redeemable at all $title branches across the country ',
//                         fontSize: 19.5.sp),
//                   ],
//                 ),
//               )
//             ],
//           ),
//           20.ph,
//           const Divider(),
//           20.ph,
//           Center(
//               child: paragraph(
//                   text:
//                       '● No Cash Value  ● Not valid with any other discounts or promotions',
//                   fontSize: 19.5.sp,
//                   textAlign: TextAlign.center)),
          
//           30.ph,
//           Center(
//               child: ClipRRect(
//             borderRadius: BorderRadius.circular(8.r),
//             child: QrImageView(
//                 gapless: false,
                
//                 dataModuleStyle: const QrDataModuleStyle(
//                     dataModuleShape: QrDataModuleShape.circle),
//                 eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle),
//                 foregroundColor: Colors.white,
//                 backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
//                 data:
//                     'This is a link to Enyumba, get rent financing and deal away with fake conmen starting today. Downlaod at ',
//                 size: 310.w),
//           )),
//           25.ph,
//           Center(
//             child: paragraph(
//                 text:
//                     'Allow vendor to scan this code to redeem it.\nTerms and Condtions Apply.',
//                 textAlign: TextAlign.center,
//                 color: Theme.of(context)
//                     .textTheme
//                     .bodySmall!
//                     .color!
//                     .withOpacity(0.8),
//                 fontSize: 18.6.sp),
//           ),
//           30.ph,
//           Center(
//               child: paragraph(
//                   text: 'Valid until 12th Nov',
//                   fontSize: 19.5.sp,
//                   color: Theme.of(context)
//                       .textTheme
//                       .bodyLarge!
//                       .color!
//                       .withOpacity(0.5))),
//           50.ph,
//         ].animate(interval: 10.ms).slideY(
//             delay: 10.ms, curve: Curves.decelerate, begin: -0.2, end: 0.0),
//       ),
//     );
//   }
// }

// class TransactionsDetailSheet extends StatelessWidget {
//   const TransactionsDetailSheet(
//       {super.key,
//       required this.title,
//       required this.transationDate,
//       required this.amountTransacted});

//   final String transationDate, title, amountTransacted;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           captionBold(text: title),
//           20.ph,
//           Row(
//             children: [
//               Container(
//                 width: 83.w,
//                 height: 83.w,
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).primaryColor.withOpacity(0.6),
//                     borderRadius: BorderRadius.circular(22.r)),
//                 child: const Icon(
//                   LineIcons.youtube,
//                   color: Colors.white,
//                   size: 40,
//                 ),
//               ),
//               10.pw,
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     paragraph(
//                         text:
//                             'UGX ${Helper.getTextDigit(amountTransacted.toString())}',
//                         fontSize: 25.sp),
//                     2.ph,
//                     paragraph(text: transationDate, fontSize: 22.sp),
//                   ],
//                 ),
//               )
//             ],
//           ),
//           20.ph,
//           const Divider(),
//           20.ph,
//           heading(text: 'Transaction Details'),
//           10.ph,
//           paragraph(
//               text: 'ID: 1234567890',
//               color: Theme.of(context)
//                   .textTheme
//                   .bodySmall!
//                   .color!
//                   .withOpacity(0.8),
//               fontSize: 18.6.sp),
//           10.ph,
//           paragraph(
//               text: 'Status: Completed',
//               color: Theme.of(context)
//                   .textTheme
//                   .bodySmall!
//                   .color!
//                   .withOpacity(0.8),
//               fontSize: 18.6.sp),
//           30.ph,
//           50.ph,
//         ],
//       ),
//     );
//   }
// }

// class PocketDetailSheet extends StatelessWidget {
//   const PocketDetailSheet(
//       {super.key,
//       required this.title,
//       required this.transationDate,
//       required this.amountTransacted,
//       required this.pocketDetail});

//   final String transationDate, title, amountTransacted;
//   final Map<String, dynamic> pocketDetail;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             children: [
//               captionBold(text: title),
//               10.pw,
//               const Icon(LineIcons.getPocket)
//             ],
//           ),
//           20.ph,
//           Row(
//             children: [
//               Container(
//                 width: 105.w,
//                 height: 105.w,
//                 decoration: BoxDecoration(
//                     color: getPocketColor(title),
//                     borderRadius: BorderRadius.circular(10.r)),
//                 child: Icon(
//                   pocketDetail['icon'],
//                   color: Colors.white,
//                   size: 40,
//                 ),
//               ),
//               15.pw,
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       decoration: BoxDecoration(
//                           color: Theme.of(context).canvasColor,
//                           border: Border.all(
//                               width: 0.6,
//                               color: Theme.of(context)
//                                   .textTheme
//                                   .bodyLarge!
//                                   .color!
//                                   .withOpacity(0.5)),
//                           borderRadius: BorderRadius.circular(4.r)),
//                       padding: EdgeInsets.all(4.w),
//                       child: heading(
//                           text:
//                               '${pocketDetail['amount']}',
//                           fontSize: 25.sp),
//                     ),
//                     // 4.ph,
//                     // paragraph(text: 'SPENT UGX 56,000 ', fontSize: 18.sp),
//                     // 4.ph,
//                     // paragraph(text: 'BAL UGX 56,000 ', fontSize: 22.sp),
                  
//                   ],
//                 ),
//               )
//             ],
//           ),
//           30.ph,
//           // Row(
//           //   children: [
//           //     Expanded(
//           //       flex: 3,
//           //       child: GestureDetector(
//           //         onTap: () {
//           //           ScreenOverlay.showAppSheet(
//           //             context,
//           //             sheet: const WalletTopUp(),
//           //           );
//           //         },
//           //         child: Container(
//           //             decoration: BoxDecoration(
//           //                 color: Theme.of(context).canvasColor,
//           //                 border: Border.all(
//           //                     width: 0.6,
//           //                     color: Theme.of(context)
//           //                         .textTheme
//           //                         .bodyLarge!
//           //                         .color!
//           //                         .withOpacity(0.5)),
//           //                 borderRadius: BorderRadius.circular(40.r)),
//           //             padding: EdgeInsets.all(15.w),
//           //             child: Row(
//           //               mainAxisAlignment: MainAxisAlignment.center,
//           //               children: [
//           //                 Icon(LucideIcons.arrowUp,
//           //                     size: 20.w,
//           //                     color: Theme.of(context).primaryColor),
//           //                 10.pw,
//           //                 label(
//           //                     text: 'Top Up',
//           //                     color: Theme.of(context).primaryColor)
//           //               ],
//           //             )),
//           //       ),
//           //     ),
//           //     10.pw,
//           //     Expanded(
//           //       flex: 3,
//           //       child: GestureDetector(
//           //         onTap: () {
//           //           ScreenOverlay.showAppSheet(
//           //             context,
//           //             sheet: const MakePayment(),
//           //           );
//           //         },
//           //         child: Container(
//           //             decoration: BoxDecoration(
//           //                 color: Theme.of(context).canvasColor,
//           //                 border: Border.all(
//           //                     width: 0.6,
//           //                     color: Theme.of(context)
//           //                         .textTheme
//           //                         .bodyLarge!
//           //                         .color!
//           //                         .withOpacity(0.5)),
//           //                 borderRadius: BorderRadius.circular(40.r)),
//           //             padding: EdgeInsets.all(15.w),
//           //             child: Row(
//           //               mainAxisAlignment: MainAxisAlignment.center,
//           //               children: [
//           //                 Icon(LucideIcons.coins,
//           //                     size: 20.w,
//           //                     color: Theme.of(context).primaryColor),
//           //                 10.pw,
//           //                 label(
//           //                     text: 'Spend',
//           //                     color: Theme.of(context).primaryColor)
//           //               ],
//           //             )),
//           //       ),
//           //     ),
//           //     10.pw,
//           //     Expanded(
//           //       flex: 1,
//           //       child: GestureDetector(
//           //         onTap: () {
//           //           // ScreenOverlay.showAppSheet(
//           //           //   context,
//           //           //   sheet: const MakePayment(),
//           //           // );
//           //         },
//           //         child: Container(
//           //             decoration: BoxDecoration(
//           //                 color: Theme.of(context).canvasColor,
//           //                 border: Border.all(
//           //                     width: 0.6,
//           //                     color: Theme.of(context)
//           //                         .textTheme
//           //                         .bodyLarge!
//           //                         .color!
//           //                         .withOpacity(0.5)),
//           //                 borderRadius: BorderRadius.circular(40.r)),
//           //             padding: EdgeInsets.all(18.w),
//           //             child: Icon(LucideIcons.settings,
//           //                 size: 20.w, color: Theme.of(context).primaryColor)),
//           //       ),
//           //     ),
//           //   ],
//           // ),
//           // 20.ph,
//           // const Divider(),
//           // 20.ph,
//           // heading(text: 'Transaction Details'),
//           // 20.ph,
//           // TransactionWidget(
//           //   title: 'YouTube Subscription',
//           //   amountTransacted: 36700,
//           //   transationDate: '28th June',
//           //   subscriptionType: 'Subscription',
//           // ),
//           // 10.ph,
//           // TransactionWidget(
//           //   title: 'Netflix Subscription',
//           //   amountTransacted: 21300,
//           //   transationDate: '30th June',
//           //   subscriptionType: 'Subscription',
//           // ),
//           80.ph,
//         ],
//       ),
//     );
//   }
// }

// class ServicePaymentSheet extends StatelessWidget {
//   const ServicePaymentSheet(
//       {super.key,
//       required this.title,
//       required this.transationDate,
//       required this.amountTransacted});

//   final String transationDate, title, amountTransacted;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           captionBold(text: 'Purchae $title'),
//           20.ph,
//           Row(
//             children: [
//               paragraph(text: 'Buying for 25670 270 3612', fontSize: 25.sp),
//               20.pw,
//               const Icon(LucideIcons.edit)
//             ],
//           ),
//           20.ph,
//           const Divider(),
//           20.ph,
//           heading(text: 'Transaction Details'),
//           15.ph,
//           Row(
//             children: [
//               Expanded(
//                 child: CupertinoSlidingSegmentedControl(
//                     thumbColor: Theme.of(context).primaryColor,
//                     padding: EdgeInsets.all(10.w),
//                     groupValue: 0,
//                     children: {
//                       0: label(
//                         text: 'Daily',
//                       ),
//                       1: label(
//                         text: 'Weekly',
//                       ),
//                       2: label(
//                         text: 'Montly',
//                       ),
//                       3: label(
//                         text: 'Gaga',
//                       ),
//                     },
//                     onValueChanged: (value) {}),
//               ),
//             ],
//           ),
//           10.ph,
//           GridView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3),
//             itemCount: pockets.length,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   ScreenOverlay.showAppSheet(
//                     context,
//                     sheet: SetUpPocket(pocketDetail: pockets[index]),
//                   );
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Theme.of(context).canvasColor,
//                       border: Border.all(
//                           width: 0.6,
//                           color: Theme.of(context)
//                               .textTheme
//                               .bodyLarge!
//                               .color!
//                               .withOpacity(0.5)),
//                       borderRadius: BorderRadius.circular(20.r)),
//                   margin: EdgeInsets.all(6.w),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(pockets[index]['icon'], size: 35.w),
//                       10.ph,
//                       paragraph(
//                           text: pockets[index]['name'],
//                           textAlign: TextAlign.center,
//                           fontSize: 19.sp)
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//           30.ph,
//           AppButton(buttonText: 'Confirm', action: () {}),
//           50.ph,
//         ],
//       ),
//     );
//   }
// }

// class ServicePaymentAirtimeSheet extends StatelessWidget {
//   const ServicePaymentAirtimeSheet(
//       {super.key,
//       required this.title,
//       required this.transationDate,
//       required this.amountTransacted});

//   final String transationDate, title, amountTransacted;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           captionBold(text: 'Purchae $title'),
//           20.ph,
//           Row(
//             children: [
//               paragraph(text: 'Buying for 25670 270 3612', fontSize: 25.sp),
//               20.pw,
//               const Icon(LucideIcons.edit)
//             ],
//           ),
//           20.ph,
//           const Divider(),
//           20.ph,
//           AppTextBox(
//               textController: TextEditingController(),
//               title: 'How much are you buying',
//               hint: 'Enter amount'),
//           30.ph,
//           AppButton(buttonText: 'Confirm', action: () {}),
//           50.ph,
//         ],
//       ),
//     );
//   }
// }

// class ServicePaymentNWSCSheet extends StatelessWidget {
//   const ServicePaymentNWSCSheet(
//       {super.key,
//       required this.title,
//       required this.transationDate,
//       required this.amountTransacted});

//   final String transationDate, title, amountTransacted;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           captionBold(text: 'Pay $title'),
//           20.ph,
//           Row(
//             children: [
//               paragraph(text: 'Meter Number 34670 270 3612', fontSize: 25.sp),
//               20.pw,
//               const Icon(LucideIcons.edit)
//             ],
//           ),
//           20.ph,
//           const Divider(),
//           20.ph,
//           AppTextBox(
//               textController: TextEditingController(),
//               title: 'How much are you paying',
//               hint: 'Enter amount'),
//           30.ph,
//           AppButton(buttonText: 'Confirm', action: () {}),
//           50.ph,
//         ],
//       ),
//     );
//   }
// }

// class ServicePaymentYakaSheet extends StatelessWidget {
//   const ServicePaymentYakaSheet(
//       {super.key,
//       required this.title,
//       required this.transationDate,
//       required this.amountTransacted});

//   final String transationDate, title, amountTransacted;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           captionBold(text: 'Purchase $title'),
//           20.ph,
//           Row(
//             children: [
//               paragraph(text: 'Meter Number 34670 270 3612', fontSize: 25.sp),
//               20.pw,
//               const Icon(LucideIcons.edit)
//             ],
//           ),
//           20.ph,
//           const Divider(),
//           20.ph,
//           AppTextBox(
//               textController: TextEditingController(),
//               title: 'How much are you paying',
//               hint: 'Enter amount'),
//           30.ph,
//           AppButton(buttonText: 'Confirm', action: () {}),
//           50.ph,
//         ],
//       ),
//     );
//   }
// }
