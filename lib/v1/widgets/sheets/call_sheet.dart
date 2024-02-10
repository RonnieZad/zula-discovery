// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:nyumba/v1/controllers/order_controller.dart';
// import 'package:nyumba/v1/models/models.dart';
// import 'package:nyumba/v1/services/api_service.dart';
// import 'package:nyumba/v1/utils/input_formatter.dart';
// import 'package:nyumba/v1/utils/screen_overlay.dart';
// import 'package:nyumba/v1/utils/utils.dart';
// import 'package:nyumba/v1/widgets/widgets.dart';

// class CallSheet extends StatelessWidget {
//   const CallSheet({super.key, required this.propertyId});

//   final String propertyId;

//   @override
//   Widget build(BuildContext context) {
//     final OrderController orderController = Get.put(OrderController());
//     return Padding(
//       padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
//       child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             captionBold(text: 'Get Landlord Contacts'),
//             20.ph,
//             heading(text: 'Benefits'),
//             20.ph,
//             const FeatureBenefit(
//               benefitText: 'No Fake Middle Men',
//             ),
//             const FeatureBenefit(
//               benefitText: 'Virtual Tours for all properties',
//             ),
//             const FeatureBenefit(
//               benefitText: 'Pre-Qualify for Rent Financing',
//             ),
//             const FeatureBenefit(
//               benefitText: 'Get to see property location',
//             ),
//             20.ph,
//             paragraph(
//                 fontSize: 20.sp,
//                 text:
//                     'Get exclusive access to all phone numbers of landlords on Enyumba'),
//             30.ph,
//             Row(
//               children: [
//                 subtitle(text: 'UGX 120,000'),
//                 10.pw,
//                 heading(text: 'per month'),
//               ],
//             ),
//             40.ph,
//             AppButton(
//                 action: () {
//                   ScreenOverlay.showAppSheet(
//                     context,
//                     sheet: CouponModal(
//                       amountToPay: 120000,
//                       paymentReason: 'phone number access',
//                       propertyId: propertyId,
//                       orderController: orderController,
//                     ),
//                   );
//                 },
//                 buttonText: 'ADD SUBSCRIPTION'),
//             15.ph,
//           ]),
//     );
//   }
// }

// class CouponModal extends StatefulWidget {
//   const CouponModal({
//     super.key,
//     required this.propertyId,
//     required this.paymentReason,
//     required this.orderController,
//     required this.amountToPay,
//   });

//   final String propertyId;
//   final String paymentReason;
//   final OrderController orderController;

//   final double amountToPay;

//   @override
//   State<CouponModal> createState() => _CouponModalState();
// }

// class _CouponModalState extends State<CouponModal> {
//   bool isCouponVerified = false;
//   double discountAfterVoucher = 0;
//   final TextEditingController couponController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           captionBold(text: 'Have a coupon code?'),
//           20.ph,
//           heading(text: 'Enter your coupon code to get discount'),
//           20.ph,
//           Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8.r),
//                 border: Border.all(
//                     width: 0.7,
//                     color: Theme.of(context).primaryColor.withOpacity(0.7))),
//             child: TextFormField(
//               style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 28.sp,
//                   fontWeight: FontWeight.w700),
//               textCapitalization: TextCapitalization.characters,
//               maxLength: 6,
//               onChanged: (value) {
//                 setState(() {
//                   couponController.text = value;
//                 });

//                 if (couponController.text.length == 6) {
//                   ApiService.postRequest(
//                       endPoint: '/verify_voucher_code',
//                       service: Services.payment,
//                       body: {
//                         'user_id': GetStorage().read('user_uid'),
//                         'voucher_code': couponController.text,
//                         'amount_to_pay': widget.amountToPay,
//                       }).then((response) {
//                     log(response.toString());
//                     if (response['payload']['status'] == 409) {
//                       ScreenOverlay.showToast('Voucher verification failed',
//                           response['payload']['error'],
//                           isError: true);
//                     } else {
//                       setState(() {
//                         isCouponVerified = true;
//                         discountAfterVoucher = double.parse(
//                             response['payload']['voucher_amount'].toString());
//                       });
//                     }
//                   });
//                 }
//               },
//               decoration: InputDecoration(
//                   suffixText: '${couponController.text.length}/6',
//                   counterText: '',
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 18.h, horizontal: 15.w),
//                   border: InputBorder.none,
//                   hintText: 'Enter coupon code',
//                   hintStyle: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 22.sp,
//                       fontWeight: FontWeight.w400,
//                       color: Theme.of(context)
//                           .textTheme
//                           .bodyLarge!
//                           .color!
//                           .withOpacity(0.5))),
//             ),
//           ),
//           20.ph,
//           AppButton(
//               color: isCouponVerified
//                   ? Theme.of(context).primaryColor
//                   : Theme.of(context).primaryColor.withOpacity(0.7),
//               buttonText: 'APPLY CODE',
//               action: () {
//                 if (isCouponVerified) {
//                   MakePaymentModel paymentModel = MakePaymentModel(
//                       amoutToPay: discountAfterVoucher,
//                       currency: 'UGX',
//                       makePaymentMetadataModel: MakePaymentMetadataModel(
//                           userId: GetStorage().read('user_uid'),
//                           propertyId: widget.propertyId,
//                           reason: widget.paymentReason,
//                           voucherCode: couponController.text));

//                   widget.orderController
//                       .makePayment(context, paymentModel: paymentModel);
//                 } else {
//                   ScreenOverlay.showToast(
//                       'Invalid Coupon Code', 'Please enter a valid coupon code',
//                       isError: true);
//                 }
//               }),
//           10.ph,
//           Center(
//             child: TextButton(
//                 onPressed: () {
//                   MakePaymentModel paymentModel = MakePaymentModel(
//                     amoutToPay: widget.amountToPay,
//                     currency: 'UGX',
//                     makePaymentMetadataModel: MakePaymentMetadataModel(
//                       userId: GetStorage().read('user_uid'),
//                       propertyId: widget.propertyId,
//                       reason: widget.paymentReason,
//                     ),
//                   );

//                   widget.orderController
//                       .makePayment(context, paymentModel: paymentModel);
//                 },
//                 child: buttonLabel(
//                     text:
//                         'Don\'t have coupon? Pay UGX ${Helper.getTextDigit(widget.amountToPay.toString())}',
//                     color: Theme.of(context).primaryColor)),
//           ),
//           10.ph,
//         ],
//       ),
//     );
//   }
// }

// class FeatureBenefit extends StatelessWidget {
//   const FeatureBenefit({super.key, required this.benefitText});
//   final String benefitText;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.h),
//       child: Row(
//         children: [
//           Icon(
//             Icons.check_circle_outline,
//             color: Theme.of(context).primaryColor.withOpacity(0.9),
//             size: 22.w,
//           ),
//           10.pw,
//           buttonLabel(
//               text: benefitText,
//               fontSize: 19.sp,
//               color: Theme.of(context).textTheme.bodyLarge!.color!)
//         ],
//       ),
//     );
//   }
// }
