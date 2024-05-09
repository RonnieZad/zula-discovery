import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octo_image/octo_image.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/models/location_model.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';
import 'package:zula/v1/widgets/image_blur_backdrop.dart';

class PlaceReviewSheet extends StatelessWidget {
  const PlaceReviewSheet({
    super.key,
    required this.locationReviews,
  });

  final List<LocationReview> locationReviews;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(
              text: 'Reviews and Ratings',
              fontSize: 46.sp,
              color: brandPrimaryColor,
              fontFamily: 'Broncks',
              textAlign: TextAlign.center),
          30.ph,
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: locationReviews.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: ClipOval(
                  child: OctoImage(
                    width: 60.0,
                    height: 60.0,
                    placeholderBuilder: OctoBlurHashFix.placeHolder(
                        'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                    errorBuilder: OctoError.icon(color: Colors.red),
                    image: CachedNetworkImageProvider(
                      locationReviews[index].locationReviewContactPreview,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                title: label(
                  text: locationReviews[index].locationReviewContactName,
                ),
                subtitle: paragraph(
                    text: locationReviews[index].locationReviewContactReview,
                    fontSize: 18.sp),
                // trailing: paragraph(
                //     text: locationReviews[index].locationReviewDate,
                //     fontSize: 19.sp,
                //     color: Colors.white),
              );
            },
          ),
          30.ph,
        ],
      ),
    );
  }
}
