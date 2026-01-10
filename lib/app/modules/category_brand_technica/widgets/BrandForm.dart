import 'package:flutter/material.dart';

class BrandForm extends StatelessWidget {
  const BrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    return _formWrapper(
      child: Column(
        children: [
          _input("Brand nomi"),
          _input("Brand haqida tafsilot"),
          _upload("Brand fotosi"),
          _input("Brand foto haqida tafsilot"),
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

  Widget _upload(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.upload),
        label: Text(title),
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