import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_date_picker.dart';
import 'package:expenses/components/adaptative_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _dateController = DateTime.now();

  void _submitForm() {
    if (_titleController.text.isEmpty ||
        _valueController.text.isEmpty ||
        _dateController == null) {
      return;
    }
    widget.onSubmit(
      _titleController.text,
      double.tryParse(_valueController.text.replaceAll(',', '.')) ?? 0.0,
      _dateController!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        // elevation: 5,
        child: Column(
          children: [
            Text('Adicionar nova transação',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(),
            AdaptativeTextfield(
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              // onChanged: (newValue) => title = newValue,
              label: 'Título',
            ),
            AdaptativeTextfield(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _valueController,
              onSubmitted: (_) => _submitForm(),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              // onChanged: (newValue) => value = newValue,
              label: 'Valor (R\$)',
            ),
            AdaptativeDatePicker(
              selectedDate: _dateController ?? DateTime.now(),
              onDateChanged: (newDate) {
                setState(() {
                  _dateController = newDate;
                });
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: AdaptativeButton(
                label: 'Nova transação',
                onPressed: _submitForm,
                typeAndroidButtom: 'FilledButton',
              ),
            )
          ],
        ));
  }
}
