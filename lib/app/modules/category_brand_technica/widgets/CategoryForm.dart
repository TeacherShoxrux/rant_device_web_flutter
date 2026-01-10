import 'package:flutter/material.dart';

class CategoryForm extends StatelessWidget {
  const CategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return _formWrapper(
      child: Column(
        children: [
          _dropdown("Brand tanlang"),
          _input("Kategoriya nomi"),
          _input("Kategoriya haqida tafsilot"),
          _saveButton(),
        ],
      ),
    );
  }
  Widget _formWrapper({required Widget child}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: child,
      ),
    );
  }
  Widget _dropdown(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: const [],
        onChanged: (v) {},
      ),
    );
  }
  Widget _input(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
  Widget _saveButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        onPressed: () {
          // TODO: API save
        },
        child: const Text("Saqlash"),
      ),
    );
  }
}