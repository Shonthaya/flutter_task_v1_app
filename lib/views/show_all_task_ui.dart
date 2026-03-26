import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_task_v1_app/models/task.dart';
import 'package:flutter_task_v1_app/services/supabase_services.dart';
import 'package:flutter_task_v1_app/views/add_task_ui.dart';

class ShowAllTaskUi extends StatefulWidget {
  const ShowAllTaskUi({super.key});

  @override
  State<ShowAllTaskUi> createState() => _ShowAllTaskUiState();
}

class _ShowAllTaskUiState extends State<ShowAllTaskUi> {
  // สร้าง instance/object/ตัวแทนของ supabase services
  final Services = SupabaseServices();

  // สร้างตัวแปรสำหรับเก็บข้อมูลที่ดึงมาจาก supabase
  List<Task> tasks = [];

  // สร้าง method สำหรับดึงข้อมูลจาก supabase มาแสดงใน UI
  void loadTasks() async {
    final data = await Services.getTasks();

    setState(() {
      tasks = data;
    });
  }

  @override
  void initState() {
    super.initState();
    // เรียกใช้งาน method ตอนหน้าจอถูกเปิดขึ้นมา
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(
          'Task Krubb - All Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
      // ส่วน body ที่แสดง logo และข้อมูล supabase
      body: Center(
        child: Column(
          children: [
            // Logo
            SizedBox(height: 40),
            Image.network(
              'assets/image/list.png',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            // listview แสดงข้อมูล task_tb form supabase
            Expanded(
              child: ListView.builder(
                // จำนวนรายการ
                itemCount: tasks.length,
                // หน้าตาแต่ละรายการ
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 20,
                      right: 20,
                    ),
                    child: ListTile(
                      onTap: () {},
                      leading: tasks[index].task_image_url! != ""
                          ? Image.network(
                              tasks[index].task_image_url!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              '<a href="https://www.flaticon.com/free-icons/list" title="list icons">List icons created by Freepik - Flaticon</a>',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                      title: Text(
                        'งาน: ${tasks[index].task_name!}',
                      ),
                      subtitle: Text(
                        'สถานะ : ${tasks[index].task_status == true ? 'เสร็จแล้ว' : 'ยังไม่เสร็จ'}',
                      ),
                      trailing: Icon(
                        Icons.info,
                        color: const Color.fromARGB(255, 245, 29, 29),
                        size: 20,
                      ),
                      tileColor: index % 2 == 0
                          ? Colors.greenAccent.withOpacity(0.5)
                          : const Color.fromARGB(255, 214, 209, 209),
                      contentPadding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
