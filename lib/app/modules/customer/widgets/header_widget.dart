import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Ro'yxatdan o‘tgan mijozlar ro‘yxati",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ElevatedButton.icon(
          onPressed: () => onPressed.call(),
          icon: const Icon(Icons.add),
          label: const Text("Yangi mijoz qo‘shish"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        )
      ],
    );
  }
}
