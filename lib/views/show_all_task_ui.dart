import 'package:flutter/material.dart';
import 'package:flutter_task_v1_app/views/add_task_ui.dart';

class ShowAllTaskUi extends StatefulWidget {
  const ShowAllTaskUi({super.key});

  @override
  State<ShowAllTaskUi> createState() => _ShowAllTaskUiState();
}

class _ShowAllTaskUiState extends State<ShowAllTaskUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Center(
          child: Text(
            'Task Krubb',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskUi(),
            ),
          );
        },
        backgroundColor: Colors.greenAccent,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
