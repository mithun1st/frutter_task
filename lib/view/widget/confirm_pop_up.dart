import 'package:flutter/material.dart';

Future<bool> confirm(BuildContext ctx) async {
  return await showDialog(
    context: ctx,
    builder: (_) {
      return AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text("Do you really want to lose the changes ??"),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(true);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
