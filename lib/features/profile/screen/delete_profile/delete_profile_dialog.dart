

import '../../../../utils/constants/path_provider.dart';

class DeleteReasonDialog {
  static final _formKey = GlobalKey<FormState>();
  static final TextEditingController _reasonController =
  TextEditingController();

  /// SHOW DELETE CONFIRMATION DIALOG
  static Future<void> show({
    required String title,
    required String description,
    required Function(String reason) onConfirm,
  }) async {
    _reasonController.clear();

    await Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: const [
            Icon(Icons.warning_amber_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text("Confirm Deletion"),
          ],
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: const TextStyle(color: Colors.black87),
              ),
              const SizedBox(height: 12),

              /// Reason Field
              TextFormField(
                controller: _reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Reason for deletion",
                  hintText: "Enter a brief reason",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please provide a reason";
                  }
                  if (value.trim().length < 5) {
                    return "Reason must be at least 5 characters";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Get.back();
                onConfirm(_reasonController.text.trim());
              }
            },
            child: const Text("Delete"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
