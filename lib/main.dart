import 'package:dam_labs/pages/detail_page.dart';
import 'package:dam_labs/pages/form_page.dart';
import 'package:dam_labs/pages/home_page.dart';
import 'package:dam_labs/providers/notes_state.dart';
import 'package:dam_labs/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DAM Labs 02',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        routes: {
          AppRoutes.home: (context) => const HomePage(),
          AppRoutes.noteDetail: (context) => const DetailPage(),
          AppRoutes.form: (context) => const FormPage(),
        },
      ),
    );
  }
}
