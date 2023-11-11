sealed class DateTimeAdapter {
  static DateTime stringToDateTime(String dateString) {
    /*20231109163440[-3:GMT]*/
    var year = int.parse(dateString.substring(00, 04));
    var month = int.parse(dateString.substring(04, 06));
    var day = int.parse(dateString.substring(06, 08));

    var hour = int.parse(dateString.substring(08, 10));
    var minute = int.parse(dateString.substring(10, 12));
    var second = int.parse(dateString.substring(12, 14));

    return DateTime.utc(year, month, day, hour, minute, second);
  }

  static DateTime stringDateTimeInTimeZoneLocal(String dateString) {
    /*20231109163440[-3:GMT]*/
    var date = stringToDateTime(dateString);
    var timeZone = _getTimeZone(dateString);
    var timeZoneLocal = DateTime.now().timeZoneOffset.inHours;

    Duration diferenceTimeZone = Duration(hours: timeZone);

    DateTime zero;
    DateTime dateTimeLocal;

    if (timeZone < 0) {
      zero = date.add(diferenceTimeZone.abs());
    } else {
      zero = date.subtract(diferenceTimeZone.abs());
    }

    if (timeZoneLocal < 0) {
      dateTimeLocal = zero.add(Duration(hours: timeZoneLocal));
    } else {
      dateTimeLocal = zero.subtract(Duration(hours: timeZoneLocal));
    }

    return dateTimeLocal;
  }

  static int _getTimeZone(String dateTime) {
    RegExp regex = RegExp(r'\[(-?\d+):GMT\]');
    RegExpMatch? match;
    int timeZone = 0;

    if (regex.hasMatch(dateTime.trim())) {
      match = regex.firstMatch(dateTime);

      if (match != null) {
        timeZone = int.parse(match.group(1) ?? '0');
      }
    }

    return timeZone;
  }
}
