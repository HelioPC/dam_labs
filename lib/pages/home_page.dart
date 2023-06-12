import 'package:dam_labs/providers/notes_state.dart';
import 'package:dam_labs/routes/routes.dart';
import 'package:dam_labs/widgets/note_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NotesState>(context, listen: true).notes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todas as notas'),
      ),
      body: Visibility(
        visible: notes.isNotEmpty,
        replacement: const Center(
          child: Text('Lista de notas vazias'),
        ),
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return NoteItem(note: notes[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.form);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
