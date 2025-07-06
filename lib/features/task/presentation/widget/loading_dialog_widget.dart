import 'package:flutter/material.dart';

Future<void> showUnskippableLoadingDialog(BuildContext context,
    {String? message}) {
  return showDialog(
    context: context,
    barrierDismissible: false, // Tapping outside doesn't dismiss
    builder: (_) => PopScope(
      canPop: false, // Back button disabled
      child: AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message ?? 'Loading...',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
