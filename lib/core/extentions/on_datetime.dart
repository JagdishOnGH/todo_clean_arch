extension DateX on DateTime {
  String toShort() {
    return "${day.toString().padLeft(2, '0')}/"
        "${month.toString().padLeft(2, '0')}/"
        "${year.toString()}";
  }
}
