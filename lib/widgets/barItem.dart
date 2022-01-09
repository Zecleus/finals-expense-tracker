import 'package:expense_tracker/widgets/progressBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BarItem extends StatefulWidget {
  final double totalExpense;
  final double expense;
  final String dayName;
  const BarItem({
    Key? key,
    required this.totalExpense,
    required this.expense,
    required this.dayName,
  }) : super(key: key);

  @override
  _BarItemState createState() => _BarItemState();
}

class _BarItemState extends State<BarItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              NumberFormat.simpleCurrency(locale: 'fil').format(widget.expense),
              style: TextStyle(
                fontSize: 11,
              ),
            ),
            ProgressBar(
              totalExpense: widget.totalExpense,
              expense: widget.expense,
            ),
            Text(
              getDayName(widget.dayName),
              style: TextStyle(
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getDayName(String dayNameFull) {
    String shortDay = '';

    switch (dayNameFull) {
      case 'Monday':
        shortDay = 'Mon';
        break;
      case 'Tuesday':
        shortDay = 'Tues';
        break;
      case 'Wednesday':
        shortDay = 'Wed';
        break;
      case 'Thursday':
        shortDay = 'Thurs';
        break;
      case 'Friday':
        shortDay = 'Fri';
        break;
      case 'Saturday':
        shortDay = 'Sat';
        break;
      case 'Sunday':
        shortDay = 'Sun';
        break;
      default:
        shortDay = 'null';
    }
    return shortDay;
  }
}
