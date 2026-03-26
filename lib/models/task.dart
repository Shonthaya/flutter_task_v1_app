// ไฟล์สำรองข้มสอเก็บอustin ข้อมูง table ทีเราถษทำานด้าน
class Task {
  //ศวนประทนแปนทีลือน้อยดอกัnaบuscrin table
  String? id;
  String? task_name;
  String? task_where;
  int? task_person;
  bool? task_status;
  String? task_duedate;
  String? task_image_url;

  //constructor เพห่นเน่นการเพท้จ์อunก
  Task({
    this.id,
    this.task_name,
    this.task_where,
    this.task_person,
    this.task_status,
    this.task_duedate,
    this.task_image_url,
  });

  //แปลง่อมูลจาก Server/Cloud ซึ่งเป็น JSON นำเป็นอมูงทีง้ใไง้แนบใน (fromJson)
  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        task_name: json['task_name'],
        task_where: json['task_where'],
        task_person: json['task_person'],
        task_status: json['task_status'],
        task_duedate: json['task_duedate'],
        task_image_url: json['task_image_url'],
      );

  //แปลงอมูลจาก็นแปปIsเป็น JSON เพศ่อส่ปะปy Server/Cloud (toJson)
  Map<String, dynamic> toJson() => {
        'task_name': task_name,
        'task_where': task_where,
        'task_person': task_person,
        'task_status': task_status,
        'task_duedate': task_duedate,
        'task_image_url': task_image_url,
      };
}
