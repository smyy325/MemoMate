import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_notebook_project/todo/model/todo_model.dart';

class TodoService{
  final todoCollection=FirebaseFirestore.instance.collection('todo');

  //create

  void addNewTask(TodoModel model){
    todoCollection.add(model.toMap());
  }

  //update

  void updateTask(String? docID, bool? valueUpdate){
    todoCollection.doc(docID).update({
      'isDone':valueUpdate,
    });
  }

  //Delete

  void deleteTask(String? docID){
    todoCollection.doc(docID).delete();
  }
}