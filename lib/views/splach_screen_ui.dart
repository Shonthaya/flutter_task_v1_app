// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_task_v1_app/views/show_all_task_ui.dart';

class SplachScreenUi extends StatefulWidget {
  const SplachScreenUi({super.key});

  @override
  State<SplachScreenUi> createState() => _SplachScreenUiState();
}

class _SplachScreenUiState extends State<SplachScreenUi> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ShowAllTaskUi(),
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/ic_logo_radius.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 30),
                Text(
                  'Task Krubb',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 50),
                CircularProgressIndicator(
                  strokeWidth: 6,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Created by Shon tha ya',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Southeast Asia University',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
