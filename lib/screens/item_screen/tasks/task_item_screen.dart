import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gigi_notes/data/repository.dart';
import 'package:gigi_notes/models/task_item.dart';
import 'package:gigi_notes/models/task_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TaskItemScreen extends StatefulWidget {
  final Function(TaskItem) onCreate;
  final Function(TaskItem) onUpdate;
  final TaskItem? originalItem;
  final bool isUpdating;
  final TaskManager manager;

  const TaskItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
    required this.manager,
  }) : isUpdating = (originalItem != null), super(key: key);

  @override
  _TaskItemScreenState createState() => _TaskItemScreenState();
}

class _TaskItemScreenState extends State<TaskItemScreen> {
  final _titleController = TextEditingController();
  final _taskDesController = TextEditingController();
  Importance _category = Importance.later;
  DateTime _editDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  TimeOfDay _timeOfDayEnd = TimeOfDay.now();

  @override
  void initState() {
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _titleController.text = originalItem.title;
      _taskDesController.text = originalItem.taskDescription;
      _category = originalItem.category;
    }

    widget.manager.getOldTasks();

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _taskDesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Task",
          style: Theme.of(context).textTheme.headline2,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(height: 0.3, color: Theme.of(context).dividerColor),
              buildTabName('Task title'),
              buildTitleField(),
              const SizedBox(height: 10),
              buildTabName('Priority'),
              buildImportanceField(),
              const SizedBox(height: 10),
              buildTabName('Date'),
              buildDateContainer(context),
              const SizedBox(height: 10),
              buildTimeContainers(context),
              const SizedBox(height: 10),
              buildTabName('Description'),
              buildDescriptionField(),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      final genDateTime = DateTime(
                        _editDate.year,
                        _editDate.month,
                        _editDate.day,
                        _timeOfDay.hour,
                        _timeOfDay.minute,
                      );

                      final taskItem = TaskItem(
                        cTaskId: widget.originalItem?.cTaskId ?? const Uuid().v1(),
                        title: _titleController.text,
                        taskDescription: _taskDesController.text,
                        category: _category,
                        dateTime: genDateTime.toIso8601String(),
                      );

                      if (widget.isUpdating) {
                        widget.onUpdate(taskItem);
                        repository.updateTask(taskItem);
                      } else {
                        widget.onCreate(taskItem);
                        repository.insertTask(taskItem);
                      }
                      widget.manager.addItem(taskItem);
                      widget.manager.saveOldTasks();

                    },
                    child: Text('Create task', style: TextStyle(color: Theme.of(context).canvasColor)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget buildTabName(String name) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
    );
  }

  Widget buildTitleField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: _titleController,
        cursorHeight: 18,
        cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
        style: Theme.of(context).textTheme.headline4,
        decoration: InputDecoration(
          hintText: 'Title',
          contentPadding: const EdgeInsets.symmetric(vertical: 15 ,horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).indicatorColor),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).indicatorColor),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).indicatorColor),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }

  Widget buildImportanceField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SizedBox(
        height: 55,
        width: double.infinity,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Wrap(
              spacing: 20.0,
              children: [
                ChoiceChip(
                  selected: _category == Importance.later,
                  label: const Text('LATER'),
                  onSelected: (selected) {
                    setState(() {
                      _category = Importance.later;
                    });
                  },
                ),
                ChoiceChip(
                  selected: _category == Importance.ongoing,
                  label: const Text('ONGOING'),
                  onSelected: (selected) {
                    setState(() {
                      _category = Importance.ongoing;
                    });
                  },
                ),
                ChoiceChip(
                  selected: _category == Importance.running,
                  label: const Text('RUNNING'),
                  onSelected: (selected) {
                    setState(() {
                      _category = Importance.running;
                    });
                  },
                ),
                ChoiceChip(
                  selected: _category == Importance.urgent,
                  label: const Text('URGENT'),
                  onSelected: (selected) {
                    setState(() {
                      _category = Importance.urgent;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDateContainer(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            height: 40,
            width: size.width * 0.95,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Theme.of(context).indicatorColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(DateFormat('yyyy-MM-dd').format(_editDate)),
                  GestureDetector(
                    child: const Icon(Icons.date_range, size: 20),
                    onTap: () async {
                      final currentDate = DateTime.now();
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: currentDate,
                        firstDate: currentDate,
                        lastDate: DateTime(currentDate.year + 10),
                      );
                      setState(() {
                        if (selectedDate != null) {
                          _editDate = selectedDate;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimeContainers(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              buildTabName('Starts'),
              const SizedBox(height: 5),
              buildTimeBar(context),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              buildTabName('Ends'),
              const SizedBox(height: 5),
              buildTimeBarEnd(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTimeBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Theme.of(context).indicatorColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_timeOfDay.format(context)),
              GestureDetector(
                child: const Icon(Icons.access_time_filled, size: 18),
                onTap: () async {
                  final timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  setState(() {
                    if (timeOfDay != null) {
                      _timeOfDay = timeOfDay;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTimeBarEnd(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Theme.of(context).indicatorColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_timeOfDayEnd.format(context)),
              GestureDetector(
                child: const Icon(Icons.access_time_filled, size: 18),
                onTap: () async {
                  final timeOfDayEnd = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  setState(() {
                    if (timeOfDayEnd != null) {
                      _timeOfDayEnd = timeOfDayEnd;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDescriptionField() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SizedBox(
        height: 150,
        width: size.width * 0.95,
        child: TextField(
          maxLines: 20,
          controller: _taskDesController,
          cursorHeight: 18,
          cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
          style: Theme.of(context).textTheme.headline4,
          decoration: InputDecoration(
            hintText: 'Description',
            contentPadding: const EdgeInsets.symmetric(vertical: 15 ,horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).indicatorColor),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).indicatorColor),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).indicatorColor),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
    );
  }
}
