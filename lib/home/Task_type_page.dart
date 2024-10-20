import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/Add_task_type.dart';

class TaskTypesPage extends StatefulWidget {
  @override
  _TaskTypesPageState createState() => _TaskTypesPageState();
}

class _TaskTypesPageState extends State<TaskTypesPage> {
  List<String> types = [];
  final colorList = [Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.purple]; // Define your color list here

  @override
  void initState() {
    super.initState();
    loadTypes();
  }

  Future<void> loadTypes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      types = prefs.getStringList('taskTypes') ?? [];
    });
  }

  void deleteType(String typeToDelete) {
    if (typeToDelete == 'Other') return; // Prevent deletion of 'Other'

    setState(() {
      types.remove(typeToDelete);
      saveTypes();
    });
  }

  Future<void> saveTypes() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('taskTypes', types);
  }

  void navigateToAddTypeTask() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTypeTask(onAdd: (newType) {
        setState(() {
          types.add(newType);
          saveTypes();
        });
      })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Types'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: types.where((type) => type != 'Other' && type != 'Important' && type != 'Daily').length,
        itemBuilder: (context, index) {
          final taskType = types.where((type) => type != 'Other' && type != 'Important' && type != 'Daily').toList()[index];
          final colorIndex = index % colorList.length; // Color cycling

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: Container(
                height: double.infinity,
                width: 10,
                decoration: BoxDecoration(
                  color: colorList[colorIndex],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              title: Text(
                taskType[0].toUpperCase() + taskType.substring(1),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteType(taskType),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddTypeTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
