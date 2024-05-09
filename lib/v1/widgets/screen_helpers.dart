import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';

class NoContentWidget extends StatelessWidget {
  const NoContentWidget({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.imageOff,
            size: 120.w,
          ),
          15.ph,
          paragraph(text: label, textAlign: TextAlign.center),
        ]
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .then(delay: 440.ms)
            .slideY(
                begin: 0.1,
                end: 0,
                delay: 600.ms,
                duration: 3800.ms,
                curve: Curves.elasticInOut),
      ),
    );
  }
}
