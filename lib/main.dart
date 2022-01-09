import 'package:expense_tracker/notFound.dart';
import 'package:expense_tracker/widgets/barChart.dart';
import 'package:expense_tracker/widgets/sheetContent.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'models/dayExpenseModel.dart';
import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Expense Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<TransactionModel> transactionList = <TransactionModel>[];
  static List<DayExpense> dayExpenseList = <DayExpense>[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.purple,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: showSlidingSheet,
                child: Icon(
                  Icons.add,
                  size: 26,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              BarChart(
                  transactionList: transactionList,
                  dayExpenseList: dayExpenseList),
              transactionList.isEmpty
                  ? NotFound()
                  : Expanded(
                      child: Container(
                        child: ListView(
                          children: List.generate(
                            transactionList.length,
                            (index) {
                              return buildTransactionCard(
                                transactionList[index].expense,
                                transactionList[index].title,
                                transactionList[index].transDate!,
                                transactionList[index],
                                transactionList,
                                dayExpenseList,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: showSlidingSheet,
          tooltip: 'Add Transaction',
          backgroundColor: Colors.yellow[600],
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  void showSlidingSheet() async {
    // ignore: unused_local_variable
    final result = await showSlidingBottomSheet(
      context,
      builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 16,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.4, 0.7, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (context, state) {
            return SheetContent();
          },
        );
      },
    );
    if (result != null) {
      addTransaction(result);
    }
  }

  void addTransaction(TransactionModel transaction) {
    setState(() {
      transactionList.add(transaction);
    });
  }

  Widget buildTransactionCard(
    double expense,
    String title,
    DateTime dateTime,
    TransactionModel transaction,
    List<TransactionModel> transactionList,
    List<DayExpense> dayExpenseList,
  ) =>
      Container(
        child: Padding(
          padding: const EdgeInsets.all(5.00),
          child: SizedBox(
            height: 80,
            child: Card(
              elevation: 5,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Container(
                      //amount
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            NumberFormat.simpleCurrency(locale: 'fil')
                                .format(expense),
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      //title
                      width: 240,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                DateFormat.yMMMMd('en_US').format(dateTime),
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      //delete
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Icon(
                          Icons.delete,
                          size: 26.0,
                          color: Colors.red,
                        ),
                        onTap: () {
                          setState(() {
                            var transactionDay = DateFormat('EEEE')
                                .format(transaction.transDate!);
                            for (int i = 0; i < 7; i++) {
                              if (transactionDay == dayExpenseList[i].dayName) {
                                dayExpenseList[i].expenseDay =
                                    dayExpenseList[i].expenseDay -
                                        transaction.expense;
                              }
                            }
                            transactionList.remove(transaction);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
