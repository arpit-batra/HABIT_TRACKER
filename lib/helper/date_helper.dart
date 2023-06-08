import 'package:habit_tracker/models/date.dart';

class Day {
  const Day(
      {required this.fullName,
      required this.shortName,
      required this.leadingChar});
  final String fullName;
  final String shortName;
  final String leadingChar;
}

class DateHelper {
  //3rd Jan 2000 is the base date because it was Monday
  static final baseDate = DateTime(2000, 1, 3);
  static final todaysDate = DateTime.now();

  static const weekDaysArray = [
    Day(fullName: "Monday", shortName: "Mon", leadingChar: "M"),
    Day(fullName: "Tuesday", shortName: "Tue", leadingChar: "T"),
    Day(fullName: "Wednesday", shortName: "Wed", leadingChar: "W"),
    Day(fullName: "Thrusday", shortName: "Thr", leadingChar: "T"),
    Day(fullName: "Friday", shortName: "Fri", leadingChar: "F"),
    Day(fullName: "Saturday", shortName: "Sat", leadingChar: "S"),
    Day(fullName: "Sunday", shortName: "Sun", leadingChar: "S"),
  ];

  static const monthNameArray = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  static int getCurrentWeekNumber() {
    return todaysDate.difference(baseDate).inDays ~/ 7;
  }

  static List<DateTime> getWeekFromIndex(int index) {
    final baseDateOfThisWeek = baseDate.add(Duration(days: 7 * index));
    return [
      baseDateOfThisWeek,
      baseDateOfThisWeek.add(const Duration(days: 1)),
      baseDateOfThisWeek.add(const Duration(days: 2)),
      baseDateOfThisWeek.add(const Duration(days: 3)),
      baseDateOfThisWeek.add(const Duration(days: 4)),
      baseDateOfThisWeek.add(const Duration(days: 5)),
      baseDateOfThisWeek.add(const Duration(days: 6)),
    ];
  }

  static String onlyDateFromDateTime(DateTime input) {
    return "${input.day}/${input.month}/${input.year}";
  }

  static Date convertDateTimeToDate(DateTime input) {
    return Date(date: input.day, month: input.month, year: input.year);
  }

  static DateTime convertDateToDateTime(Date input) {
    return DateTime(input.year, input.month, input.date);
  }

  // static String homeTabHeading(DateTime inputDate) {
  //   if (onlyDateFromDateTime(inputDate) == onlyDateFromDateTime(todaysDate)) {
  //     return "Today";
  //   } else if (inputDate.day == todaysDate.day - 1 &&
  //       inputDate.month == todaysDate.month &&
  //       inputDate.year == todaysDate.year) {
  //     return "Yesterday";
  //   } else {
  //     return "${monthNameArray[inputDate.month - 1]} ${inputDate.day}";
  //   }
  // }

  static String homeTabHeading(Date inputDate) {
    final todayInDateFormat = convertDateTimeToDate(todaysDate);
    if (inputDate == todayInDateFormat) {
      return "Today";
    } else if (inputDate.date == todayInDateFormat.date - 1 &&
        inputDate.month == todayInDateFormat.month &&
        inputDate.year == todayInDateFormat.year) {
      return "Yesterday";
    } else {
      return "${monthNameArray[inputDate.month - 1]} ${inputDate.date}";
    }
  }

  static bool isDateABetweenBAndC(Date a, Date b, Date c) {
    return convertDateToDateTime(a).isBefore(convertDateToDateTime(c)) &&
        convertDateToDateTime(a).isAfter(convertDateToDateTime(b));
  }
}
