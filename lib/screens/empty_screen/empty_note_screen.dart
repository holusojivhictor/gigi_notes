import 'package:flutter/material.dart';
import 'package:gigi_notes/constants.dart';

class EmptyNoteScreen extends StatelessWidget {
  const EmptyNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kPadding * 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/edit.png', color: Theme.of(context).indicatorColor, scale: 1.5),
          const Center(
            child: Text('No Notes'),
          ),
        ],
      ),
    );
  }
}
