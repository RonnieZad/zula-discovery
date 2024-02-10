// import 'dart:developer';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:lucide_icons/lucide_icons.dart';
// import 'package:nyumba/v1/controllers/order_controller.dart';
// import 'package:nyumba/v1/models/models.dart';
// import 'package:nyumba/v1/models/subscription_ably_response.dart';
// import 'package:nyumba/v1/screens/success_screen.dart';
// import 'package:nyumba/v1/services/services.dart';
// import 'package:nyumba/v1/services/socket_service.dart';
// import 'package:nyumba/v1/utils/utils.dart';
// import 'package:nyumba/v1/widgets/widgets.dart';
// import 'package:octo_image/octo_image.dart';

// class ConfirmLandlordPayout extends StatefulWidget {
//   const ConfirmLandlordPayout({
//     super.key,
//     required this.propertyId,
//     required this.amountToPay,
//     required this.applicationId,
//     this.isFromEnyumbaWallet = true,
//   });
//   final bool? isFromEnyumbaWallet;
//   final double amountToPay;
//   final String applicationId;
//   final String propertyId;

//   @override
//   State<ConfirmLandlordPayout> createState() => _ConfirmLandlordPayoutState();
// }

// class _ConfirmLandlordPayoutState extends State<ConfirmLandlordPayout> {
//   TextEditingController landlordPhoneNumberController = TextEditingController();

//   late Future _propertyFuture;

//   @override
//   void initState() {
//     _propertyFuture = ApiService.getRequest(
//         endPoint: '/${widget.propertyId}', service: Services.property);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: _propertyFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//                 child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   width: 90.w,
//                   height: 90.w,
//                   child: Image.asset(
//                       (GetStorage().read('is_light_theme') ?? true)
//                           ? 'assets/images/loading_gif_blue.gif'
//                           : 'assets/images/loading_gif_orange.gif'),
//                 ),
//                 15.ph,
//                 paragraph(
//                   text: 'Loading, sit tight and relax!',
//                 )
//               ],
//             ));
//           } else if (snapshot.data == null) {
//             return const SizedBox.shrink();
//           } else if (snapshot.hasError) {
//             return const SizedBox.shrink();
//           }

//           return Padding(
//             padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 captionBold(text: 'Confirm Pay Out'),
//                 20.ph,
//                 paragraph(
//                     text: widget.isFromEnyumbaWallet == true
//                         ? 'Paying from your Enyumba Wallet'
//                         : 'Paying from your Mobile Wallet'),
//                 25.ph,
//                 heading(text: 'Landlord Details'),
//                 20.ph,
//                 Row(
//                   children: <Widget>[
//                     SizedBox(
//                       width: 100.w,
//                       height: 100.w,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(100.r),
//                         child: OctoImage(
//                           image: CachedNetworkImageProvider(
//                               snapshot.data['payload']['data']
//                                   ['property_management']['profilePhoto']),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     10.pw,
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         heading(
//                             text: snapshot.data['payload']['data']
//                                 ['property_management']['name']),
//                         5.ph,
//                         paragraph(
//                             text: snapshot.data['payload']['data']
//                                 ['property_management']['phone']),
//                         5.ph,
//                         paragraph(
//                             text: snapshot.data['payload']['data']
//                                 ['property_management']['emailAddress']),
//                       ],
//                     )
//                   ],
//                 ),
//                 50.ph,
//                 AppTextBox(
//                   isphone: true,
//                   textController: landlordPhoneNumberController,
//                   title: 'Enter Landlord Phone Number',
//                   hint: 'Enter here',
//                   onChanged: (value) {
//                     setState(() {});
//                   },
//                 ),
//                 15.ph,
//                 '256${landlordPhoneNumberController.text}' !=
//                         snapshot.data['payload']['data']['property_management']
//                             ['phone']
//                     ? const SizedBox.shrink()
//                     : Row(
//                         children: [
                       
//                         ],
//                       ),
//                 20.ph,
//               ],
//             ),
//           );
//         });
//   }
// }
