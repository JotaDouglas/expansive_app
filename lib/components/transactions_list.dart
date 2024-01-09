// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_real/models/transacton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TansactionList extends StatelessWidget {
  final List<Transaction> transaction;

  const TansactionList(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transaction.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Lista Vazia",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (contexto, index) {
                final tr = transaction[index];
                return Card(
                  child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2)),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "R\$ ${tr.value.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tr.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(DateFormat('dd/MM/y').format(tr.date),
                              style: TextStyle(color: Colors.grey[800])),
                        ],
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
