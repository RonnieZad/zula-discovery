//  ENYUMBA MOBILE APP
//
//  Created by Ronald Zad Muhanguzi .
//  2023, Enyumba App. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ImagePath on String {
  String get toSvg => 'assets/files/$this.svg';
  String get toPng => 'assets/images/$this.png';
  String get toGif => 'assets/images/$this.gif';
  String get toJpeg => 'assets/images/$this.jpeg';
  String get toJpg => 'assets/images/$this.jpg';
  String get toMp4 => 'assets/files/$this.mp4';
  String get toJson => 'assets/images/$this.json';
}

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(height: toDouble().h);
  SizedBox get pw => SizedBox(width: toDouble().w);
}
