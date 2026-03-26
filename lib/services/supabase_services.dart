// ใช้ทำงานต่างๆกับ supabase เช่น การดึงข้อมูล การเพิ่มข้อมูล การลบข้อมูล เป็นต้น
// CRUD กับ Table database ต่างๆบน supabase (PostgreSQL)
// การอ uplode, delete กับ bucket ที่อยู่ใน supabase

import 'dart:io';

import 'package:flutter_task_v1_app/models/task.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  // สร้าง instance/object/ ตัวแทนของ supabase เพื่อใช้งานในคลาสนี้
  final supabase = Supabase.instance.client;

  // สร้าง method สำหรับดึงข้อมูลจาก table ต่างๆบน supabase
  // ดึงข้อมูลทั้งหมดจาก task_tb --- return ค่าข้อมูลที่ดึงไปใช้งาน
  Future<List<Task>> getTasks() async {
    //ดึงข้อมูลจาก task_tb
    final data = await supabase.from('task_tb').select('*');
    //return ค่าข้อมูลที่ดึงไปใช้งาน
    return data.map((task) => Task.fromJson(task)).toList();
  }

  // เมธอดอัพโหลดไฟล์ไปยัง task_bk และ return ค่าข้อมูลที่อยู่รูปที่ได้จากการอัพโหลดและใช้งาน
  Future<String?> uplodeFile(File file) async {
    // สร้างชื่อ file ให้เพื่อไม่ให้ file ซ้ำกัน ง่ายสุดให้ชื่อ file เจนจากวันและเวลา
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';

    // อัพโหลดไฟล์ไปยัง task_bk
    await supabase.storage.from('task_bk').upload(fileName, file);

    // return ค่าข้อมูลที่อยู่รูปที่ได้จากการอัพโหลดและใช้งาน ที่อยู่ของรูปคือ image !Url!
    return supabase.storage.from('task_bk').getPublicUrl(fileName);
  }

  // เมธอดเพิ่มไฟล์จาก task_bk
  Future insertTask(Task task) async {
    // เพิ่มข้อมูลไปยัง task_bk
    await supabase.from('task_tb').insert(task.toJson());
  }

  // เมธอดลบไฟล์ที่อัพโหลดไปยัง task_bk

  // เมธอดแก้ไขข้อมูลจาก task_bk

  // เมธอดลบข้อมูลจาก task_bk
}
