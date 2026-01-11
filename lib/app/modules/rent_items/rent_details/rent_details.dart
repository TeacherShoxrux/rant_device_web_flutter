import 'package:flutter/material.dart';

/// =======================
/// IJARAGA OLINADIGAN TEXNIKA
/// =======================
class RentedItem {
  final String name;
  final String brand;
  final double pricePerDay;

  RentedItem({
    required this.name,
    required this.brand,
    required this.pricePerDay,
  });
}

/// =======================
/// IJARA (BIR NECHTA TEXNIKA BILAN)
/// =======================
class Rentals {
  final int id;
  final String customerName;
  final String phone;
  final DateTime startDate;
  final DateTime endDate;
  final bool returned;
  final List<RentedItem> items;

  Rentals({
    required this.id,
    required this.customerName,
    required this.phone,
    required this.startDate,
    required this.endDate,
    required this.items,
    this.returned = false,
  });

  int get days => endDate.difference(startDate).inDays + 1;

  bool get isLate => !returned && DateTime.now().isAfter(endDate);

  double get totalPrice =>
      items.fold(0, (s, i) => s + i.pricePerDay * days);
}

/// =======================
/// ASOSIY SAHIFA
/// =======================
class RentedItemsPage extends StatelessWidget {
  final List<Rentals> rentals;

  const RentedItemsPage({super.key, required this.rentals});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ijaraga olinganlar",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: isDesktop
                ? _desktopTable(context)
                : _mobileList(context),
          ),
        ],
      ),
    );
  }

  /// =======================
  /// DESKTOP JADVAL
  /// =======================
  Widget _desktopTable(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("ID")),
          DataColumn(label: Text("Mijoz")),
          DataColumn(label: Text("Texnikalar")),
          DataColumn(label: Text("Boshlanish")),
          DataColumn(label: Text("Tugash")),
          DataColumn(label: Text("Holat")),
        ],
        rows: rentals.map((r) {
          return DataRow(
            // onSelectChanged: (_) => _showDetails(context, r),
            cells: [
              DataCell(Text(r.id.toString())),
              DataCell(Text(r.customerName)),
              DataCell(Text("${r.items.length} ta")),
              DataCell(Text(_fmt(r.startDate))),
              DataCell(Text(_fmt(r.endDate))),
              DataCell(_statusChip(r)),
            ],
          );
        }).toList(),
      ),
    );
  }

  /// =======================
  /// MOBILE RO‘YXAT
  /// =======================
  Widget _mobileList(BuildContext context) {
    return ListView.builder(
      itemCount: rentals.length,
      itemBuilder: (_, i) {
        final r = rentals[i];
        return Card(
          child: ListTile(
            title: Text(r.customerName),
            subtitle: Text(
              "${r.items.length} ta texnika\n"
                  "${_fmt(r.startDate)} → ${_fmt(r.endDate)}",
            ),
            trailing: _statusChip(r),
            isThreeLine: true,
            // onTap: () => _showDetails(context, r),
          ),
        );
      },
    );
  }

  /// =======================
  /// DETAIL ALERT (DIALOG)
  /// =======================


  /// =======================
  /// STATUS CHIP
  /// =======================
  Widget _statusChip(Rentals r) {
    if (r.returned) {
      return const Chip(
        label: Text("Qaytarilgan"),
        backgroundColor: Colors.greenAccent,
      );
    }
    if (r.isLate) {
      return const Chip(
        label: Text("Kechikkan"),
        backgroundColor: Colors.redAccent,
      );
    }
    return const Chip(
      label: Text("Ijarada"),
      backgroundColor: Colors.orangeAccent,
    );
  }

  String _fmt(DateTime d) =>
      "${d.day.toString().padLeft(2, '0')}."
          "${d.month.toString().padLeft(2, '0')}."
          "${d.year}";
}

/// =======================
/// NAMUNAVIY DATA (TEST UCHUN)
/// =======================
final rentalsMock = [
  Rentals(
    id: 1,
    customerName: "Rustam Axmerov",
    phone: "+998901234567",
    startDate: DateTime(2025, 1, 5),
    endDate: DateTime(2025, 1, 8),
    items: [
      RentedItem(name: "Canon R5", brand: "Canon", pricePerDay: 300000),
      RentedItem(name: "RF 24-70", brand: "Canon", pricePerDay: 150000),
      RentedItem(name: "LED Light", brand: "Godox", pricePerDay: 80000),
      RentedItem(name: "Battery", brand: "Sony", pricePerDay: 30000),
    ],
  ),
];