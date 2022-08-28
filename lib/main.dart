import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification_app/db/db.dart';
import 'package:notification_app/ui/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HelperDb.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Notifiction Demo',
      home: HomePage(),
    );
  }
}
