import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octo_image/octo_image.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/models/location_model.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/helper.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/image_blur_backdrop.dart';

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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: title(
              text: 'Menu / Activities',
              fontSize: 46.sp,
              color: brandPrimaryColor,
              
              textAlign: TextAlign.center),
        ),
        20.ph,
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
                      child: OctoImage(
                        width: double.infinity,
                        height: 250.h,
                        placeholderBuilder: OctoBlurHashFix.placeHolder(
                            'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                        errorBuilder: OctoError.icon(color: Colors.red),
                        image: CachedNetworkImageProvider(
                          locationMenuActivity[index]
                              .locationMenuActivityPictureUrl,
                        ),
                        fit: BoxFit.cover,
                      )),
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
