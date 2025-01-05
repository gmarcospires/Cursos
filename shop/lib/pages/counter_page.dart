import 'package:flutter/material.dart';
import 'package:shop/providers/counter.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    final CounterState? provider = CounterProvider.of(context)?.state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo contador'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(provider?.value.toString() ?? '0'),
            IconButton(
              onPressed: () {
                setState(() {
                  provider?.inc();
                });

                // print(provider?.value);
              },
              icon: Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  provider?.dec();
                });

                // print(provider?.value);
              },
              icon: Icon(Icons.remove),
            )
          ],
        ),
      ),
    );
  }
}
