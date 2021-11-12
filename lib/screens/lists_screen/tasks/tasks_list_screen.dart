import 'package:flutter/material.dart';
import 'package:gigi_notes/components/task_tile.dart';
import 'package:gigi_notes/models/task_manager.dart';
import 'package:gigi_notes/screens/item_screen/tasks/task_item_screen.dart';

class TasksListScreen extends StatelessWidget {
  final TaskManager manager;
  const TasksListScreen({Key? key, required this.manager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskItems = manager.taskItems;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListView.separated(
        itemCount: taskItems.length,
        itemBuilder: (context, index) {
          final item = taskItems[index];

          return Dismissible(
            key: Key(item.cTaskId.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(Icons.delete_forever, color: Colors.white, size: 25),
            ),
            onDismissed: (direction) {
              manager.deleteItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item.title} dismissed')),
              );
            },
            child: InkWell(
              child: TaskTile(
                key: Key(item.cTaskId.toString()),
                item: item,
                onComplete: (change) {
                  if (change != null) {
                    manager.completeItem(index, change);
                  }
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaskItemScreen(
                        manager: manager,
                        originalItem: item,
                        onCreate: (_) {},
                        onUpdate: (item) {
                          manager.updateItem(item, index);
                          Navigator.pop(context);
                        },
                      )),
                );
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 15);
        },
      ),
    );
  }
}
