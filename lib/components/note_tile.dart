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
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.38,
          width: size.width * 0.5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                    ),
                    elevation: 5,
                    color: Theme.of(context).cardColor,
                    shadowColor: Theme.of(context).shadowColor,
                    child: SizedBox(
                      height: size.height * 0.3,
                      width: size.width * 0.5,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          widget.item.noteText,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        widget.item.title,
                        style: GoogleFonts.lato(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      buildTime(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTime() {
    final timeFormatter = DateTime.parse(widget.item.dateTime);
    final timeString = DateFormat("HH:mm   yyyy-MM-dd").format(timeFormatter);
    return Text(timeString , style: const TextStyle(color: Colors.grey, fontSize: 14));
  }
}
