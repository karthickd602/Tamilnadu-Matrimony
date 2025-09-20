import 'package:flutter/material.dart';

class BasicDetailsPage extends StatelessWidget {
  const BasicDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(decoration: const InputDecoration(labelText: "Name")),
          const SizedBox(height: 12),
          TextField(decoration: const InputDecoration(labelText: "Mobile")),
          const SizedBox(height: 12),
          DropdownButtonFormField(
            decoration: const InputDecoration(labelText: "Gender"),
            items: ["Male", "Female"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }
}
