import 'package:flutter/material.dart';

class AddTypeTask extends StatefulWidget {
  final Function(String) onAdd;

  const AddTypeTask({Key? key, required this.onAdd}) : super(key: key);

  @override
  _AddTypeTaskState createState() => _AddTypeTaskState();
}

class _AddTypeTaskState extends State<AddTypeTask> {
  final TextEditingController _typeController = TextEditingController();
  Icon? selectedIcon;

  @override
  void dispose() {
    _typeController.dispose();
    super.dispose();
  }

  void saveType() {
    final newType = _typeController.text.trim();
    if (newType.isNotEmpty && selectedIcon != null) {
      widget.onAdd(newType);
      Navigator.pop(context);
    }
  }

  void selectIcon(Icon icon) {
    setState(() {
      selectedIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task Type'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _typeController,
              decoration: InputDecoration(
                labelText: 'Task Type Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text('Select an Icon:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.star),
                  onPressed: () =>
                      setState(() {
                        selectIcon(Icon(Icons.star));
                        color: selectedIcon == Icon(Icons.star) ? Colors.blue : Colors.grey;
                      }),

                ),
                IconButton(
                  icon: Icon(Icons.check_circle),
                  onPressed: () => selectIcon(Icon(Icons.check_circle)),
                  color: selectedIcon == Icon(Icons.check_circle) ? Colors.blue : Colors.grey,
                ),
                IconButton(
                  icon: Icon(Icons.work),
                  onPressed: () => selectIcon(Icon(Icons.work)),
                  color: selectedIcon == Icon(Icons.work) ? Colors.blue : Colors.grey,
                ),
                // Add more icons as needed
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: saveType,
              child: Text('Save Type'),
            ),
          ],
        ),
      ),
    );
  }
}
