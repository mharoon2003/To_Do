import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../DB/DB.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';
import 'Add_task_type.dart';

class Sheet extends StatefulWidget {
  const Sheet({super.key});

  @override
  State<Sheet> createState() => _SheetState();
}

class _SheetState extends State<Sheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  List<String> types = ['Daily', 'Fun', 'Development', 'Decision', 'important', 'Other'];
  String _dropValue = 'Daily';
  DateTime? selectedDate;
  var formattedDate = '';

  @override
  void initState() {
    super.initState();
    loadTypes(); // Load task types on initialization
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }

  Future<void> loadTypes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      types = prefs.getStringList('taskTypes') ?? ['Daily', 'Fun', 'Development', 'Decision', 'Important', 'Other'];
    });
  }

  Future<void> saveData() async {
    final data = TaskModel(
      title: _titleController.text,
      desc: _descController.text,
      dateTime: selectedDate!,
      type: _dropValue,
    );
    final box = Utils.database();
    box.add(data);
    data.save();
    Get.back();
  }

  void addCustomType(String newType) {
    setState(() {
      types.insert(types.length - 1, newType); // Insert before 'Other'
      _dropValue = newType; // Set the new type as selected
      saveTypes(); // Save to shared preferences
    });
  }

  Future<void> saveTypes() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('taskTypes', types);
  }

  void pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      final formatted = DateFormat.yMMMd().format(pickedDate);
      setState(() {
        selectedDate = pickedDate;
        formattedDate = formatted;
      });
    }
  }

  // Define the deleteType method
  void deleteType(String typeToDelete) {
    if (typeToDelete == 'Other') {
      // Do not allow deletion of 'Other'
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Task Type'),
          content: Text('Do you want to delete the task type "$typeToDelete"?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  types.remove(typeToDelete);
                  if (_dropValue == typeToDelete) {
                    _dropValue = types.first; // Reset dropdown value if deleted
                  }
                  saveTypes(); // Save to shared preferences
                });
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title cannot be empty';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const Gap(10),
              TextFormField(
                controller: _descController,
                maxLines: 5,
                maxLength: 60,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter some description😊';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const Gap(10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: pickDate,
                      icon: const Icon(Icons.arrow_drop_down),
                      label: formattedDate.isEmpty
                          ? const Text('Select Date')
                          : Text(formattedDate),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: DropdownButton<String>(
                      value: _dropValue,
                      borderRadius: BorderRadius.circular(20),
                      elevation: 0,
                      isExpanded: true,
                      items: types
                          .map((String e) => DropdownMenuItem<String>(
                        value: e,
                        child: GestureDetector(
                          onLongPress: () => deleteType(e), // Long press to delete
                          child: Text(e),
                        ),
                      ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropValue = newValue!;
                          if (_dropValue == 'Other') {
                            Get.to(AddTypeTask(onAdd: addCustomType));
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel'),
                  ),
                  const Gap(10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && selectedDate != null) {
                        saveData();
                      }
                    },
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//
//
// class Sheet extends StatefulWidget {
//   const Sheet({super.key});
//
//   @override
//   State<Sheet> createState() => _SheetState();
// }
//
// class _SheetState extends State<Sheet> {
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _descController = TextEditingController();
//
//   List<String> types = ['Daily', 'Fun', 'Development', 'Decision','important','other'];
//   String _dropValue = 'Daily';
//   DateTime? selectedDate;
//   var formattedDate = '';
//
//   @override
//   void dispose() {
//     super.dispose();
//     _titleController.dispose();
//     _descController.dispose();
//   }
//
//   void pickDate() async {
//     final pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2030),
//     );
//     final formatted = DateFormat.yMMMd().format(pickedDate!);
//     setState(() {
//       selectedDate = pickedDate;
//       formattedDate = formatted;
//     });
//   }
//
//   void saveData() {
//     final data = TaskModel(
//       title: _titleController.text,
//       desc: _descController.text,
//       dateTime: selectedDate!,
//       type: _dropValue,
//     );
//     final box = Utils.database();
//     box.add(data);
//     data.save();
//     Get.back();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _titleController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Title can not be empty';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   labelText: 'Title',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const Gap(10),
//               TextFormField(
//                 controller: _descController,
//                 maxLines: 5,
//                 maxLength: 60,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Enter some description😊';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   labelText: 'Description',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const Gap(10),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: pickDate,
//                       icon: const Icon(Icons.arrow_drop_down),
//                       label: formattedDate.isEmpty
//                           ? const Text(
//                         'Select Date',
//                       )
//                           : Text(
//                         formattedDate,
//                       ),
//                     ),
//                   ),
//                   const Gap(10),
//                   Expanded(
//                     child: DropdownButton<String>(
//                       value: _dropValue,
//                       borderRadius: BorderRadius.circular(20),
//                       elevation: 0,
//                       isExpanded: true,
//                       items: types
//                           .map(
//                             (String e) => DropdownMenuItem<String>(
//                           value: e,
//                           child: Text(e),
//                         ),
//                       )
//                           .toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _dropValue = newValue!;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const Gap(10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     child: const Text('Cancel'),
//                   ),
//                   const Gap(10),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                       Theme.of(context).colorScheme.primaryContainer,
//                     ),
//                     onPressed: () {
//                       if (_formKey.currentState!.validate() &&
//                           selectedDate != null) {
//                         saveData();
//                       }
//                       return;
//                     },
//                     child: Text(
//                       'Add task',
//                       style: TextStyle(
//                         color: Theme.of(context).colorScheme.onPrimaryContainer,
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
