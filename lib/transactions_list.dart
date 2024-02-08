import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/transactions.dart';
// import "package:flutter/foundation.dart"

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final List<Transaction> _userTransactions = List.generate(1, (index) {
    return Transaction(
      id: index.toString(),
      title: "BookList ${index + 1}",
      amount: (index + 1) * 10.0,
      date: DateTime.now().subtract(Duration(days: index)),
    );
  });

// defining functions

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList(); // Add .toList() to convert Iterable<Transaction> to List<Transaction>
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: _userTransactions.map((tx) {
        return Center(
          child: Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3)),
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    tx.amount.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tx.title,
                      style: const TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      DateFormat("yyyy/MM/dd").format(tx.date),
                      style: const TextStyle(
                          fontSize: 6, color: Colors.amberAccent),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList(),
    ));
  }
}
