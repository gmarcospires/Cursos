import 'dart:io';

import 'package:expenses/components/adaptative_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  const AdaptativeDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
      // locale: Locale('pt', 'BR'),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              maximumDate: DateTime.now(),
              minimumDate: DateTime(2022),
              initialDateTime: selectedDate,
              onDateTimeChanged: (value) => onDateChanged(value),
            ),
          )
        : SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                      'Data Selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}'),
                ),
                AdaptativeButton(
                  label: 'Selecionar data',
                  onPressed: () => _showDatePicker(context),
                  typeAndroidButtom: 'TextButton',
                )
              ],
            ),
          );
  }
}
