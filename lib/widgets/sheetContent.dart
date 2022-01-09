import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SheetContent extends StatefulWidget {
  const SheetContent({Key? key}) : super(key: key);

  @override
  _SheetContentState createState() => _SheetContentState();
}

class _SheetContentState extends State<SheetContent> {
  DateTime selectedDate = DateTime.now();
  bool hasSelected = false;
  TransactionModel transaction = TransactionModel(
      expense: 0, title: 'title', transDate: null, isAdded: false);
  TextEditingController transTitle = TextEditingController();
  TextEditingController transExpense = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height + 0.45,
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: transTitle,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              TextFormField(
                controller: transExpense,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hasSelected
                          ? 'Picked Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                          : 'No Date Chosen',
                    ),
                    TextButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text('Choose Day'),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (transExpense.text.isNotEmpty &&
                      transTitle.text.isNotEmpty &&
                      hasSelected) {
                    transaction.expense = double.parse(transExpense.text);
                    transaction.title = transTitle.text;
                    transaction.transDate = selectedDate;
                    Navigator.pop(context, transaction);
                  }
                },
                child: SizedBox(
                  height: 25,
                  width: 100,
                  child: Center(
                    child: Text(
                      'Add Transaction',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate:
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day - 6),
      lastDate: selectedDate,
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        hasSelected = true;
        selectedDate = selected;
      });
    }
  }
}
