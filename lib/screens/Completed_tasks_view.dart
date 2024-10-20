import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../DB/DB.dart';
import '../models/completed_model.dart';

class Doneview extends StatefulWidget {
  const Doneview({super.key});

  @override
  State<Doneview> createState() => _DoneviewState();
}

class _DoneviewState extends State<Doneview> {
  final colorList = Utils.colorList;

  void deleteTask(int index) async {
    final box = Utils.doneTask();
    await box.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
      ),
      body: ValueListenableBuilder<Box<Donemodel>>(
        valueListenable: Utils.doneTask().listenable(),
        builder: (context, box, child) {
          final data = box.values.toList().cast<Donemodel>();
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final colorIndex = index % colorList.length;
              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                child: ListTile(
                  tileColor: Colors.greenAccent.withOpacity(.25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  leading: Container(
                    height: double.infinity,
                    width: 10,
                    decoration: BoxDecoration(
                      color: colorList[colorIndex],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  title: Text(
                    data[index].title[0].toUpperCase() +
                        data[index].title.substring(1),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          data[index].desc[0].toUpperCase() +
                              data[index].desc.substring(1),
                          style: const TextStyle(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        data[index].type[0].toUpperCase() +
                            data[index].type.substring(1).toLowerCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat.yMMMd().format(data[index].dateTime),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          deleteTask(index); // Call the delete function
                        },
                      ),
                    ],
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
