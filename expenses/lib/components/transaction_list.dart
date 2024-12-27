import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/components/transaction_item_empty.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove, {super.key});
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? const TransactionItemEmpty()
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, idx) {
              final tr = transactions[idx];
              return TransactionItem(
                tr: tr,
                onRemove: onRemove,
                // key: ValueKey(tr.id),
                key: GlobalObjectKey(tr.id),
              );
            },
          );
  }
}
