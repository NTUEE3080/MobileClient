import 'package:coursecupid/core/result_ext.dart';

enum Day { mon, tue, wed, thu, fri }

extension StringDayExt on String {
  Result<Day, String> toDay() {
    switch (this) {
      case "Monday":
        return Result.ok(Day.mon);
      case "Tuesday":
        return Result.ok(Day.tue);
      case "Wednesday":
        return Result.ok(Day.wed);
      case "Thursday":
        return Result.ok(Day.thu);
      case "Friday":
        return Result.ok(Day.fri);
      default:
        return Result.error("Unknown Day String $this");
    }
  }
}

extension DayExt on Day {
  String serialize() {
    switch (this) {
      case Day.mon:
        return "Monday";
      case Day.tue:
        return "Tuesday";
      case Day.wed:
        return "Wednesday";
      case Day.thu:
        return "Thursday";
      case Day.fri:
        return "Friday";
    }
  }
}

extension TimeStringExt on String {
  Result<Time, String> toTime() {
    var s = this;
    var frags = s.split(":");
    if (frags.length != 2) {
      return Result.error("Incorrect string format. HH:MM");
    }
    try {
      final hour = int.parse(frags[0]);
      final min = int.parse(frags[1]);
      if (hour > 23 || hour < 0) {
        return Result.error("Hours must be between 0 and 23");
      }
      if (min > 59 || min < 0) {
        return Result.error("Minutes must be between 0 and 59");
      }
      return Result.ok(Time(hour, min));
    } on FormatException catch (e) {
      return Result.error("Incorrect string format. Failed to parse HH or MM");
    }
  }
}

class Time {
  final int hour;
  final int min;

  const Time(this.hour, this.min);

  String serialize() {
    return "$hour:$min";
  }
}
