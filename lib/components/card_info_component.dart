import 'package:flutter/material.dart';

Column CardInfo(String data, String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontSize: 20, color: Colors.grey)),
      SizedBox(height: 12),
      Text(data, style: TextStyle(fontSize: 20)),
    ],
  );
}
