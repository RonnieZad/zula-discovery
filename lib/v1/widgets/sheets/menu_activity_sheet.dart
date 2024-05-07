import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/models/location_model.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/helper.dart';
import 'package:zula/v1/utils/typography.dart';

class MenuActivitySheet extends StatelessWidget {
  const MenuActivitySheet({
    super.key,
    required this.locationMenuActivity,
  });

  final List<LocationMenuActivity> locationMenuActivity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: title(
              text: 'Menu / Activities',
              fontSize: 46.sp,
              color: brandPrimaryColor,
              fontFamily: 'Broncks',
              textAlign: TextAlign.center),
        ),
        20.ph,
        // Add your menu items here of dishes, put pictures, name, description and price
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: locationMenuActivity.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                border: Border.all(color: brandPrimaryColor.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: Image.network(
                      locationMenuActivity[index]
                          .locationMenuActivityPictureUrl,
                      width: double.infinity,
                      height: 250.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  25.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      paragraphBold(
                          text: locationMenuActivity[index]
                              .locationMenuActivityTitle,
                          fontSize: 24.sp,
                          ),
                      paragraphBold(
                          text:
                              'UGX${Helper.getTextDigit(locationMenuActivity[index].locationMenuActivityPrice.toString())}',
                          fontSize: 20.sp,
                          ),
                    ],
                  ),
                  10.ph,
                  paragraph(
                      text: locationMenuActivity[index]
                          .locationMenuActivityDescription,
                      
                      fontSize: 18.sp),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
