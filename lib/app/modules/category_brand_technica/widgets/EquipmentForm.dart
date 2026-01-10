import 'package:flutter/material.dart';

class EquipmentForm extends StatelessWidget {
  const EquipmentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return _formWrapper(
      child: Column(
        children: [
          _dropdown("Brand tanlang"),
          _dropdown("Kategoriya tanlang"),
          _input("Texnika nomi"),
          _input("Tavsif"),
          _input("Narxi"),
          _input("Miqdori"),
          _upload("Texnika rasmi"),
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