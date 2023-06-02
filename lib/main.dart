import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DAM Labs',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Laboratórios de DAM'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _taskList = [];
  TextEditingController controller = TextEditingController();

  void _addTask() {
    setState(() {
      _taskList.add(controller.text);
      controller.clear();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Visibility(
            visible: _taskList.isNotEmpty,
            replacement: const Center(
              child: Text('Lista de tarefas vazia'),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 250,
              child: Expanded(
                child: ListView.builder(
                  itemCount: _taskList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_taskList[index]),
                      subtitle: Text('#${_taskList[index]}@${index + 1}'),
                      leading: CircleAvatar(
                        child: Text('#${index + 1}'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Adicionar tarefa'),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Adicionar',
        child: const Icon(Icons.add),
      ),
    );
  }
}