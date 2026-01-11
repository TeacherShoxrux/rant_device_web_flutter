import 'package:flutter/material.dart';
import '../rent_details/rent_details.dart';


class ReturnItemsDialog extends StatefulWidget {
  final Rentals rental;
  final Function(List<RentedItem> returnedItems, List<RentedItem> notReturned)
  onConfirm;

  const ReturnItemsDialog({
    super.key,
    required this.rental,
    required this.onConfirm,
  });

  @override
  State<ReturnItemsDialog> createState() => _ReturnItemsDialogState();
}
class _ReturnItemsDialogState extends State<ReturnItemsDialog> {
  late Map<RentedItem, bool> selectedMap;

  @override
  void initState() {
    super.initState();
    selectedMap = {
      for (var item in widget.rental.items) item: true,
    };
  }

  @override
  Widget build(BuildContext context) {
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
              _header(context),
              const Divider(),

              const Text(
                "Qaytariladigan texnikalar",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              _itemsList(),

              const Divider(),

              _summary(),

              const SizedBox(height: 12),

              _actions(context),
            ],
          ),
        ),
      ),
    );
  }
  Widget _header(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Ijara qaytarish",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }

  Widget _itemsList() {
    return Column(
      children: selectedMap.keys.map((item) {
        return CheckboxListTile(
          value: selectedMap[item],
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text("${item.name} (${item.brand})"),
          subtitle:
          Text("${item.pricePerDay.toStringAsFixed(0)} so'm/kun"),
          onChanged: (v) {
            setState(() {
              selectedMap[item] = v ?? false;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _summary() {
    final returned =
        selectedMap.entries.where((e) => e.value).length;
    final notReturned =
        selectedMap.entries.where((e) => !e.value).length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Qaytdi: $returned ta"),
        Text(
          "Qolmadi: $notReturned ta",
          style: TextStyle(
            color: notReturned > 0 ? Colors.red : Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _actions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Bekor qilish"),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _confirm,
            child: const Text("Qaytarish"),
          ),
        ),
      ],
    );
  }

  void _confirm() {
    final returnedItems = <RentedItem>[];
    final notReturnedItems = <RentedItem>[];

    selectedMap.forEach((item, isReturned) {
      if (isReturned) {
        returnedItems.add(item);
      } else {
        notReturnedItems.add(item);
      }
    });

    widget.onConfirm(returnedItems, notReturnedItems);
    Navigator.pop(context);
  }

}