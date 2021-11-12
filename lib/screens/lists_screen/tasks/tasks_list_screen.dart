import 'package:flutter/material.dart';
import 'package:gigi_notes/components/task_tile.dart';
import 'package:gigi_notes/data/repository.dart';
import 'package:gigi_notes/models/task_item.dart';
import 'package:gigi_notes/models/task_manager.dart';
import 'package:gigi_notes/screens/empty_screen/empty_task_screen.dart';
import 'package:gigi_notes/screens/item_screen/tasks/task_item_screen.dart';
import 'package:provider/provider.dart';

class TasksListScreen extends StatefulWidget {
  final TaskManager manager;
  const TasksListScreen({Key? key, required this.manager}) : super(key: key);

  @override
  State<TasksListScreen> createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);

    return StreamBuilder<List<TaskItem>>(
      stream: repository.watchAllTasks(),
      builder: (context, AsyncSnapshot<List<TaskItem>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final taskItems = snapshot.data ?? [];

          return Padding(
            padding: const EdgeInsets.all(5),
            child: ListView.separated(
              itemCount: taskItems.length,
              itemBuilder: (context, index) {
                final item = taskItems[index];

                return Dismissible(
                  key: Key(item.cTaskId.toString()),
                  direction: DismissDirection.endToStart,
                  background: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.delete_forever, color: Colors.white, size: 25),
                    ),
                  ),
                  onDismissed: (direction) {
                    widget.manager.deleteItem(index);
                    deleteNote(repository, item);
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
                          widget.manager.completeItem(index, change);
                        }
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TaskItemScreen(
                              manager: widget.manager,
                              originalItem: item,
                              onCreate: (_) {},
                              onUpdate: (item) {
                                widget.manager.updateItem(item, index);
                                repository.updateTask(item);
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
        } else {
          return const EmptyTaskScreen();
        }
      },
    );
  }

  void deleteNote(Repository repository, TaskItem taskItem) async {
    if (taskItem.cTaskId != null) {
      repository.deleteTask(taskItem);

      setState(() {});
    } else {
      // ignore: avoid_print
      print('Note id is null');
    }
  }
}
