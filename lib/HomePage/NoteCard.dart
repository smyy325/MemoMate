import 'package:flutter/material.dart';
import 'package:my_notebook_project/services/model.dart';
import 'package:intl/intl.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onPressed;
  const NoteCard({super.key, required this.note, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    DateTime displayTime = note.updatedAt.isAfter(note.createdAt)
        ? note.updatedAt
        : note.createdAt;
    String formattedDateTime = DateFormat('h:mma MMMM d, y').format(displayTime);
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Color(note.color),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  Text(
                    formattedDateTime,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Flexible(
                child: Text(
                  note.note,
                  maxLines: 4,
                  style: TextStyle(
                    fontSize: 17,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
