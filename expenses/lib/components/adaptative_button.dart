import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final String typeAndroidButtom;

  const AdaptativeButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.typeAndroidButtom = '',
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Theme.of(context).primaryColor,
            onPressed: onPressed,
            child: Text(label),
          )
        : typeAndroidButtom == 'FilledButton'
            ? FilledButton(
                onPressed: onPressed,
                child: Text(label),
              )
            : typeAndroidButtom == 'TextButton'
                ? TextButton(
                    onPressed: onPressed,
                    child: Text(
                      label,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : ElevatedButton(
                    onPressed: onPressed,
                    child: Text(label),
                  );
  }
}
