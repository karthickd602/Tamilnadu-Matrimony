
import '../../../utils/constants/path_provider.dart';

Future<void> customAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  VoidCallback? onYes,
  String yesText = 'Yes',
  String noText = 'No',
  Color? yesButtonColor,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          content ?? "",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, // Close dialog
            child: Text(noText),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: yesButtonColor),
            onPressed: () {
              Get.back();
              if (onYes != null) onYes();
            },
            child: Text(yesText),
          ),
        ],
      );
    },
  );
}
