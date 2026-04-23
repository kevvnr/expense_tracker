import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/number_symbols_data.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }

}
class _ExpensesState extends State<Expenses>{
  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      isScrollControlled: true ,
    context: context,
    builder: (ctx) => NewExpense
    (onAddExpense:_addExpense));
  }
  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }
  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
      duration:Duration(seconds: 3),
      content: Text("Expense deleted."),
      action: SnackBarAction(
        label: "Undo",
         onPressed: (){
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense );
          });
         },
        ),
      ),
    );
  }
  
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
    Expense(
      title: 'Movie Ticket',
      amount: 18.00,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  @override
  Widget build(BuildContext context) {

  //print("Width : ${MediaQuery.of(context).size.width}");
   // print("height : ${MediaQuery.of(context).size.height}");
   var width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center
    (child: Text("No expenses. Click + to add one."));
    if(_registeredExpenses.isNotEmpty){
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar:AppBar(
        title: const Text("Expense Tracker"),
        actions:[
          IconButton(icon: const Icon(Icons.add), 
          onPressed:_openAddExpenseOverlay,
          ) //IconButton
        ],
      ), //AppBar
    body: width < 600 ? Column(
      children: [
        Chart(expenses: _registeredExpenses),
        Expanded(child:mainContent),
      ],
    ):
    Row(
      children :[
      Expanded(child: Chart(expenses: _registeredExpenses)),
      Expanded(child:mainContent),
    ])
    );
  }

}