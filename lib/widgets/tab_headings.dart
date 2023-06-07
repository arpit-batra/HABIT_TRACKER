import 'package:flutter/material.dart';

class TabHeading extends StatelessWidget {
  const TabHeading({required this.heading, super.key});
  final String heading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: Text(
        heading,
        style: Theme.of(context).textTheme.titleLarge,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
