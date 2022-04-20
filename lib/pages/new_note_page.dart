import 'package:flutter/material.dart';
import 'package:mynote/database/notes_database.dart';
import 'package:mynote/model/note.dart';

class NewNotePage extends StatelessWidget {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.create),
                onPressed: () => createNote(),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: descController,
                    decoration: const InputDecoration(border: InputBorder.none),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  Future createNote() async {
    final note = Note(
      title: titleController.text.trim(),
      desc: titleController.text.trim(),
      createdTime: DateTime.now()
    );
    await NoteDatabase.instance.create(note);
  }
}
