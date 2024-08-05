import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'model.dart';

class DatabaseService {
  final CollectionReference noteCollection = FirebaseFirestore.instance.collection("notes");
  User? user = FirebaseAuth.instance.currentUser;

  Future<DocumentReference> addNoteTask(
      String title, String note) async {
    return await noteCollection.add(
        {
          'uid': user!.uid,
          'title': title,
          'note': note,
          'color': generateRandomLightColor(),
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        }
    );
  }

  Future<void> updateNote(String id, String title, String note) async {
    final updateNoteCollection = FirebaseFirestore.instance.collection("notes").doc(id);
    return await updateNoteCollection.update({
      'title': title,
      'note': note,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateNoteStatus(String id, bool completed) async {
    return await noteCollection.doc(id).update({'completed': completed});
  }

  Future<void> deleteNoteTask(String id) async {
    return await noteCollection.doc(id).delete();
  }

  Stream<List<Note>> get notes {
    return noteCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: false)
        .snapshots()
        .map(_noteListFromSnapshot);
  }

  Stream<List<Note>> get completedNotes {
    return noteCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: true)
        .snapshots()
        .map(_noteListFromSnapshot);
  }

  List<Note> _noteListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Note(
        id: doc.id,
        title: doc['title'] ?? '',
        note: doc['note'] ?? '',
        color: doc['color'] ?? 0xFFFFFFFF,
        createdAt: (doc['createdAt'] as Timestamp).toDate(),
        updatedAt: (doc['updatedAt'] as Timestamp).toDate(),
      );
    }).toList();
  }
}
