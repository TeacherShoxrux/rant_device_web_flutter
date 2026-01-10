import 'package:dream_art_app/app/modules/rent_items/widgets/filtrenum.dart';
import 'package:flutter/material.dart';

class RentedItemsPage extends StatelessWidget {
  final List<Rental> rentals;

  const RentedItemsPage({
    super.key,
    required this.rentals,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Ijaraga olinganlar",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        RentalFilterWidget(
          onFilter: (filter) {
            // shu yerda rental listni filter qilasiz
            // filter.customer
            // filter.item
            // filter.dateRange
            // filter.status
          },
        ),
        Expanded(
          child: isDesktop
              ? _desktopTable(rentals)
              : _mobileList(rentals),
        ),
      ],
    );
  }
  Widget _desktopTable(List<Rental> rentals) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("ID")),
          DataColumn(label: Text("Mijoz")),
          DataColumn(label: Text("Texnika")),
          DataColumn(label: Text("Boshlanish")),
          DataColumn(label: Text("Tugash")),
          DataColumn(label: Text("Holat")),
          DataColumn(label: Text("Amal")),
        ],
        rows: rentals.map((r) {
          return DataRow(cells: [
            DataCell(Text(r.id.toString())),
            DataCell(Text(r.customerName)),
            DataCell(Text(r.itemName)),
            DataCell(Text(_fmt(r.startDate))),
            DataCell(Text(_fmt(r.endDate))),
            DataCell(_statusChip(r)),
            DataCell(
              r.returned
                  ? const Text("-")
                  : ElevatedButton(
                onPressed: () {
                  // TODO: return logic
                },
                child: const Text("Qaytarish"),
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }
  Widget _mobileList(List<Rental> rentals) {
    return ListView.builder(
      itemCount: rentals.length,
      itemBuilder: (_, i) {
        final r = rentals[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r.itemName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text("Mijoz: ${r.customerName}"),
                Text("Boshlanish: ${_fmt(r.startDate)}"),
                Text("Tugash: ${_fmt(r.endDate)}"),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _statusChip(r),
                    if (!r.returned)
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Qaytarish"),
                      ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _statusChip(Rental r) {
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
  String _fmt(DateTime d) {
    return "${d.day.toString().padLeft(2, '0')}. "
        "${d.month.toString().padLeft(2, '0')}. "
        "${d.year}";
  }


}
class Rental {
  final int id;
  final String customerName;
  final String itemName;
  final DateTime startDate;
  final DateTime endDate;
  final bool returned;

  Rental({
    required this.id,
    required this.customerName,
    required this.itemName,
    required this.startDate,
    required this.endDate,
    this.returned = false,
  });

  bool get isLate =>
      !returned && DateTime.now().isAfter(endDate);
}
