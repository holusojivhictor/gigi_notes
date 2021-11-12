import 'package:flutter/material.dart';
import 'package:gigi_notes/data/repository.dart';
import 'package:gigi_notes/models/task_item.dart';
import 'package:gigi_notes/models/task_manager.dart';
import 'package:gigi_notes/screens/empty_screen/empty_task_screen.dart';
import 'package:gigi_notes/screens/lists_screen/tasks/tasks_list_screen.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);

    return StreamBuilder<List<TaskItem>>(
      stream: repository.watchAllTasks(),
      builder: (context, AsyncSnapshot<List<TaskItem>> snapshot) {
        final taskItems = snapshot.data ?? [];

        if (taskItems.isNotEmpty) {
          return Consumer<TaskManager>(
            builder: (context, manager, child) {
              return TasksListScreen(manager: manager);
            },
          );
        } else {
          return const EmptyTaskScreen();
        }
      }
    );
  }
}
