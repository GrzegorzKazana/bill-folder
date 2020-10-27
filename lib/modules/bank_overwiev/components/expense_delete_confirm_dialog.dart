import 'package:flutter/material.dart';

class ExpenseDeleteConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete expense'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text('Do you want to delete this expense?'),
            Text('This cannot be undone.'),
          ],
        ),
      ),
      actions: [
        TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false)),
        TextButton(
            child: Text('Delete'),
            onPressed: () => Navigator.of(context).pop(true)),
      ],
    );
  }
}
