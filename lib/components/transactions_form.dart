// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class TransactionsForm extends StatefulWidget {
  Function(String, double) addTransaction;
  TransactionsForm(this.addTransaction,{super.key});

  @override
  State<TransactionsForm> createState() => _TransactionsFormState();
}

class _TransactionsFormState extends State<TransactionsForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm(){
    final title = titleController.text;
    final value = double.tryParse(valueController.text)??0;

    if(title.isEmpty || value <= 0){
      return;
    }

    widget.addTransaction(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      onSubmitted: (_)=>{_submitForm()},
                      decoration: InputDecoration(labelText: 'Título'),
                    ),
                    TextField(
                      controller: valueController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onSubmitted: (_)=>{_submitForm()},
                      decoration: InputDecoration(labelText: 'Valor (R\$)'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _submitForm,
                          child: Text(
                            "Nova Transação",
                            style: TextStyle(color: Colors.purple),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
  }
}