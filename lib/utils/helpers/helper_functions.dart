import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class THelperFunctions {




  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }/// 📅 Show Date Picker
  static Future<void> showDatePickerField(TextEditingController controller,{DateTime? initialDate,DateTime? lastDate,DateTime? firstDate}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate:initialDate?? DateTime.now(),
      firstDate:firstDate?? DateTime(1935),
      lastDate: lastDate??DateTime.now(),
    );

    if (pickedDate != null) {
      controller.text = DateFormat('dd-MMM-yyyy').format(pickedDate);
    }
  }

  /// ⏰ Show Time Picker
  static Future<void> showTimePickerField(TextEditingController controller) async {
    final TimeOfDay? pickedTime =
    await showTimePicker(context: Get.context!, initialTime: TimeOfDay.now());

    if (pickedTime != null) {
      final now = DateTime.now();
      final formattedTime = DateFormat('HH:mm').format(DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      ));
      controller.text = formattedTime;
    }
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  static String formatDateTimeWithSecString(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '-';
    try {
      final date = DateTime.parse(dateString);
      return getFormattedDateAndTimeWithSec(date);
    } catch (e) {
      return dateString;
    }
  }  static String formatDateString(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '-';
    try {
      final date = DateTime.parse(dateString);
      return getFormattedDate(date);
    } catch (e) {
      return dateString;
    }
  }
  static String getFormattedDateAndTimeWithSec(
      DateTime date, {
        String format = 'dd-MM-yyyy - HH:mm:ss',
      }) {
    return DateFormat(format).format(date);
  }


  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd-MMM-yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }
}
