import 'package:flutter/material.dart';
import 'package:flutter_task_v1_app/views/splach_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //--------- ตั้งค่าการใช้งาน superbase ที่ต้องการใช่งานด้วย
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://fbwkoowhcrmzdlonstqu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZid2tvb3doY3JtemRsb25zdHF1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM4OTc3NTksImV4cCI6MjA4OTQ3Mzc1OX0.SSYb3gtJEV0vObBWOVKR9SbTAZWbQ5AzFIIG_Q8GdMo',
  );
  //---------

  runApp(
    FlutterTaskV1App(),
  );
}

//----------------------------------------

class FlutterTaskV1App extends StatefulWidget {
  const FlutterTaskV1App({super.key});

  @override
  State<FlutterTaskV1App> createState() => _FlutterTaskV1AppState();
}

class _FlutterTaskV1AppState extends State<FlutterTaskV1App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplachScreenUi(),
      theme: ThemeData(
        textTheme: GoogleFonts.promptTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
