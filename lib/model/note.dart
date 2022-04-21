// https://www.youtube.com/watch?v=UpKrhZ0Hppk
final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    id,title,desc,time
  ];
  static final String id = '_id';
  static final String title = 'title';
  static final String desc = 'desc';
  static final String time = 'time';

}

class Note {
  final int? id;
  final String title;
  final String desc;
  final DateTime lastEdited;

  Note({
    this.id,
    required this.title,
    required this.desc,
    required this.lastEdited,
  });

  Note copy({
    int? id,
    String? title,
    String? desc,
    DateTime? createdTime
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        desc: desc ?? this.desc,
        lastEdited: createdTime ?? this.lastEdited,
      );

  Map<String, dynamic> toJson() => {
    NoteFields.id : id,
    NoteFields.title : title,
    NoteFields.desc : desc,
    NoteFields.time : lastEdited.toIso8601String(),
  };

  static Note fromJson(Map<String, Object?> json) =>  Note(
    id: json[NoteFields.id] as int?,
    title: json[NoteFields.title] as String,
    desc: json[NoteFields.desc] as String,
    lastEdited: DateTime.parse(json[NoteFields.time] as String)
  );

}
