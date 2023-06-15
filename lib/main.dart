import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';

main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const Example(),
    ),
  );
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  PhoneStateStatus status = PhoneStateStatus.NOTHING;
  bool? granted;

  Future<bool> requestPermission() async {
    var status = await Permission.phone.status;

    if (status == PermissionStatus.granted) {
      return true;
    }

    var permission = await Permission.phone.request();

    switch (permission) {
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        granted = false;
        return false;
      case PermissionStatus.granted:
        granted = true;
        return true;
      default:
        return false;
    }
  }

  @override
  void initState() {
    super.initState();
    granted = false;
    requestPermission().then((value) {
      setState(() {
        granted = value;
      });
      setStream();
    });
  }

  void setStream() {
    PhoneState.phoneStateStream.listen((event) {
      print(event);
      setState(() {
        if (event != null) {
          status = event;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone State"),
        centerTitle: true,
      ),
      body: Center(
        child: Visibility(
          visible: granted != null && granted!,
          replacement: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Permita o app registar as chamadas'),
              ElevatedButton(
                onPressed: () async {
                  bool temp = await requestPermission();
                  setState(() {
                    granted = temp;
                    if (temp) {
                      setStream();
                    }
                  });
                },
                child: const Text('Ativar'),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Status of call",
                style: TextStyle(fontSize: 24),
              ),
              Icon(
                getIcons(),
                color: getColor(),
                size: 80,
              )
            ],
          ),
        ),
      ),
    );
  }

  IconData getIcons() {
    switch (status) {
      case PhoneStateStatus.NOTHING:
        return Icons.clear;
      case PhoneStateStatus.CALL_INCOMING:
        return Icons.add_call;
      case PhoneStateStatus.CALL_STARTED:
        return Icons.call;
      case PhoneStateStatus.CALL_ENDED:
        return Icons.call_end;
    }
  }

  Color getColor() {
    switch (status) {
      case PhoneStateStatus.NOTHING:
      case PhoneStateStatus.CALL_ENDED:
        return Colors.red;
      case PhoneStateStatus.CALL_INCOMING:
        return Colors.green;
      case PhoneStateStatus.CALL_STARTED:
        return Colors.orange;
    }
  }
}
