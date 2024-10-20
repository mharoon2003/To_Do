import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_mangement_hive/models/task_model.dart';
import 'package:task_mangement_hive/models/uncompleted_model.dart';
import 'home/Home_Page.dart';
import 'login_signup/Splash.dart';
import 'models/completed_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(DonemodelAdapter());
  Hive.registerAdapter(UncompleteModelAdapter());
  await Hive.openBox<TaskModel>('TaskleyDB');
  await Hive.openBox<Donemodel>('DoneTask');
  await Hive.openBox<UncompleteModel>('UncompleteTask');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
