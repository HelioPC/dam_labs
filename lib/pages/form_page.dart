import 'package:dam_labs/model/note.dart';
import 'package:dam_labs/providers/notes_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final note = arg as Note;

        _formData['id'] = note.id;
        _formData['title'] = note.title;
        _formData['description'] = note.description;
      }
    }
  }

  void _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    _formKey.currentState?.save();

    try {
      await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const Text('Adicionar nota'),
            content: const Text('Criar uma nova nota'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      ).then((value) {
        final result = value ?? false;

        if (result) {
          Provider.of<NotesState>(context, listen: false).addNote(_formData);

          if (context.mounted) {
            Navigator.of(context).pop();
          }
        }
      });
    } catch (e) {
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog.adaptive(
              title: const Text('Erro'),
              content: const Text('Ocorreu um erro inesperado'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Nova nota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData['title']?.toString(),
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onSaved: (name) => _formData['title'] = name ?? '',
                decoration: const InputDecoration(labelText: 'Título'),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  final title = value ?? '';

                  if (title.trim().isEmpty) {
                    return 'This field is required';
                  }

                  if (title.length < 4) {
                    return '4 letters at least';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['description']?.toString(),
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onSaved: (name) => _formData['description'] = name ?? '',
                decoration: const InputDecoration(labelText: 'Descrição'),
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                minLines: 1,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  final description = value ?? '';

                  if (description.trim().isEmpty) {
                    return 'This field is required';
                  }

                  if (description.length < 13) {
                    return '13 letters at least';
                  }

                  return null;
                },
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Adicionar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
