// // tody is task lists

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../DB/DB.dart';
import '../screens/tasks_detail.dart';
import '../models/task_model.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  void removeItem(TaskModel taskModel) async {
    await taskModel.delete();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<TaskModel>>(
      valueListenable: Utils.database().listenable(),
      builder: (context, box, _) {
        // Gather today's tasks
        final data = box.values
            .toList()
            .cast<TaskModel>()
            .where(
              (task) => DateFormat.yMMMd().format(task.dateTime).contains(
            DateFormat.yMMMd().format(DateTime.now()),
          ),
        ).toList();

        return data.isEmpty
            ? const Center(
          child: Text('No task for today!'),
        )
            : Container(
          height: 250,  // Fixed height for the scrolling area
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(data.length, (index) {
                return Container(
                  width: 200, // Fixed width for each task card
                  margin: const EdgeInsets.only(right: 10), // Spacing between cards
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white54,
                        spreadRadius: 1,
                        offset: Offset(0, 6),
                        blurRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => TaskDetailsView(
                        taskmodel: data[index],
                      ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index].title[0].toUpperCase() +
                              data[index].title.substring(1),
                          softWrap: true,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Gap(10),
                        Text(
                          data[index].desc[0].toUpperCase() +
                              data[index].desc.substring(1),
                          softWrap: true,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const Gap(10),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}