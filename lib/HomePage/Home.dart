import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_notebook_project/HomePage/Drawer.dart';
import 'package:my_notebook_project/HomePage/NoteCard.dart';
import 'package:my_notebook_project/services/model.dart';

class NoteHome extends StatefulWidget {
  const NoteHome({super.key});

  @override
  State<NoteHome> createState() => _NoteHomeState();
}

class _NoteHomeState extends State<NoteHome> {
  final CollectionReference myNotes = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 36.0, right: 12, left: 12),
        child: StreamBuilder(
          stream: myNotes.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final notes = snapshot.data!.docs;
            List<NoteCard> noteCards = [];
            for (var note in notes) {
              var data = note.data() as Map<String, dynamic>?;
              if (data != null) {
                Note noteObject = Note(
                  id: note.id,
                  title: data['title'] ?? "",
                  note: data['note'] ?? "",
                  createdAt: data.containsKey('createdAt') ? (data['createdAt'] as Timestamp).toDate() : DateTime.now(),
                  updatedAt: data.containsKey('updatedAt') ? (data['updatedAt'] as Timestamp).toDate() : DateTime.now(),
                  color: data.containsKey('color') ? data['color'] : 0xFFFFFFFF,
                );
                noteCards.add(
                  NoteCard(
                    note: noteObject,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NoteScreen(note: noteObject)),
                      );
                    },
                  ),
                );
              }
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: noteCards.length,
              itemBuilder: (context, index) {
                return noteCards[index];
              },
              padding: EdgeInsets.all(3),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteScreen(
                note: Note(
                  id: '',
                  title: '',
                  note: '',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.purple[300],
        child: Icon(
          Icons.add,
          color: Colors.purple[50],
          size: 35,
        ),
      ),
    );
  }
}
