import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/note_item.dart';

class NoteTile extends StatefulWidget {
  final NoteItem item;
  final Function(bool?)? onComplete;
  const NoteTile({Key? key, required this.item ,this.onComplete}) : super(key: key);

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 320,
          width: 200,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                  ),
                  elevation: 5,
                  color: Theme.of(context).cardColor,
                  shadowColor: Theme.of(context).shadowColor,
                  child: SizedBox(
                    height: 250,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        widget.item.noteText,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.item.title,
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                buildTime(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTime() {
    // final timeFormatter = DateTime.parse(widget.item.dateTime);
    // final timeString = DateFormat("yyyy-MM-dd HH:mm:ss").format(timeFormatter);
    return Text(widget.item.dateTime, style: const TextStyle(color: Colors.grey, fontSize: 14));
  }
}
