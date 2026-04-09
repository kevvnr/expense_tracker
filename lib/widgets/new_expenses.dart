
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget{
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  State<NewExpense> createState(){
    return _NewExpenseState();
  }
}
class _NewExpenseState extends State<NewExpense>{
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null) {
      showDialog(context:context, builder: (ctx)=>
        AlertDialog(
          title: const Text('Invalid Input!'),
          content: const Text('Please make sure valid title, amount, date were entered!'),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        )
      );
      return;
    }

    widget.onAddExpense(Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    ));
    Navigator.pop(context);
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year -1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context:context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,  
    );
    print(pickedDate);
    setState((){
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose(){
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children:[
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller:_amountController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\$',
                    label: Text("Amount"),
                  ),
                ),
              ),
              SizedBox(width:16),
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text(
                  _selectedDate == null ?
                  'Select Date' :
                  formatter.format(_selectedDate!)
                ),
                IconButton(onPressed: _presentDatePicker, icon: const Icon(Icons.calendar_month))
              ],),),
            ],
          ),
          SizedBox(height: 10),
          Row(children: [
            DropdownButton(
              value: _selectedCategory,
              items: Category.values.map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.name.toUpperCase(),),
                ),
              ).toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedCategory = value;
                });
              }),
              Spacer(),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Cancel")),
            ElevatedButton(onPressed: _submitExpenseData, child: Text("Save Expense")),
          ],)
        ]
      )
  );
  }
}