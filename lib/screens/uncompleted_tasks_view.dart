import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../DB/DB.dart';
import '../models/task_model.dart';
import '../screens/tasks_detail.dart';

class UncompleteView extends StatefulWidget {
  const UncompleteView({super.key});

  @override
  State<UncompleteView> createState() => _UncompleteView();
}

class _UncompleteView extends State<UncompleteView> {
  final colorList = Utils.colorList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uncompleted Tasks'),
      ),
      body: ValueListenableBuilder<Box<TaskModel>>(
        valueListenable: Utils.database().listenable(),
        builder: (context, box, child) {
          final allTasks = box.values.toList().cast<TaskModel>();

          // Filter to get tasks that are not completed and not expired
          final uncompletedTasks = allTasks.where((task) =>
          !task.isChecked &&
              task.dateTime.isAfter(DateTime.now().toLocal())).toList();

          return uncompletedTasks.isEmpty
              ? const Center(
            child: Text('No Uncompleted Tasks!'),
          )
              : ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            itemCount: uncompletedTasks.length,
            itemBuilder: (context, index) {
              final colorIndex = index % colorList.length;
              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                child: ListTile(
                  onTap: () {
                    Get.to(
                          () => TaskDetailsView(
                        taskmodel: uncompletedTasks[index],
                      ),
                    );
                  },
                  leading: Container(
                    height: double.infinity,
                    width: 10,
                    decoration: BoxDecoration(
                      color: colorList[colorIndex],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  title: Text(
                    uncompletedTasks[index].title[0].toUpperCase() +
                        uncompletedTasks[index].title.substring(1),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    uncompletedTasks[index].desc[0].toUpperCase() +
                        uncompletedTasks[index].desc.substring(1),
                    style: const TextStyle(),
                    maxLines: 1, // Limit to one line
                    overflow: TextOverflow.ellipsis, // Add ellipses for overflow
                  ),
                  trailing: Text(
                    DateFormat.yMMMd().format(uncompletedTasks[index].dateTime),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
