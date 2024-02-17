
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octo_image/octo_image.dart';

class BackgrounBlurView extends StatelessWidget {
  final String imageUrl;
  const BackgrounBlurView({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: 500.h,
        width: double.infinity,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: Colors.black.withOpacity(0.6),
            height: 550.h,
            width: double.infinity,
          ))
    ]);
  }
}

class OctoBlurHashFix {
  static OctoPlaceholderBuilder placeHolder(String hash, {BoxFit? fit}) {
    return (context) => SizedBox.expand(
          child: Image(
            image: BlurHashImage(hash),
            fit: fit ?? BoxFit.cover,
          ),
        );
  }
}
