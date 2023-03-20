class DateToStringConverter {
  static convert(DateTime date) {
    final dateSplitted = date.toString().split(' ');
    return dateSplitted.first;
  }
}
