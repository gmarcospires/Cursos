import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdaptativeTextfield extends StatelessWidget {
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(String)? onSubmitted;
  final String label;

  const AdaptativeTextfield({
    super.key,
    required this.controller,
    required this.label,
    this.inputFormatters,
    this.keyboardType,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              onSubmitted: onSubmitted,
              placeholder: label,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 6,
              ),
            ),
          )
        : TextField(
            keyboardType: keyboardType,
            controller: controller,
            onSubmitted: onSubmitted,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(labelText: label),
          );
  }
}
