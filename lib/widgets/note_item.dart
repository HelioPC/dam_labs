import 'package:dam_labs/model/note.dart';
import 'package:dam_labs/providers/notes_state.dart';
import 'package:dam_labs/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  const NoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.form);
      },
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(AppRoutes.noteDetail, arguments: note);
        },
        child: Slidable(
          key: ValueKey(key),
          endActionPane: ActionPane(
            motion: const BehindMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.form, arguments: note);
                },
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                icon: Icons.edit,
              ),
              SlidableAction(
                onPressed: (context) {
                  Provider.of<NotesState>(context, listen: false)
                      .removeNote(note.id);
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
              ),
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: note.noteColor,
              child: Text(note.title.trim()[0]),
            ),
            title: Text(
              note.title,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(note.description),
          ),
        ),
      ),
    );
  }
}
