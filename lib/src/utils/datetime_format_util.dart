class DateTimeFormat {
  static String formatDate(String? date) {
    if (date!.length < 2) {
      return '0$date';
    }
    return date.toString();
  }

  static String formatTime(String? time) {
    if (time!.length < 2) {
      return '0$time';
    }
    return time.toString();
  }
}
