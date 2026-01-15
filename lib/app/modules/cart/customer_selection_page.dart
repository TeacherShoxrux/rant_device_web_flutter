import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../customer/csutomer_selection_widget/CustomerSelectPanel.dart';

class SafeWebDialog extends StatefulWidget {
  final List<String> customers;
  const SafeWebDialog({super.key, required this.customers});

  @override
  State<SafeWebDialog> createState() => _SafeWebDialogState();
}

class _SafeWebDialogState extends State<SafeWebDialog> {
  final List<Customer> mockCustomers = [
    Customer(
      id: 1,
      fullName: "Rustam Axmerov",
      phone: "+998901234567",
      passport: "AA1234567",
    ),
    Customer(
      id: 2,
      fullName: "Shoxrux Karimov",
      phone: "+998933456789",
      passport: "AB7654321",
    ),
    Customer(
      id: 3,
      fullName: "Jasmin Abdujalilova",
      phone: "+998991112233",
      passport: "AC9988776",
    ),
    Customer(
      id: 4,
      fullName: "Javohir Qudratov",
      phone: "+998946667788",
      passport: "AD4455667",
    ),
    Customer(
      id: 5,
      fullName: "Shavkat Sapashov",
      phone: "+998977889900",
      passport: "AE1122334",
    ),
    Customer(
      id: 6,
      fullName: "Milena Avanesyan",
      phone: "+998909876543",
      passport: "AF5566778",
    ),
    Customer(
      id: 7,
      fullName: "Asliddin Rustamov",
      phone: "+998931234890",
      passport: "AG3344556",
    ),
    Customer(
      id: 8,
      fullName: "Fayzullo Bahromov",
      phone: "+998995554433",
      passport: "AH7788990",
    ),
    Customer(
      id: 9,
      fullName: "Shoxsanam Shoni",
      phone: "+998947770011",
      passport: "AI2233445",
    ),
    Customer(
      id: 10,
      fullName: "Abdurashid Xamidov",
      phone: "+998901112233",
      passport: "AJ6677889",
    ),
  ];
  String? selectedCustomer;
  DateTime? startDate;
  DateTime? endDate;
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isMobile = mediaQuery.size.width < 600;

    return Dialog( // AlertDialog o'rniga Dialog ishlatsak, dizaynni boshqarish osonroq
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        // Webda kenglikni cheklaymiz, mobil bo'lsa ekranni to'ldiradi
        width: isMobile ? double.infinity : 500,
        // Balandlik ekranning 80% idan oshib ketmaydi
        constraints: BoxConstraints(
          maxHeight: mediaQuery.size.height * 0.8,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Kontentga qarab moslashadi
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Mijoz va muddatni tanlash",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(),

            // 1. Qidiruv qismi
            TextField(
              decoration: const InputDecoration(
                hintText: "Mijozni qidirish...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => searchQuery = v),
            ),
            const SizedBox(height: 10),

            // 2. Mijozlar ro'yxati (Scroll bo'ladigan qismi)
            Flexible( // Ekranga sig'may qolsa, faqat shu qism scroll bo'ladi
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomerSelectPanel(customers: mockCustomers, onSelected: (Customer? value) {  },width: double.infinity,)
              ),
            ),
            const SizedBox(height: 15),

            // 3. Sana tanlash qismi
            const Text("Muddat:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildResponsiveDates(isMobile),

            const SizedBox(height: 20),

            // 4. Tugmalar
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Bekor qilish"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                  onPressed: (selectedCustomer != null && startDate != null && endDate != null)
                      ? () => Navigator.pop(context, {"customer": selectedCustomer, "start": startDate, "end": endDate})
                      : null,
                  child: const Text("Saqlash"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Sanalarni yonma-yon yoki ustma-ust chiqarish
  Widget _buildResponsiveDates(bool isMobile) {
    List<Widget> children = [
      _dateButton("Olib ketish", startDate, (d) => setState(() => startDate = d)),
      if (!isMobile) const SizedBox(width: 10) else const SizedBox(height: 10),
      _dateButton("Qaytarish", endDate, (d) => setState(() => endDate = d)),
    ];

    return isMobile ? Column(children: children) : Row(children: children.map((e) => Expanded(child: e)).toList());
  }

  Widget _dateButton(String label, DateTime? date, Function(DateTime) onPick) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
      icon: const Icon(Icons.calendar_today, size: 18),
      label: Text(date == null ? label : DateFormat('dd.MM.yyyy').format(date)),
      onPressed: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
        if (picked != null) onPick(picked);
      },
    );
  }
}