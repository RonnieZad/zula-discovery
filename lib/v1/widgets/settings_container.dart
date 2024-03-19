import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
// import 'package:zula/v1/utils/utils.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer(
      {super.key,
      required this.description,
      required this.title,
      this.trailingWidget});

  final String title;
  final Widget? trailingWidget;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Theme.of(context).canvasColor),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            heading(text: 'Display'),
            10.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                heading(text: title, fontSize: 19.sp),
                trailingWidget == null
                    ? const SizedBox.shrink()
                    : trailingWidget!
              ],
            ),
            10.ph,
            paragraph(
                color: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .color!
                    .withOpacity(0.8),
                text: description,
                fontSize: 18.6.sp)
          ]),
    );
  }
}

class SettingsWidget extends StatelessWidget {
  const SettingsWidget(
      {super.key, this.widget, required this.title, this.trailingWidget});

  final String title;
  final Widget? trailingWidget;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),

      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20.r)
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           title.isEmpty ?const SizedBox.shrink(): caption(text: title, fontSize: 30.sp, color: Colors.white60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                trailingWidget == null
                    ? const SizedBox.shrink()
                    : heading(text: 'Dark Mode', fontSize: 19.sp),
                trailingWidget == null
                    ? const SizedBox.shrink()
                    : trailingWidget!
              ],
            ),
            widget == null ? const SizedBox.shrink() : widget!
          ]),
    );
  }
}
