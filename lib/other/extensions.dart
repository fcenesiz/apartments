import 'package:apartments/other/constants.dart';

extension StringExtension on String {
  String get initials {
    List<String> words = this.trim().split(' ');
    String initials = '';

    for (var word in words) {
      if (word.isNotEmpty) {
        initials += word[0].toUpperCase();
      }
    }

    return initials;
  }
}

extension IntExtension on int {
  String get convertMonthToText {
    return months[this];
  }
}
