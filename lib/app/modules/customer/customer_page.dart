import 'package:flutter/material.dart';

import 'customer_create_alert/add_customer_dialog.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});
  void openAddCustomerDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AddCustomerDialog(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(context),
        const SizedBox(height: 16),
        _filters(context),
        const SizedBox(height: 16),
        Expanded(child: _responsiveTable(context)),
      ],
    );
  }
  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Ro'yxatdan o‘tgan mijozlar ro‘yxati",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ElevatedButton.icon(
          onPressed: () => openAddCustomerDialog(context),
          icon: const Icon(Icons.add),
          label: const Text("Yangi mijoz qo‘shish"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        )
      ],
    );
  }
  Widget _filters(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final columns = width > 1100 ? 4 : width > 700 ? 2 : 1;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _input("F.I.SH"),
        _input("Passport ma’lumotlari"),
        _input("Jinsi"),
        _input("JSHSHIR"),
        _input("Telefon raqami"),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.search),
              label: const Text("Qidiruv"),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.refresh),
              label: const Text("Tozalash"),
            ),
          ],
        )
      ].map((e) {
        return SizedBox(
          width: width / columns - 20,
          child: e,
        );
      }).toList(),
    );
  }

  Widget _input(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        isDense: true,
      ),
    );
  }
  Widget _responsiveTable(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > 900 ? _desktopTable() : _mobileList();
  }
  Widget _desktopTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("ID")),
          DataColumn(label: Text("JSHSHIR")),
          DataColumn(label: Text("Ismi")),
          DataColumn(label: Text("Familiyasi")),
          DataColumn(label: Text("Passport")),
          DataColumn(label: Text("Manzil")),
          DataColumn(label: Text("Holat")),
          DataColumn(label: Text("Amallar")),
        ],
        rows: List.generate(10, (index) {
          return DataRow(cells: [
            DataCell(Text("${index + 1}")),
            const DataCell(Text("123123123123")),
            const DataCell(Text("Rustam")),
            const DataCell(Text("Axmerov")),
            const DataCell(Text("AD123123")),
            const DataCell(Text("Toshkent")),
            const DataCell(
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 18),
                  SizedBox(width: 4),
                  Text("Aktiv"),
                ],
              ),
            ),
            DataCell(Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Skladga"),
                )
              ],
            )),
          ]);
        }),
      ),
    );
  }
  Widget _mobileList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rustam Axmerov",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                const Text("JSHSHIR: 123123123123"),
                const Text("Passport: AD123123"),
                const Text("Manzil: Toshkent"),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Chip(
                      label: Text("Aktiv"),
                      backgroundColor: Colors.greenAccent,
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: const Icon(Icons.edit), onPressed: () {}),
                        IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {}),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
