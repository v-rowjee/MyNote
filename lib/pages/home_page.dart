import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mynote/model/note.dart';
import 'package:mynote/database/notes_database.dart';
import 'package:mynote/pages/detail_page.dart';
import 'package:mynote/pages/new_note_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NoteDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    notes = await NoteDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
    print("refresh");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : notes.isEmpty
                ? const Center(child: Text("Nothing here"))
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(25),
                          child: Text("MyNote",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold)),
                        ),
                        ListView.builder(
                            padding: const EdgeInsets.all(20),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: notes.length,
                            itemBuilder: (_, index) {
                              final note = notes[index];
                              return Slidable(
                                child: Card(
                                  child: ListTile(
                                    title: Text(note.title),
                                    subtitle: Text(formatDate(note.createdTime),
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.white38)),
                                    onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPage(note: note)))
                                        .then((value) => refreshNotes()),
                                  ),
                                ),
                                key: UniqueKey(),
                                startActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  dragDismissible: true,
                                  dismissible: DismissiblePane(
                                      onDismissed: () => deleteNote(note.id!)),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) =>
                                          deleteNote(note.id!),
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.red,
                                      icon: Icons.delete,
                                      spacing: 1,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () => createNote(),
        ),
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    DateFormat dateFormatter = DateFormat('dd MMM yyyy');
    DateFormat timeFormatter = DateFormat('HH:mm');
    return dateFormatter.format(dateTime) +
        " at " +
        timeFormatter.format(dateTime);
  }

  Future deleteNote(int id) async {
    await NoteDatabase.instance.deleteNote(id);
    refreshNotes();
  }

  Future createNote() async {
    final note = Note(title: "", desc: "", createdTime: DateTime.now());
    await NoteDatabase.instance.create(note);
    refreshNotes();
  }
}