import 'package:flutter/material.dart';

class AddCustomerDialog extends StatelessWidget {
  const AddCustomerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        width: isMobile ? double.infinity : 900,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          children: [
            _header(context),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _form(context, isMobile),
              ),
            ),
            _footer(context),
          ],
        ),
      ),
    );
  }
  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Yangi mijozni ro'yxatdan o'tkazish",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
  Widget _form(BuildContext context, bool isMobile) {
    final col = isMobile ? 1 : 2;

    Widget field(String label) => TextField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _radioGender(),
        field("JSHSHIR"),
        field("Ismi"),
        field("Familiyasi"),
        field("Otasining ismi"),
        field("Email"),
        field("Passport seriyasi"),
        field("Passport raqami"),
        field("Passport uchun izoh"),
        _passportExists(),
        field("Yashash manzili"),
        field("Tug‘ilgan sana"),
        field("Telefon raqam"),
        field("Telefon raqam egasi"),
        field("Izoh"),
        _uploadButtons(),
      ].map((e) {
        return SizedBox(
          width: MediaQuery.of(context).size.width / col - 40,
          child: e,
        );
      }).toList(),
    );
  }
  Widget _radioGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Jinsi"),
        Row(
          children: const [
            Radio(value: 1, groupValue: 1, onChanged: null),
            Text("Erkak"),
            Radio(value: 2, groupValue: 1, onChanged: null),
            Text("Ayol"),
          ],
        )
      ],
    );
  }
  Widget _passportExists() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Passport bormi"),
        Row(
          children: const [
            Radio(value: true, groupValue: true, onChanged: null),
            Text("Bor"),
            Radio(value: false, groupValue: true, onChanged: null),
            Text("Yo‘q"),
          ],
        )
      ],
    );
  }
  Widget _uploadButtons() {
    return Row(
      children: [
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.image),
          label: const Text("User fotosini yuklash"),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text("Faylni yuklash"),
        ),
      ],
    );
  }
  Widget _footer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              // TODO: validate + API
              Navigator.pop(context);
            },
            child: const Text("Saqlash"),
          )
        ],
      ),
    );
  }

}
