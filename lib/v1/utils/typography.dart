//  NYUMBA MOBILE APP
//
//  Created by Ronald Zad Muhanguzi .
//  2022, Zofi Cash App. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:yombeka/v1/constants/constants.dart';


Widget title(
        {String text = '',
        Color? color,
        TextAlign textAlign = TextAlign.start,
        int delay = 0,
        fontFamily = 'Poppins',
        double fontSize = 40}) =>
    Text(text,
            style: TextStyle(
                fontSize: fontSize.sp,
                color: color,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamily),
            textAlign: textAlign);
Widget subtitle(
        {String text = '',
        Color? color,
        TextAlign textAlign = TextAlign.start,
        int delay = 0}) =>
   Text(text,
            style: TextStyle(
                fontSize: 28.sp,
                color: color,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'),
            textAlign: textAlign);
Widget subtitleBold(
        {String text = '',
        // Color color = secondaryColorWhite,
        TextAlign textAlign = TextAlign.start,
        int delay = 0}) =>
   Text(text,
            style: TextStyle(
                fontSize: 30.sp,
                // color: color,
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins'),
            textAlign: textAlign);
Widget headingBig(
        {String text = '',
        Color? color,
        TextAlign textAlign = TextAlign.start,
        int delay = 0}) =>
     Text(text,
            style: TextStyle(
                fontSize: 22.sp,
                color: color,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'),
            textAlign: textAlign);
Widget heading({
  String text = '',
  Color? color,
  textAlign = TextAlign.start,
  int delay = 0,
  double fontSize = 20,
}) =>
     Text(text,
            style: TextStyle(
                fontSize: fontSize.sp,
                color: color,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'),
            textAlign: textAlign);
Widget subHeading(
        {String text = '',
        Color? color,
        int delay = 0,
        double fontSize = 16}) =>
    Text(text,
            style: TextStyle(
                fontSize: fontSize.sp,
                color: color,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins'));
Widget paragraph(
        {String text = '',
        Color? color,
        double fontSize = 18,
        TextAlign textAlign = TextAlign.start,
        TextOverflow? overflow, 
        
        int delay = 0}) =>
   Text(text,
            style: TextStyle(
                fontSize: fontSize.sp,
                color: color,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins'),
                overflow: overflow,
            textAlign: textAlign);
Widget paragraphSmall(
        {String text = '',
        Color? color,
        TextAlign textAlign = TextAlign.start,
        int delay = 0}) =>
   Text(text,
            style: TextStyle(
                fontSize: 16.sp,
                color: color,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins'),
            textAlign: textAlign);
Widget paragraphSmallItalic(
        {String text = '',
        Color? color,
        TextAlign textAlign = TextAlign.start,
        int delay = 0}) =>
   Text(text,
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 15.5.sp,
                color: color,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins'),
            textAlign: textAlign);
Widget paragraphBold(
        {String text = '',
        Color? color,
        int delay = 0,
        double fontSize = 22,
        textAlign = TextAlign.start}) =>
     Text(text,
            style: TextStyle(
                fontSize: fontSize.sp,
                color: color,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins'),
            textAlign: textAlign);
Widget label({String text = '', Color? color, int delay = 0}) =>  Text(text,
        style: TextStyle(
            fontSize: 17.sp,
            color: color,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins'));
Widget buttonLabel(
        {String text = '',
        // Color color = primaryColorWhite,
        double fontSize = 18,
        int delay = 0}) =>
    Text(text,
            style: TextStyle(
                fontSize: fontSize.sp,
                // color: color,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'));
Widget buttonLabelSmallBold(
        {String text = '',
        Color? color,
        int delay = 0,
        double fontSize = 16}) =>
  Text(text,
            style: TextStyle(
                fontSize: fontSize.sp,
                color: color,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins'));
Widget buttonLabelBold(
        {String text = '', Color? color = Colors.white, int delay = 0}) =>
  Text(text,
            style: TextStyle(
                fontSize: 20.sp,
                color: color,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins'));
Widget caption(
        {String text = '',
        double fontSize = 18,
        Color? color,
        TextAlign textAlign = TextAlign.start,
        int delay = 0}) =>
   Text(text,
            style: TextStyle(
                fontSize: fontSize.sp,
                color: color,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'),
            textAlign: textAlign);
Widget captionBold(
        {String text = '',
        Color? color,
        double fontSize = 29,
        TextAlign textAlign = TextAlign.start,
        int delay = 0}) =>
    Text(text,
            style: TextStyle(
                fontSize: fontSize.sp,
                color: color,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins'),
            textAlign: textAlign);
