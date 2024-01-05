// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:app_real/models/transacton.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Nova Chuteira',
      value: 499.80,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Nova bola',
      value: 125.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Nova Camiseta',
      value: 89.90,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            elevation: 5,
            child: Text("Gráfico"),
          ),
          Column(
            children: _transactions.map((transacao) {
              return Card(
                child: Row(
                  children: [
                    Container(child: Text(transacao.value.toString()),),
                    Column(children: [Text(transacao.title), Text(transacao.date.toString())],),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
