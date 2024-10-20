// //Home Page
// //
// // import 'package:flutter/material.dart';
// // import 'package:gap/gap.dart';
// // import 'package:get/get.dart';
// // import 'package:hive_flutter/hive_flutter.dart';
// // import 'package:intl/intl.dart';
// // import 'package:task_mangement_hive/screens/All_tasks.dart';
// // import '../DB/DB.dart';
// // import '../DB/task_catagories.dart';
// // import '../screens/add_task.dart';
// // import '../models/task_model.dart';
// // import 'Home_page_top.dart';
// // import 'Today_taskList.dart';
// //
// // class HomeView extends StatefulWidget {
// //   const HomeView({super.key});
// //
// //   @override
// //   State<HomeView> createState() => _HomeViewState();
// // }
// //
// // class _HomeViewState extends State<HomeView> {
// //   void showSheet() async {
// //     await showModalBottomSheet(
// //       isScrollControlled: true,
// //       context: context,
// //       builder: (context) => const Sheet(),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: ValueListenableBuilder(
// //           valueListenable: Utils.database().listenable(),
// //           builder: (context, box, child) {
// //             final todayTask = box.values
// //                 .toList()
// //                 .cast<TaskModel>()
// //                 .where(
// //                   (task) => DateFormat.yMMMd().format(task.dateTime).contains(
// //                 DateFormat.yMMMd().format(
// //                   DateTime.now(),
// //                 ),
// //               ),
// //             )
// //                 .toList();
// //             return Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const TopSession(),
// //                 Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           const TaskCategory(),
// //                           const Gap(10),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Text(
// //                                 '${todayTask.length} Task for today',
// //                                 style: const TextStyle(
// //                                   color: Colors.black,
// //                                   fontWeight: FontWeight.w500,
// //                                   fontSize: 20,
// //                                 ),
// //                               ),
// //                               TextButton(
// //                                 onPressed: () {
// //                                   Get.to(() => const AllTasks());
// //                                 },
// //                                 child: const Text(
// //                                   'See all',
// //                                   style: TextStyle(
// //                                       color: Colors.black,
// //                                       fontSize: 12,
// //                                       fontWeight: FontWeight.bold),
// //                                 ),
// //                               )
// //                             ],
// //                           ),
// //                           const Gap(15),
// //                           const SizedBox(
// //                             height: 225,
// //                             child: TaskList(),
// //                           ),
// //                           const Gap(10),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             );
// //           },
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: showSheet,
// //         child: const Icon(Icons.add),
// //       ),
// //     );
// //   }
// // }



import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart'; // Make sure to import intl for DateFormat
import 'package:get/get.dart'; // Assuming you're using GetX for navigation
import '../DB/DB.dart';
import '../DB/task_catagories.dart';
import '../models/task_model.dart';
import '../screens/All_tasks.dart';
import '../screens/add_task.dart';
import 'Drawer_widget.dart';
import 'Home_page_top.dart';
import 'Today_taskList.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void showSheet() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const Sheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home'),
      // ),
      drawer: DrawerWidget(), // Your custom drawer widget
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Utils.database().listenable(),
          builder: (context, box, child) {
            final todayTask = box.values
                .toList()
                .cast<TaskModel>()
                .where(
                  (task) =>
                  DateFormat.yMMMd().format(task.dateTime).contains(
                    DateFormat.yMMMd().format(
                      DateTime.now(),
                    ),
                  ),
            )
                .toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopSession(
                  onDrawerOpen: () {
                    Scaffold.of(context).openDrawer(); // Open the drawer
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TaskCategory(),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${todayTask.length} Task for today',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const AllTasks());
                            },
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Gap(15),
                      const SizedBox(
                        height: 225,
                        child: TaskList(),
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
