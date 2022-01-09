import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final double totalExpense;
  final double expense;
  const ProgressBar({
    Key? key,
    required this.totalExpense,
    required this.expense,
  }) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  var barHeight;

  @override
  Widget build(BuildContext context) {
    setHeight();
    return Container(
      child: SizedBox(
        child: Stack(
          children: [
            //bar sa luyo
            Container(
              height: 50.0,
              width: 10.0,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
            ),
            //bar na mulihok
            Container(
              height: barHeight,
              width: 10.0,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setHeight() {
    if (widget.totalExpense == 0) {
      setState(() {
        barHeight = 0.0;
      });
    } else {
      setState(() {
        barHeight = ((widget.expense / widget.totalExpense) * 100) / 2;
      });
    }
  }
}
