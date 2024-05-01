import 'package:intl/intl.dart';

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
}
