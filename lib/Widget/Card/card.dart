import 'package:flutter/material.dart';

Card ncard(BuildContext context, String title) {
  return Card(
    elevation: 3,
    color: Colors.deepPurple[200],
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        '\t $title',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    ),
  );
}
