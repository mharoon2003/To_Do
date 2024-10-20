

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:badges/badges.dart' as badges;
import 'package:task_mangement_hive/screens/All_tasks.dart';
import '../screens/Completed_tasks_view.dart';
import '../screens/Near_to_deadline.dart';
import '../screens/uncompleted_tasks_view.dart';
import '../models/task_model.dart';
import 'DB.dart';


class TaskCategory extends StatelessWidget {
  const TaskCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Utils.database().listenable(),
      builder: (context, box, child) {
        final items = box.values
            .toList()
            .cast<TaskModel>()
            .where((task) => task.dateTime.isBefore(
            DateTime.now().toLocal().subtract(const Duration(days: 1))))
            .toList();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => const AllTasks());
                      },
                      child: Container(
                        height: 75,
                        width: 75,
                        padding: EdgeInsets.fromLTRB(0, 4, 4, 4),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 27, 57, 111)
                              .withOpacity(.3),
                          border: Border.all(
                              color: const Color.fromARGB(255, 27, 57, 111)),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Lottie.asset(
                          'assets/todo.json',
                          width: 60,
                          repeat: false,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Gap(10),
                    const Text(
                      'all Tasks',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),

                SizedBox(width: 10,),

                Column(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.to(() => const AlertView());
                        },
                        child: badges.Badge(
                          badgeContent: Text(
                            items.isEmpty ? '0' : items.length.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          child: Container(
                            height: 75,
                            width: 75,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(.3),
                              border: Border.all(
                                color: Colors.redAccent,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Lottie.asset(
                              'assets/alert.json',
                              width: 70,
                              repeat: false,
                              height: 70,
                            ),
                          ),
                        )),
                    const Gap(10),
                    const Text(
                      'Expiered Tasks ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),

                SizedBox(width: 10,),


                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => const Doneview());
                      },
                      child: Container(
                        height: 75,
                        width: 75,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(.3),
                          border: Border.all(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Lottie.asset(
                          'assets/done.json',
                          width: 60,
                          repeat: false,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Gap(10),
                    const Text(
                      'Completed',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),

                SizedBox(width: 10,),


                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => const UncompleteView());
                      },
                      child: Container(
                        height: 75,
                        width: 75,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(.3),
                          border: Border.all(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Lottie.asset(
                          'assets/progress.json',
                          width: 60,
                          repeat: false,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Gap(10),
                    const Text(
                      'Uncompleted',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),



                SizedBox(width: 10,),

                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => const UncompleteView());//important
                      },
                      child: Container(
                        height: 75,
                        width:75,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(.3),
                          border: Border.all(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Lottie.asset(
                          'assets/progressss.json',
                          width: 60,
                          repeat: false,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Gap(10),
                    const Text(
                      'important',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
