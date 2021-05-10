class DateTimeFormat {
  static String formatDate(int? date) {
    if (date! < 10) {
      return '0$date';
    }
    return date.toString();
  }

  static String formatTime(int? time) {
    if (time! < 10) {
      return '0$time';
    }
    return time.toString();
  }
}
