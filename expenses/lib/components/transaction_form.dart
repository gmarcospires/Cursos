import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  void _submitForm() {
    if (titleController.text.isEmpty || valueController.text.isEmpty) {
      return;
    }
    widget.onSubmit(titleController.text,
        double.tryParse(valueController.text.replaceAll(',', '.')) ?? 0.0);
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
            controller: titleController,
            onSubmitted: (_) => _submitForm(),
            // onChanged: (newValue) => title = newValue,
            decoration: InputDecoration(labelText: 'Título'),
          ),
          TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: valueController,
            onSubmitted: (_) => _submitForm(),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            // onChanged: (newValue) => value = newValue,
            decoration: InputDecoration(labelText: 'Valor (R\$)'),
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
