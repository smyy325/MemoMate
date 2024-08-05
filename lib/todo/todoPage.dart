
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:my_notebook_project/todo/common/show_model.dart';
import 'package:my_notebook_project/todo/provider/service_provider.dart';
import 'package:my_notebook_project/todo/widget/card_widget.dart';

class TodoPage extends ConsumerWidget {
  TodoPage({super.key});

  final String formattedDate = DateFormat('EEEE, dd MMMM').format(DateTime.now());
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final todoData = ref.watch(fetchStreamProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple[200],
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.all(40.0),
          child: Text(
            "To-Do Page",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.calendar_today),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.bell_fill),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Task",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        formattedDate,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD5EBFA),
                        foregroundColor: Colors.blue.shade700,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      context: context,
                      builder: (context) => const AddNewTaskModel(),
                    ),
                    child: const Text("+ New Task"),
                  ),
                ],
              ),
              Gap(20),
              ListView.builder(
                itemCount: todoData.value?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    CardTodoListWidget(getIndex: index),
              )
            ],
          ),
        ),
      ),
    );
  }
}
