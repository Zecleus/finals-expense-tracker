import 'package:expense_tracker/models/dayExpenseModel.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/barItem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class BarChart extends StatefulWidget {
  List<TransactionModel> transactionList =
      <TransactionModel>[]; //list of transactions
  List<DayExpense> dayExpenseList = <DayExpense>[]; //list of day information
  BarChart({
    Key? key,
    required this.transactionList,
    required this.dayExpenseList,
  }) : super(key: key);

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  DateTime selectedDate = DateTime.now();
  double totalExpense = 0.0;

  @override
  Widget build(BuildContext context) {
    if (widget.dayExpenseList.length != 7) {
      populateExpenseList();
    }
    totalExpense = getTotalExpense(widget.transactionList);
    getExpense(widget.transactionList);
    return Container(
      child: SizedBox(
        width: 500,
        height: 100,
        child: Card(
            elevation: 5,
            color: Colors.white,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                children: [
                  BarItem(
                      totalExpense: totalExpense,
                      expense: widget.dayExpenseList[6].expenseDay,
                      dayName: widget.dayExpenseList[6].dayName),
                  BarItem(
                      totalExpense: totalExpense,
                      expense: widget.dayExpenseList[5].expenseDay,
                      dayName: widget.dayExpenseList[5].dayName),
                  BarItem(
                      totalExpense: totalExpense,
                      expense: widget.dayExpenseList[4].expenseDay,
                      dayName: widget.dayExpenseList[4].dayName),
                  BarItem(
                      totalExpense: totalExpense,
                      expense: widget.dayExpenseList[3].expenseDay,
                      dayName: widget.dayExpenseList[3].dayName),
                  BarItem(
                      totalExpense: totalExpense,
                      expense: widget.dayExpenseList[2].expenseDay,
                      dayName: widget.dayExpenseList[2].dayName),
                  BarItem(
                      totalExpense: totalExpense,
                      expense: widget.dayExpenseList[1].expenseDay,
                      dayName: widget.dayExpenseList[1].dayName),
                  BarItem(
                      totalExpense: totalExpense,
                      expense: widget.dayExpenseList[0].expenseDay,
                      dayName: widget.dayExpenseList[0].dayName),
                ],
              ),
            )),
      ),
    );
  }

  void getExpense(List<TransactionModel> transactionList) {
    if (transactionList.isNotEmpty) {
      setState(() {
        for (TransactionModel trans in transactionList) {
          var transactionDay = DateFormat('EEEE').format(trans.transDate!);
          for (int i = 0; i < 7; i++) {
            if (transactionDay == widget.dayExpenseList[i].dayName) {
              if (trans.isAdded == false) {
                widget.dayExpenseList[i].expenseDay =
                    widget.dayExpenseList[i].expenseDay + trans.expense;
                trans.isAdded = true;
              }
            }
          }
        }
      });
    }
  }

  double getTotalExpense(List<TransactionModel> transactionList) {
    var totalExpense = 0.0;
    for (TransactionModel trans in transactionList) {
      totalExpense = totalExpense + trans.expense;
    }
    return totalExpense;
  }

  void populateExpenseList() {
    DateTime selectedDate = DateTime.now();
    setState(() {
      for (int i = 0; i < 7; i++) {
        widget.dayExpenseList.add(DayExpense(
            expenseDay: 0, dayName: DateFormat('EEEE').format(selectedDate)));
        selectedDate = new DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day - 1,
        );
      }
    });
  }
}
