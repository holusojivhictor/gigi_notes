import 'package:flutter/material.dart';
import 'package:gigi_notes/components/contact.dart';
import 'package:gigi_notes/models/task_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  final TaskItem item;
  final Function(bool?)? onComplete;
  const TaskTile({Key? key, required this.item, this.onComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: Theme.of(context).indicatorColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildImportance(context),
                      const SizedBox(height: 8),
                      Divider(height: 1, color: Theme.of(context).indicatorColor),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              width: 5,
                              decoration: BoxDecoration(
                                color: Theme.of(context).splashColor,
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(item.title, style: Theme.of(context).textTheme.headline2),
                            const SizedBox(height: 6),
                            Text(item.taskDescription,
                              maxLines: 1,
                              style: GoogleFonts.lato(
                                fontSize: 17.0,
                                fontWeight:FontWeight.w500,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: PopupMenuButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.more_vert),
                          onSelected: (value) {
                            if (value == 'Share') {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ExtraPage()));
                            }
                          },
                          itemBuilder: (context) {
                            return List.generate(1, (index) {
                              return const PopupMenuItem(
                                key: Key('Share'),
                                value: 'Share',
                                child: Text('Share'),
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time_filled, size: 18),
                          const SizedBox(width: 8),
                          buildTime(),
                        ],
                      ),
                      buildDate(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildImportance(BuildContext context) {
    if (item.category == Importance.later) {
      return Text('LATER', style: Theme.of(context).textTheme.bodyText2);
    } else if (item.category == Importance.ongoing) {
      return Text('ONGOING', style: Theme.of(context).textTheme.bodyText2);
    } else if (item.category == Importance.running) {
      return Text('RUNNING', style: Theme.of(context).textTheme.bodyText2);
    } else if (item.category == Importance.urgent) {
      return Text('URGENT', style: Theme.of(context).textTheme.bodyText2);
    } else {
      throw Exception('This importance type does not exist');
    }
  }

  Widget buildTime() {
    final timeFormatter = DateTime.parse(item.dateTime);
    final timeString = DateFormat("HH:mm a").format(timeFormatter);
    return Text(timeString , style: const TextStyle(color: Colors.grey, fontSize: 14));
  }

  Widget buildDate() {
    final timeFormatter = DateTime.parse(item.dateTime);
    final timeString = DateFormat("yyyy-MM-dd").format(timeFormatter);
    return Text(timeString , style: const TextStyle(color: Colors.grey, fontSize: 14));
  }
}
