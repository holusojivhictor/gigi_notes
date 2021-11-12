import 'package:flutter/material.dart';
import 'package:gigi_notes/models/task_manager.dart';
import 'package:gigi_notes/screens/item_screen/tasks/task_item_screen.dart';
import 'package:gigi_notes/screens/tasks_screen/components/body.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: const Body(),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: const Icon(Icons.add),
        onPressed: () {
          final manager = Provider.of<TaskManager>(context, listen: false);
          Navigator.push(
            context,
              MaterialPageRoute(builder: (context) => TaskItemScreen(
                manager: manager,
                onCreate: (item) {
                  manager.addItem(item);
                  Navigator.pop(context);
                },
                onUpdate: (_) {},
              )),
          );
        },
      ),
    );
  }
}
