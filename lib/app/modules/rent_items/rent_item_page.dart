import 'package:dream_art_app/app/modules/rent_items/rent_details/rent_details.dart';
import 'package:dream_art_app/app/modules/rent_items/return/returtn_item_dialog.dart';
import 'package:dream_art_app/app/modules/rent_items/widgets/filtrenum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class RentedItemsPages extends StatelessWidget {
  final List<Rental> rentals;

  const RentedItemsPages({
    super.key,
    required this.rentals,
  });
  void showRentalDetail(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => RentedItemsPage(rentals: rentalsMock,),
    );
  }
  void _showDetails(BuildContext context, Rentals rental) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 420,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ijara tafsilotlari",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  Text("Mijoz: ${rental.customerName}"),
                  Text("Telefon: ${rental.phone}"),
                  Text(
                      "Sana: ${_fmt(rental.startDate)} → ${_fmt(rental.endDate)}"),
                  Text("Kunlar: ${rental.days}"),

                  const Divider(),

                  const Text(
                    "Olingan texnikalar",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  ...rental.items.map(
                        (i) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text("${i.name} (${i.brand})"),
                          ),
                          Text(
                              "${i.pricePerDay.toStringAsFixed(0)} so'm/kun"),
                        ],
                      ),
                    ),
                  ),

                  const Divider(),

                  Text(
                    "Jami summa: ${rental.totalPrice.toStringAsFixed(0)} so'm",
                    style:
                    const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Yopish"),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
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

          },
        ),
        Expanded(
          child: isDesktop
              ? _desktopTable(rentals,context)
              : _mobileList(rentals),
        ),
      ],
    );
  }
  Widget _desktopTable(List<Rental> rentals,BuildContext context) {
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
          DataColumn(label: Text("Amal")),
        ],
        rows: rentals.map((r) {
          return DataRow(
              cells: [
            DataCell(Text(r.id.toString())),
            DataCell(Text(r.customerName)),
            DataCell(TextButton(onPressed: (){
              _showDetails(context,rentalsMock.first);
            },child: Text(r.itemName))),
            DataCell(Text(_fmt(r.startDate))),
            DataCell(Text(_fmt(r.endDate))),
            DataCell(_statusChip(r)),
            DataCell(
              r.returned
                  ? const Text("-")
                  : ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => ReturnItemsDialog(
                      rental: rentalsMock.first,
                      onConfirm: (returned, notReturned) {
                        debugPrint("Qaytarilganlar: ${returned.length}");
                        debugPrint("Qaytarmaganlar: ${notReturned.length}");
                      },
                    ),
                  );
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
                  r.customerName,
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
