import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_task_v1_app/models/task.dart';
import 'package:flutter_task_v1_app/services/supabase_services.dart';

class AddTaskUi extends StatefulWidget {
  const AddTaskUi({super.key});

  @override
  State<AddTaskUi> createState() => _AddTaskUiState();
}

class _AddTaskUiState extends State<AddTaskUi> {
  // ตัวควบคุม TextField และตัวแปรที่จะต้องเก็บข้อมูลที่ผู้ใช้ป้อน
  TextEditingController TaskNameCtrl = TextEditingController();
  TextEditingController TaskWhereCtrl = TextEditingController();
  TextEditingController TaskPersonCtrl = TextEditingController();
  bool taskStatus = false;
  TextEditingController TaskDueDateCtrl = TextEditingController();
  String taskImageUrl = '';

  //  ตัวแปรเก็บไฟล์ที่ใช้อัพโหลด task_bk
  File? file;

  //---- เปิดกลองถ่ายภาพ และกำหนดค่ารูปเพื่อ upload ----

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);

    if (picked != null) {
      setState(() {
        file = File(picked.path);
      });
    }
  }

  //-------------------------

  //---- เปิดปฏิทันเลือกวันที่ และกำหนดค่าวันที่ ----
  DateTime? selectedDate;

  Future<void> pickDate() async {
    // เปิดปฏิทันเลือกวันที่
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    // เอาค่าที่เลือกไปกำหนด TaskDueDateCtrl
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        TaskDueDateCtrl.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
  //-------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(
          'Task Krubb - Add',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 40,
            left: 50,
            right: 50,
            bottom: 40,
          ),
          child: Center(
            child: Column(
              children: [
                // ส่วนแสดงรูปและรูปกล้องเพื่อเปิดกล้อง
                file == null
                    ? InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: Icon(
                          Icons.add_a_photo_rounded,
                          size: 150,
                          color: Colors.grey[300],
                        ),
                      )
                    : Image.file(
                        file!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                SizedBox(height: 20),
                // ป้อนทำอะไร
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ทำอะไร',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                TextField(
                  controller: TaskNameCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'เช่น ซักผ้า, ซ่อมหลอดไฟ',
                  ),
                ),
                SizedBox(height: 20),
                // ป้อนทำที่ไหน
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ทำที่ไหน',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                TextField(
                  controller: TaskWhereCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'เช่น บ้าน, ที่ทำงาน',
                  ),
                ),
                SizedBox(height: 20),
                // ป้อนทำกันกี่คน
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ทำกันกี่คน',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                TextField(
                  controller: TaskPersonCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'เช่น 2, 5',
                  ),
                ),
                SizedBox(height: 20),
                // เลือกทำเสร็จหรือยัง
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ทำเสร็จหรือยัง',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          taskStatus = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: taskStatus == true
                            ? Colors.greenAccent.withOpacity(0.5)
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.4,
                          50,
                        ),
                      ),
                      child: Text(
                        'เสร็จแล้ว',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          taskStatus = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: taskStatus == false
                            ? const Color.fromARGB(255, 240, 105, 105)
                                .withOpacity(0.5)
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.35,
                          50,
                        ),
                      ),
                      child: Text(
                        'ยังไม่เสร็จ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // เลือกต้องเสร็จเมื่อไหร่
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'เสร็จเมื่อไหร่',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                TextField(
                  controller: TaskDueDateCtrl,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'เช่น 2020-01-31',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () {},
                ),
                SizedBox(height: 20),
                // ปุ่มบันทึก
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      50,
                    ),
                  ),
                  child: Text(
                    "บันทึก",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // ปุ่มยกเลิก
                ElevatedButton(
                  onPressed: () {
                    // เคลียร์หน้าจอ ข้อมูลท้างหมดหมดที่เลือก
                    setState(() {
                      TaskNameCtrl.clear();
                      TaskWhereCtrl.clear();
                      TaskPersonCtrl.clear();
                      TaskDueDateCtrl.clear();
                      file = null;
                      taskStatus = false;
                      taskImageUrl = '';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 240, 105, 105)
                        .withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      50,
                    ),
                  ),
                  child: Text(
                    "ยกเลิก",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
