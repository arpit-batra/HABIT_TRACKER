import 'package:flutter/material.dart';

class SettingsButtonWrapper extends StatelessWidget {
  const SettingsButtonWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 36),
        child: child);
  }
}
