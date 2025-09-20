import 'package:flutter/material.dart';

class FamilyDetailsPage extends StatelessWidget {
  const FamilyDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(decoration: const InputDecoration(labelText: "Father Name")),
          const SizedBox(height: 12),
          TextField(decoration: const InputDecoration(labelText: "Mother Name")),
          const SizedBox(height: 12),
          DropdownButtonFormField(
            decoration: const InputDecoration(labelText: "No. of Brothers"),
            items: ["0", "1", "2", "3+"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }
}
