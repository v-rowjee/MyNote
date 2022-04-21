import 'package:flutter/material.dart';
import 'package:mynote/database/notes_database.dart';
import 'package:mynote/model/note.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                saveNote();
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () => saveNote(),
              ),
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    deleteNote(widget.note.id!);
                    Navigator.pop(context);
                  }
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController..text = widget.note.title,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                  ),
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                ),
                Expanded(
                  child: TextField(
                    controller: descController..text = widget.note.desc,
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

  Future saveNote() async {
    final updatedNote = widget.note.copy(
        title: titleController.text.trim(),
        desc: descController.text.trim(),
        createdTime: DateTime.now()
    );
    await NoteDatabase.instance.updateNote(updatedNote);
    // print("updated");
  }

  Future deleteNote(int id) async {
    await NoteDatabase.instance.deleteNote(id);
  }
}
