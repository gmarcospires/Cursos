import 'package:flutter/material.dart';

class TransactionItemEmpty extends StatelessWidget {
  const TransactionItemEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Nenhuma Transação Cadastrada!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
                height: constraints.maxHeight * 0.6,
                child:
                    Image.asset('assets/images/waiting.png', fit: BoxFit.cover))
          ],
        );
      },
    );
  }
}
