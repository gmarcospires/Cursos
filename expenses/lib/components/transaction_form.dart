import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _dateController ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
      // locale: Locale('pt', 'BR'),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dateController = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        // elevation: 5,
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text('Adicionar nova transação',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(),
          TextField(
            controller: _titleController,
            onSubmitted: (_) => _submitForm(),
            // onChanged: (newValue) => title = newValue,
            decoration: InputDecoration(labelText: 'Título'),
          ),
          TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: _valueController,
            onSubmitted: (_) => _submitForm(),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            // onChanged: (newValue) => value = newValue,
            decoration: InputDecoration(labelText: 'Valor (R\$)'),
          ),
          SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(_dateController == null
                      ? 'Nenhuma data selecionada'
                      : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_dateController!)}'),
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: Text(
                    'Selecionar data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: _submitForm,
              child: Text('Nova transação'),
            ),
          )
        ],
      ),
    ));
  }
}
