import 'dart:convert';

class NoteItem {
  String? cNoteId;
  final String title;
  final String noteText;
  final String dateTime;
  DateTime? date;
  final bool isComplete;

  NoteItem({
    this.cNoteId,
    required this.title,
    required this.noteText,
    required this.dateTime,
    this.date,
    this.isComplete = false,
  });

  NoteItem copyWith({
    String? cNoteId,
    String? title,
    String? noteText,
    String? dateTime,
    DateTime? date,
    bool? isComplete,
  }) {
    return NoteItem(
      cNoteId: cNoteId ?? this.cNoteId,
      title: title ?? this.title,
      noteText: noteText ?? this.noteText,
      dateTime: dateTime ?? this.dateTime,
      date: date ?? this.date,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  factory NoteItem.fromMap(Map<String, dynamic> json) => NoteItem(
    cNoteId: json['cNoteId'],
    title: json['title'],
    noteText: json['noteText'],
    dateTime: json['dateTime'],
  );

  static Map<String, dynamic> toMap(NoteItem noteItem) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cNoteId'] = noteItem.cNoteId;
    data['title'] = noteItem.title;
    data['noteText'] = noteItem.noteText;
    data['dateTime'] = noteItem.dateTime;

    return data;
  }

  static String encode(List<NoteItem> noteItems) => json.encode(
    noteItems.map<Map<String, dynamic>>((noteItem) => NoteItem.toMap(noteItem)).toList(),
  );

  static List<NoteItem> decode(String noteItems) => (json.decode(noteItems) as List<dynamic>).map<NoteItem>((item) => NoteItem.fromMap(item)).toList();
}