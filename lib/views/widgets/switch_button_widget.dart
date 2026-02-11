import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class SwitchButtonWidget extends StatefulWidget {
  const SwitchButtonWidget({super.key});

  @override
  State<SwitchButtonWidget> createState() => _SwitchButtonWidgetState();
}

class _SwitchButtonWidgetState extends State<SwitchButtonWidget> {
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    _loadSwitchState();
  }

  Future<void> _loadSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitched = prefs.getBool('switch_state') ?? false;
    });
  }

  Future<void> _saveSwitchState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('switch_state', value);
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: (value) async {
        if (value) {
          var status = await Permission.notification.status;

          if (!status.isGranted) {
            status = await Permission.notification.request();
          }

          if (status.isGranted) {
            setState(() {
              isSwitched = true;
            });
            _saveSwitchState(true);
          } else {
            setState(() {
              isSwitched = false;
            });
            _saveSwitchState(false);
          }
        } else {
          setState(() {
            isSwitched = false;
          });
          _saveSwitchState(false);
        }
      },
    );
  }
}
