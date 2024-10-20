// the tasks near to deadlilne


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:task_mangement_hive/screens/tasks_detail.dart';
import '../DB/DB.dart';
import '../models/task_model.dart';



class AlertView extends StatefulWidget {
  const AlertView({super.key});

  @override
  State<AlertView> createState() => _AlertViewState();
}

class _AlertViewState extends State<AlertView> {
  final colorList = Utils.colorList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expired date tasks'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Utils.database().listenable(),
        builder: (context, box, child) {
          final items = box.values
              .toList()
              .cast<TaskModel>()
              .where((task) => task.dateTime.isBefore(
              DateTime.now().toLocal().subtract(const Duration(days: 1))))
              .toList();
          return items.isEmpty
              ? const Center(
            child: Text('You have all your tasks well done 😊'),
          )
              : ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final colorIndex = index % colorList.length;
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    onTap: () {
                      Get.to(
                            () => TaskDetailsView(
                          taskmodel: items[index],
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    tileColor: Theme.of(context).colorScheme.primary,
                    leading: Container(
                      height: double.infinity,
                      width: 10,
                      decoration: BoxDecoration(
                        color: colorList[colorIndex],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    title: Text(
                      items[index].title[0].toUpperCase() +
                          items[index].title.substring(1),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      items[index].desc[0].toUpperCase() +
                          items[index].desc.substring(1),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: 1, // Limit to one line
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      DateFormat.yMMMd().format(items[index].dateTime),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
