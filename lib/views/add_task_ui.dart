import 'package:flutter/material.dart';

class AddTaskUi extends StatefulWidget {
  const AddTaskUi({super.key});

  @override
  State<AddTaskUi> createState() => _AddTaskUiState();
}

class _AddTaskUiState extends State<AddTaskUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Center(
          child: Text(
            'Task Krubb - Add',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
