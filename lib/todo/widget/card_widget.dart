
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_notebook_project/todo/provider/service_provider.dart';


class CardTodoListWidget extends ConsumerWidget {
  const CardTodoListWidget({super.key, required this.getIndex});
  final int getIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final todoData=ref.watch(fetchStreamProvider);
    return todoData.when(
        data: (todoData){
          final getCategory=todoData[getIndex].category;
          Color categoryColor=Colors.white;
          switch(getCategory){
            case 'Learning':
              categoryColor=Colors.green;
              break;
            case 'Working':
              categoryColor=Colors.blue.shade700;
              break;
            case 'General':
              categoryColor=Colors.amber.shade700;
              break;
          }
          return Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: categoryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  width: 20,
                ),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: IconButton(icon: Icon(CupertinoIcons.delete),onPressed: ()=> ref.read(serviceProvider).deleteTask(todoData[getIndex].docID),),
                            title: Text(todoData[getIndex].titleTask, maxLines: 1, style: TextStyle(decoration: todoData[getIndex].isDone?TextDecoration.lineThrough:null),),
                            subtitle: Text(todoData[getIndex].description, maxLines: 1, style: TextStyle(decoration: todoData[getIndex].isDone?TextDecoration.lineThrough:null),),
                            trailing: Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                activeColor: Colors.blue.shade800,
                                shape: CircleBorder(),
                                value: todoData[getIndex].isDone,
                                onChanged: (value)=>ref.read(serviceProvider).updateTask(
                                  todoData[getIndex].docID,value
                                ),
                              ),
                            ),
                          ),
                          Transform.translate(offset: Offset(0,-12), child: Container(
                            child: Column(
                              children: [
                                Divider(
                                  thickness: 1.5,
                                  color: Colors.grey.shade200,
                                ),
                                Row(
                                  children: [
                                    Text(
                        'Date: ${todoData[getIndex].dateTask}', // Display the selected date
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Gap(20),
                      Text(
                        'Time: ${todoData[getIndex].timeTask}', // Display the selected time
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                                  ],
                                )
                              ],
                            ),
                          ),)
                        ],
                      ),
                    ))
              ],
            ),
          );
        },
        error: (error, stackTrace)=>Center(
          child: Text(stackTrace.toString()),
        ),
        loading: ()=>Center(
          child: CircularProgressIndicator(),
        ),
    );
  }
}
