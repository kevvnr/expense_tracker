import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }

}
class _ExpensesState extends State<Expenses>{
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Ginos Pizza',
      amount: 25.00,
      date: DateTime.now(),
      category: Category.food
    ),
    Expense(
      title: 'Train Ticket to Manhattan',
      amount: 15.25,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(icon: const Icon(Icons.add),
          onPressed: (){

          },
           )
        ],
      ),
    body: Column(
      children: [
        Text('CHART GOES HERE'),
        Expanded(
          child: ExpensesList(expenses: _registeredExpenses)),
      ],
    ),
    );
  }
  
}