import 'package:flutter/material.dart';
import 'package:gigi_notes/constants.dart';

class EmptyTaskScreen extends StatelessWidget {
  const EmptyTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kPadding * 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.task, size: 40),
          SizedBox(height: 10),
          Center(
            child: Text('No Tasks'),
          ),
        ],
      ),
    );
  }
}
