import 'package:flutter/material.dart';

// This dialog is used to confirm task deletion.

Future<void> showDeleteDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
  required String title, // You can pass task title or custom label
}) {
  return showDialog(
    context: context,
    barrierDismissible: true, // Prevent dismissing by tapping outside
    builder: (context) => PopScope(
      canPop: false, // Prevent back button dismiss
      child: AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "$title"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              onConfirm();
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    ),
  );
}
