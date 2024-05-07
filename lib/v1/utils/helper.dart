import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class Helper {
  Helper._();

  static String? getTextDigit(String? textToFormat, {decimalPlaces = 0}) {
    if (textToFormat != null && textToFormat.isNotEmpty) {
      textToFormat = textToFormat.contains('.') &&
              textToFormat.split('.')[1] == '0'
          ? NumberFormat.decimalPattern()
              .format(int.parse(textToFormat.split('.')[0]).round())
          : textToFormat = textToFormat.contains('.')
              ? '${NumberFormat.decimalPattern().format(int.parse(textToFormat.split('.')[0]).round())}.${textToFormat.split('.')[1]}'
              : textToFormat != ''
                  ? NumberFormat.currency(name: '', decimalDigits: 0)
                      .format(int.parse(textToFormat))
                  : '0';
    } else {
      return '0';
    }

    return textToFormat;
  }

    static String getDate(DateTime textToFormat) {
    return  DateFormat('MMM dd, yyyy').format(textToFormat);
  }

  static getNotificationIcon(String type) {
    switch (type.toLowerCase()) {
      case 'app_update':
        return LineIcons.download;

      case 'pending':
        return LineIcons.download;

      case 'failed':
        return LineIcons.download;

      case 'processed_with_errors':
        return LineIcons.download;

      case 'matured':
        return LineIcons.download;

      case 'processed':
        return LineIcons.download;

      default:
        return LineIcons.download;
    }
  }
}
