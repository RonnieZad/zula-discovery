import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zula/v1/models/location_model.dart';
import 'package:zula/v1/utils/extensions.dart';
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: heading(text: 'Menu', fontSize: 27.sp, color: Colors.white),
        ),
        20.ph,
        // Add your menu items here of dishes, put pictures, name, description and price
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: locationMenuActivity.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Image.network(
                  locationMenuActivity[index].locationMenuActivityPictureUrl,
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                ),
              ),
              title: heading(
                  text: locationMenuActivity[index].locationMenuActivityTitle,
                  fontSize: 21.sp,
                  color: Colors.white),
              subtitle: paragraph(
                  text: locationMenuActivity[index]
                      .locationMenuActivityDescription,
                  color: Colors.white54,
                  fontSize: 19.sp),
              trailing: heading(
                  text:
                      'UGX${locationMenuActivity[index].locationMenuActivityPrice}',
                  fontSize: 20.sp,
                  color: Colors.white),
            );
          },
        )
      ],
    );
  }
}
