import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

void main(List<String> args) async {
  await initializeDateFormatting('pt_BR', null);
  Intl.defaultLocale = 'pt_BR';
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color(0xFFCFD600), brightness: Brightness.dark),
          fontFamily: GoogleFonts.roboto().fontFamily,
          useMaterial3: true),
      theme: ThemeData(
          useMaterial3: true,
          // appBarTheme: AppBarTheme(
          //   titleTextStyle: GoogleFonts.comicNeue(
          //       textStyle: TextStyle(
          //         // color: AppBarTheme().titleTextStyle.color,
          //     fontSize: 20,
          //     fontWeight: FontWeight.bold,
          //   )),
          // ),
          fontFamily: GoogleFonts.roboto().fontFamily,
          // fontFamily: 'OpenSans',
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFCFD600))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //     date: DateTime.now(),
    //     id: 't1',
    //     title: 'Novo Tênis de Corrida',
    //     value: 310.76),
    // Transaction(
    //     date: DateTime.now(), id: 't2', title: 'Conta de Luz', value: 211.30),
    // Transaction(
    //     date: DateTime.now(), id: 't3', title: 'Conta de Água', value: 100.30),
    // Transaction(
    //     date: DateTime.now(), id: 't4', title: 'Conta de Telefone', value: 100),
    // Transaction(
    //     date: DateTime.now(), id: 't5', title: 'Cartão de Crédito', value: 100),
    // Transaction(
    //     date: DateTime.now(), id: 't6', title: 'Empréstimo', value: 100),
    // Transaction(
    //     date: DateTime.now(), id: 't7', title: 'Supermercado', value: 100),
    // Transaction(date: DateTime.now(), id: 't8', title: 'Aluguel', value: 100),
  ];

  void _addtransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop(); // Fecha o modal
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addtransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 5,
                child: Text('Gráfico'),
              ),
            ),
            const Divider(
              indent: 20,
              endIndent: 20,
            ),
            TransactionList(_transactions)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        elevation: 10,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
