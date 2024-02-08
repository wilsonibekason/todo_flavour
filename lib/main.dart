import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transactions.dart';
import "./transactions_list.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _titleInput;
  late double _amountInput;

  final List<Transaction> _transactions = List.generate(1, (index) {
    return Transaction(
      id: index.toString(),
      title: "Expense ${index + 1}",
      amount: (index + 1) * 10.0,
      date: DateTime.now().subtract(Duration(days: index)),
    );
  });

  @override
  void initState() {
    super.initState();
    _titleInput = '';
    _amountInput = 0;
  }

  void _addNewTransactions(String txTitle, double txAmount) {
    if (txTitle.isEmpty || txAmount <= 0) return;
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTx);
    });
  }

  // List<Transaction> get _recentTransactions {
  //   return _userTransactions
  //       .where((element) =>
  //           element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
  //       .toList(); // Add .toList() to convert Iterable<Transaction> to List<Transaction>
  // }

  void _onValueAmt(dynamic value) {
    if (value is double) {}
    if (value is String) {}
  }

  void _onChangeTitle(String value) {
    setState(() {
      _titleInput = value;
    });
  }

  void _onChangeAmount(double value) {
    setState(() {
      _amountInput = value;
    });
  }

  void _txOnChangeAmount(String? value) {
    // Convert value to double
    double? parsedValue = double.tryParse(value ?? '');
    if (parsedValue != null) {
      // Call your original function with the parsed value
      _onChangeAmount(parsedValue);
    }
  }

  void _onBuyTicketsPressed() {
    if (kDebugMode) {
      print('Buy Tickets Pressed!');
    }
  }

  void _onListenPressed() {
    if (kDebugMode) {
      print('Listen Pressed!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                elevation: 5,
                child: const Text('CHART!'),
                margin: EdgeInsets.all(8),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      textAlign: TextAlign.start,
                      onChanged: _onChangeTitle,
                      keyboardType: TextInputType.text,
                      onSubmitted: (_) =>
                          _addNewTransactions(_titleInput, _amountInput),
                      decoration: InputDecoration(
                        labelText: "Title",
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.start,
                      onChanged: _txOnChangeAmount,
                      keyboardAppearance: Brightness.dark,
                      onSubmitted: (_) =>
                          _addNewTransactions(_titleInput, _amountInput),
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      decoration: InputDecoration(
                        labelText: "Amount",
                      ),
                    ),
                    TextButton(
                      // onPressed: () => _onAddTransaction('amount'),
                      onPressed: () =>
                          _addNewTransactions(_titleInput, _amountInput),
                      child: const Text("Add Transaction"),
                    ),
                    Text("$_amountInput $_titleInput")
                  ],
                ),
              ),
            ),
            const Card(
              child: Text('LIST OF TX'),
            ),
            Container(
              width: double.infinity,
              child: const Card(
                elevation: 6,
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
            ),
            Center(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.album),
                      title: Text('The Enchanted Nightingale'),
                      subtitle:
                          Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: _onBuyTicketsPressed,
                          child: const Text('BUY TICKETS'),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: _onListenPressed,
                          child: const Text('LISTEN'),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: _transactions.map((tx) {
                return Center(
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 3)),
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
              // NEW TRANSACTION LIST
            ),
            TransactionList()
          ],
        ),
      ),
    );
  }

  void _onAddTransaction(String type) {
    if (type == 'title') {
      // Handle title input
      if (kDebugMode) {
        print("Title Changed: $_titleInput");
      }
    } else if (type == "all") {
      _addNewTransactions(_titleInput, _amountInput);
    } else {
      // Handle amount input
      if (kDebugMode) {
        print("Amount Changed: $_amountInput");
      }
    }
  }
}
