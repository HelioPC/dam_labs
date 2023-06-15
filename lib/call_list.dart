import 'dart:math';

import 'package:dam_labs/call.dart';
import 'package:flutter/material.dart';
import 'package:phone_state/phone_state.dart';

class CallList with ChangeNotifier {
  final List<Call> _phoneCallList = [];

  List<Call> get phoneCallList => [..._phoneCallList];

  void addCall(Map<String, PhoneStateStatus> data) {
    _phoneCallList.add(
      Call(
        id: Random().nextDouble().toString(),
        started: data.containsKey('CALL_STARTED'),
        initialStatus: data['CALL_INCOMING']!,
        finalStatus: data['CALL_ENDED']!,
      ),
    );

    notifyListeners();
  }
}
