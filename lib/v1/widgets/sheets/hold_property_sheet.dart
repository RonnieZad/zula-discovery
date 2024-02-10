// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:nyumba/v1/controllers/order_controller.dart';
// import 'package:nyumba/v1/utils/screen_overlay.dart';
// import 'package:nyumba/v1/utils/utils.dart';
// import 'package:nyumba/v1/widgets/sheets/sheets.dart';
// import 'package:nyumba/v1/widgets/widgets.dart';
// import 'package:octo_image/octo_image.dart';

// class HoldPropertySheet extends StatelessWidget {
//   const HoldPropertySheet({
//     super.key,
//     required this.propertyId,
//     required this.propertyToVisit,
//   });
//   final String propertyToVisit;
//   final String propertyId;

//   @override
//   Widget build(BuildContext context) {
//     final OrderController orderController = Get.find();
//     return Padding(
//       padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           captionBold(text: 'Property Hold'),
//           10.ph,
//           heading(text: 'Hold Property until you find rent money'),
//           20.ph,
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10.r),
//             child: OctoImage(
//               image: CachedNetworkImageProvider(
//                 propertyToVisit,
//               ),
//               placeholderBuilder:
//                   OctoPlaceholder.blurHash('LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
//               errorBuilder: OctoError.icon(color: Colors.red),
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: 250.h,
//             ),
//           ),
//           10.ph,
//           paragraphSmallItalic(
//               text:
//                   '*Image of the house to hold, Below are the details of your service order'),
//           30.ph,
//           heading(text: 'Benefits'),
//           20.ph,
//           const FeatureBenefit(
//             benefitText: 'Hold for 12 hours',
//           ),
//           const FeatureBenefit(
//             benefitText: 'No one else can hold it',
//           ),
//           const FeatureBenefit(
//             benefitText: 'Property is exclusively yours',
//           ),
//           20.ph,
//           paragraph(
//               text:
//                   'Disclaimer: You will be charged a fee of UGX 50,000 to hold this property for 12 hours and property will be released after the time has expired',
//               fontSize: 16.sp),
//           20.ph,
//           Row(
//             children: [
//               subtitle(text: 'UGX 50,000'),
//               10.pw,
//               heading(text: 'per property'),
//             ],
//           ),
//           30.ph,
//           AppButton(
//               action: () {
//                 ScreenOverlay.showAppSheet(
//                   context,
//                   sheet: CouponModal(
//                     amountToPay: 50000,
//                     paymentReason: 'property hold',
//                     propertyId: propertyId,
//                     orderController: orderController,
//                   ),
//                 );
//               },
//               buttonText: 'PAY NOW'),
//           15.ph,
//         ],
//       ),
//     );
//   }
// }
