import 'package:phone_state/phone_state.dart';

class Call {
  final String id;
  final bool started;
  final PhoneStateStatus initialStatus;
  final PhoneStateStatus finalStatus;

  Call({
    required this.id,
    required this.started,
    required this.initialStatus,
    required this.finalStatus,
  });
}
