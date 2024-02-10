// //  ENYUMBA MOBILE APP
// //
// //  Created by Ronald Zad Muhanguzi .
// //  2023, Enyumba App. All rights reserved.

// // ignore: must_be_immutable
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';


// class AppTextFieldBox extends StatefulWidget {
//   ///#####  App Text Field Box
//   ///This is a custom [TextFormField] with a brand theme, that inputs user keyboard text
//   ///it optional arguments like [maxLength] : `int`, [obsureText]: `bool`, [isPhoneNumber] : `bool`
//   ///[validator] : `Function(String?)?` which returns a string.
//   ///The [AppTextFieldBox] also takes [label] : `String`, [hint] : `String`, [textInputType] : `TextInputType`
//   ///and a [textEditingController] : `TextEditingController`
//   AppTextFieldBox({
//     Key? key,
//     this.maxLength,
//     this.obscureText = false,
//     this.isPhoneNumber = false,
//     this.validator,
//     this.padding,
//     required this.label,
//     required this.hint,
//     required this.textInputType,
//     required this.textEditingController,
//     this.prefixText,
//   }) : super(key: key);

//   final Function(String?)? validator;
//   final String hint;
//   bool isPhoneNumber;
//   final String label;
//   final int? maxLength;
//   bool obscureText;
//   final String? prefixText;
//   final TextEditingController textEditingController;
//   final TextInputType textInputType;
//   final EdgeInsetsGeometry? padding;

//   @override
//   State<AppTextFieldBox> createState() => _AppTextFieldBoxState();
// }

// class _AppTextFieldBoxState extends State<AppTextFieldBox> {
//   @override
//   Widget build(BuildContext context) {

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         if (widget.isPhoneNumber) ...[
//           Padding(
//             padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 20.w),
//             child: Text(widget.label, style: textBoxStyle),
//           ),
//           15.ph,
//           Row(
//             children: <Widget>[
//               GestureDetector(
//                   onTap: () {
//                     getStartedController.showCountryList(true);
//                   },
//                   child: Container(
//                     height: 55.h,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         width: 0.4,
//                         color: Theme.of(context).primaryColor.withOpacity(0.8),
//                       ),
//                       color: Theme.of(context).canvasColor,
//                       borderRadius: BorderRadius.circular(50.r),
//                     ),
//                     child: Padding(
//                       // padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 20.w),
//                       padding: EdgeInsets.all(8.w),
//                       child: Row(children: <Widget>[
//                         10.pw,
//                         Image.asset(
//                           countryList[GetStorage().read('country_index') ?? 0]
//                               ['image'],
//                           width: 40.w,
//                           height: 40.w,
//                           fit: BoxFit.fitHeight,
//                         ),
//                         subHeading(
//                             text: countryList[
//                                     GetStorage().read('country_index') ?? 0]
//                                 ['code'],
//                             color: Colors.black),
//                         const Icon(Icons.keyboard_arrow_down_sharp,
//                             color: Colors.black)
//                       ]),
//                     ),
//                   )),
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   width: double.infinity,
//                   margin: EdgeInsets.only(left: 20.w),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       width: 0.4,
//                       color: Theme.of(context).primaryColor.withOpacity(0.8),
//                     ),
//                     color: Theme.of(context).canvasColor,
//                     borderRadius: BorderRadius.circular(50.r),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(.2.w),
//                     child: TextFormField(
//                       obscureText: widget.obscureText,
//                       controller: widget.textEditingController,
//                       maxLength: widget.maxLength,
//                       validator: (value) {
//                         return widget.validator!(value);
//                       },
//                       onChanged: (value) {
//                         setState(() {});
//                       },
//                       style: TextStyle(
//                           fontSize: 17.sp,
//                           color: Colors.black,
//                           fontFamily: 'Poppins'),
//                       keyboardType: widget.textInputType,
//                       decoration: InputDecoration(
//                           hintStyle: textBoxHintStyle,
//                           suffixText: widget.maxLength == null
//                               ? null
//                               : '${widget.textEditingController.value.text.length}/${widget.maxLength}',
//                           counterText: '',
//                           suffix: widget.label.contains('password')
//                               ? IconButton(
//                                   icon: Icon(
//                                     widget.obscureText
//                                         ? CupertinoIcons.eye
//                                         : CupertinoIcons.eye_slash,
//                                     size: 24,
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       widget.obscureText = !widget.obscureText;
//                                     });
//                                   },
//                                 )
//                               : null,
//                           errorStyle: TextStyle(
//                               fontSize: 13.sp,
//                               color: Colors.blue[100],
//                               fontFamily: 'Poppins'),
//                           prefixText: widget.prefixText,
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 15.w, vertical: 15.h),
//                           hintText: widget.hint,
//                           border: InputBorder.none),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ] else ...[
//           Padding(
//             padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 20.w),
//             child: Text(widget.label, style: textBoxStyle),
//           ),
//           15.ph,
//           Container(
//             margin: widget.padding ?? EdgeInsets.symmetric(horizontal: 20.w),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 width: 0.4,
//                 color: Theme.of(context).primaryColor.withOpacity(0.8),
//               ),
//               color: Theme.of(context).canvasColor,
//               borderRadius: BorderRadius.circular(50.r),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(2.7.w),
//               child: TextFormField(
//                 obscureText: widget.obscureText,
//                 controller: widget.textEditingController,
//                 maxLength: widget.maxLength,
//                 validator: (value) {
//                   return widget.validator!(value);
//                 },
//                 onChanged: (value) {
//                   setState(() {});
//                 },
//                 onTapOutside: (d) {
                  
//                   FocusScopeNode currentFocus = FocusScope.of(context);
//                   if (!currentFocus.hasPrimaryFocus &&
//                       currentFocus.focusedChild != null) {
//                     currentFocus.focusedChild!.unfocus();
//                   }
//                 },
//                 style: TextStyle(
//                     fontSize: 17.sp,
//                     color: Colors.black,
//                     fontFamily: 'Poppins'),
//                 keyboardType: widget.textInputType,
//                 decoration: InputDecoration(
//                     hintStyle: textBoxHintStyle,
//                     suffixText: widget.maxLength == null
//                         ? null
//                         : '${widget.textEditingController.value.text.length}/${widget.maxLength}',
//                     counterText: '',
//                     suffixIcon: widget.label.contains('password')
//                         ? IconButton(
//                             padding: EdgeInsets.zero,
//                             icon: Icon(
//                               widget.obscureText
//                                   ? CupertinoIcons.eye
//                                   : CupertinoIcons.eye_slash,
//                               color: Colors.blue[100],
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 widget.obscureText = !widget.obscureText;
//                               });
//                             },
//                           )
//                         : null,
//                     errorStyle: TextStyle(
//                         fontSize: 13.sp,
//                         color: Colors.blue[100],
//                         fontFamily: 'Poppins'),
//                     prefixText: widget.prefixText,
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//                     hintText: widget.hint,
//                     border: InputBorder.none),
//               ),
//             ),
//           ),
//         ]
//       ],
//     );
//   }
// }
