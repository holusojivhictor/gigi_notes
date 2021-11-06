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

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cNoteId'] = this.cNoteId;
    data['title'] = this.title;
    data['noteText'] = this.noteText;
    data['dateTime'] = this.dateTime;

    return data;
  }
}