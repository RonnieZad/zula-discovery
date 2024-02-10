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

// class RequestTourSheet extends StatefulWidget {
//   const RequestTourSheet({
//     super.key,
//     required this.propertyToVisit,
//     required this.propertyId,
//   });
//   final String propertyToVisit;
//   final String propertyId;

//   @override
//   State<RequestTourSheet> createState() => _RequestTourSheetState();
// }

// class _RequestTourSheetState extends State<RequestTourSheet> {
//   @override
//   Widget build(BuildContext context) {
//     final OrderController orderController = Get.find();
//     return Padding(
//       padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           captionBold(text: 'Virtual Tour'),
//           10.ph,
//           heading(
//               text: 'Subscribe for immersive virtual tours valid for 1 month'),
//           20.ph,
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10.r),
//             child: OctoImage(
//               image: CachedNetworkImageProvider(
//                 widget.propertyToVisit,
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
//                   '*Image of the house to tour, Below are the details of your service order'),
//           30.ph,
//           heading(text: 'Benefits'),
//           20.ph,
//           const FeatureBenefit(
//             benefitText: 'Virtual Tour on all Properties',
//           ),
//           const FeatureBenefit(
//             benefitText: 'No Fake Con men',
//           ),
//           const FeatureBenefit(
//             benefitText: 'Get to see property location',
//           ),
//           30.ph,
//           Row(
//             children: [
//               subtitle(text: 'UGX 30,000'),
//               10.pw,
//               heading(text: 'per month'),
//             ],
//           ),
//           40.ph,
//           AppButton(
//               action: () {
//                 ScreenOverlay.showAppSheet(
//                   context,
//                   sheet: CouponModal(
//                     amountToPay: 30000,
//                     paymentReason: 'property tour access',
//                     propertyId: widget.propertyId,
//                     orderController: orderController,
//                   ),
//                 );
//               },
//               buttonText: 'ADD SUBSCRIPTION'),
//           15.ph,
//         ],
//       ),
//     );
//   }
// }
