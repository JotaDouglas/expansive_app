// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, avoid_print
import 'dart:math';

import 'package:app_real/components/chart.dart';
import 'package:app_real/components/transactions_form.dart';
import 'package:app_real/components/transactions_list.dart';
import 'package:app_real/models/transacton.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.green,
          secondary: Colors.blueGrey,
        ),
        textTheme: tema.textTheme.copyWith(
          titleLarge: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          labelLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _transactions = <Transaction>[];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((transacao) {
      return transacao.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionsForm(_addTransaction);
        });
  }

  final titleController = TextEditingController();

  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      actions: [
        if(isLandScape)
        IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            }, 
            icon: Icon(_showChart ? Icons.list : Icons.pie_chart, color: Colors.white)
        ),
        IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ))
      ],
      title: const Text(
        'Home Page',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // if(isLandScape)
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text('Mostrar gráfico'),
              //     Switch(
              //       value: _showChart,
              //       onChanged: (value) {
              //         setState(() {
              //           _showChart = value;
              //         });
              //       },
              //     ),
              //   ],
              // ),
              if(_showChart || !isLandScape)
              Container(
                height: availableHeight * (isLandScape? 0.7 : 0.3),
                child: Chart(_recentTransactions),
              ),
              if(!_showChart || !isLandScape)
              Container(
                  height: availableHeight * (isLandScape? 1 : 0.7),
                  child: TansactionList(_transactions, _removeTransaction)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
