import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_notebook_project/services/model.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  const NoteScreen({super.key, required this.note});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final CollectionReference myNotes = FirebaseFirestore.instance.collection('notes');
  late TextEditingController titleController;
  late TextEditingController noteController;
  late Note note;
  String titleString = '';
  String noteString = '';
  late int color;

  @override
  void initState() {
    super.initState();
    note = widget.note;
    titleString = note.title;
    noteString = note.note;
    color = note.color == 0xFFFFFFFF ? generateRandomLightColor() : note.color;
    titleController = TextEditingController(text: titleString);
    noteController = TextEditingController(text: noteString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.purple[300],
                    ),
                    child: BackButton(
                      color: Colors.purple[50],
                    ),
                  ),
                  Text(
                    note.id.isEmpty ? 'Add note' : 'Edit note',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.purple[300],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            saveNotes();
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.save_as_sharp,
                            color: Colors.purple[50],
                          ),
                        ),
                        if (note.id.isNotEmpty)
                          IconButton(
                            onPressed: () {
                              myNotes.doc(note.id).delete();
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.purple[50],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note Title",
                ),
                onChanged: (value) {
                  titleString = value;
                },
              ),
              SizedBox(height: 12),
              Expanded(
                child: TextField(
                  controller: noteController,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Note Content",
                  ),
                  onChanged: (value) {
                    noteString = value;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveNotes() async {
    DateTime now = DateTime.now();
    if (note.id.isEmpty) {
      await myNotes.add({
        'title': titleString,
        'note': noteString,
        'color': color,
        'createdAt': now,
        'updatedAt': now,
      });
    } else {
      await myNotes.doc(note.id).update({
        'title': titleString,
        'note': noteString,
        'color': color,
        'updatedAt': now,
      });
    }
  }
}
