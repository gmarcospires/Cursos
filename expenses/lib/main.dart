import 'dart:io';
import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('pt_BR', null);
  Intl.defaultLocale = 'pt_BR';

  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   // DeviceOrientation.portraitDown,
    // ]);

    return MaterialApp(
      home: MyHomePage(),
      supportedLocales: [Locale('pt', 'BR')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
    //   Transaction(
    //       date: DateTime.now(),
    //       id: 't1',
    //       title: 'Novo Tênis de Corrida',
    //       value: 310.76),
    //   Transaction(
    //       date: DateTime.now().subtract(Duration(days: 1)),
    //       id: 't2',
    //       title: 'Conta de Luz',
    //       value: 211.30),
    //   Transaction(
    //       date: DateTime.now().subtract(Duration(days: 2)),
    //       id: 't3',
    //       title: 'Conta de Água',
    //       value: 100.30),
    //   Transaction(
    //       date: DateTime.now().subtract(Duration(days: 2)),
    //       id: 't4',
    //       title: 'Conta de Telefone',
    //       value: 100),
    //   Transaction(
    //       date: DateTime.now().subtract(Duration(days: 2)),
    //       id: 't5',
    //       title: 'Cartão de Crédito',
    //       value: 100),
    //   Transaction(
    //       date: DateTime.now().subtract(Duration(days: 2)),
    //       id: 't6',
    //       title: 'Empréstimo',
    //       value: 100),
    //   Transaction(
    //       date: DateTime.now().subtract(Duration(days: 2)),
    //       id: 't7',
    //       title: 'Supermercado',
    //       value: 100),
    //   Transaction(
    //       date: DateTime.now().subtract(Duration(days: 3)),
    //       id: 't8',
    //       title: 'Aluguel',
    //       value: 100),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addtransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop(); // Fecha o modal
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
              child: TransactionForm(_addtransaction),
            ),
          );
        });
  }

  Widget _getIconButtom(IconData icon, void Function() fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(
            icon: Icon(icon),
            onPressed: fn,
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    // print(
    //     'Text Scale: ${mediaQuery.textScaler}, ${mediaQuery.textScaler.scale(5)}');
    final avaliableHeight = mediaQuery.size.height -
        AppBar().preferredSize.height -
        mediaQuery.padding.top;

    final actions = [
      if (isLandscape)
        _getIconButtom(
          _showChart
              ? (Platform.isIOS ? CupertinoIcons.news : Icons.list)
              : (Platform.isIOS
                  ? CupertinoIcons.chart_bar
                  : Icons.bar_chart_rounded),
          () => setState(() {
            _showChart = !_showChart;
          }),
        ),
      _getIconButtom(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ];

    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Despesas Pessoais'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            title: const Text('Despesas Pessoais'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: actions,
          );

    final bodyPage = SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (_showChart || !isLandscape)
              SizedBox(
                width: double.infinity,
                height: avaliableHeight * (isLandscape ? 0.7 : 0.4),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: avaliableHeight * (isLandscape ? 1 : 0.50),
                child: TransactionList(_transactions, _removeTransaction),
              )
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: bodyPage)
        : Scaffold(
            appBar: appBar as PreferredSizeWidget,
            body: bodyPage,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _openTransactionFormModal(context),
              elevation: 10,
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation: Platform.isIOS
                ? null
                : FloatingActionButtonLocation.centerFloat,
          );
  }
}
