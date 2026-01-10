import 'package:flutter/material.dart';

/// =======================
/// FILTER STATUS
/// =======================
enum RentalFilterStatus {
  all,
  active,
  late,
  returned,
}

/// =======================
/// FILTER RESULT MODEL
/// =======================
class RentalFilterResult {
  final String customer;
  final String item;
  final DateTimeRange? dateRange;
  final RentalFilterStatus status;

  const RentalFilterResult({
    required this.customer,
    required this.item,
    required this.dateRange,
    required this.status,
  });
}

/// =======================
/// FILTER WIDGET
/// =======================
class RentalFilterWidget extends StatefulWidget {
  final ValueChanged<RentalFilterResult> onFilter;

  const RentalFilterWidget({
    super.key,
    required this.onFilter,
  });

  @override
  State<RentalFilterWidget> createState() => _RentalFilterWidgetState();
}

class _RentalFilterWidgetState extends State<RentalFilterWidget> {
  final _customerCtrl = TextEditingController();
  final _itemCtrl = TextEditingController();

  DateTimeRange? _range;
  RentalFilterStatus _status = RentalFilterStatus.all;

  void _apply() {
    widget.onFilter(
      RentalFilterResult(
        customer: _customerCtrl.text.trim(),
        item: _itemCtrl.text.trim(),
        dateRange: _range,
        status: _status,
      ),
    );
  }

  void _clear() {
    setState(() {
      _customerCtrl.clear();
      _itemCtrl.clear();
      _range = null;
      _status = RentalFilterStatus.all;
    });
    _apply();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 800;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _input(_customerCtrl, "Mijoz"),
            _input(_itemCtrl, "Texnika"),
            _datePicker(context),
            _statusDropdown(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: _apply,
                  icon: const Icon(Icons.search),
                  label: const Text("Qidirish"),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: _clear,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Tozalash"),
                ),
              ],
            ),
          ].map((w) {
            return SizedBox(
              width: isDesktop ? 250 : double.infinity,
              child: w,
            );
          }).toList(),
        ),
      ),
    );
  }

  /// =======================
  /// INPUT
  /// =======================
  Widget _input(TextEditingController c, String label) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }

  /// =======================
  /// STATUS DROPDOWN
  /// =======================
  Widget _statusDropdown() {
    return DropdownButtonFormField<RentalFilterStatus>(
      value: _status,
      decoration: const InputDecoration(
        labelText: "Holat",
        border: OutlineInputBorder(),
        isDense: true,
      ),
      items: const [
        DropdownMenuItem(
          value: RentalFilterStatus.all,
          child: Text("Barchasi"),
        ),
        DropdownMenuItem(
          value: RentalFilterStatus.active,
          child: Text("Ijarada"),
        ),
        DropdownMenuItem(
          value: RentalFilterStatus.late,
          child: Text("Kechikkan"),
        ),
        DropdownMenuItem(
          value: RentalFilterStatus.returned,
          child: Text("Qaytarilgan"),
        ),
      ],
      onChanged: (v) => setState(() => _status = v!),
    );
  }

  /// =======================
  /// DATE RANGE PICKER
  /// =======================
  Widget _datePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        final res = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime(2035),
        );
        if (res != null) {
          setState(() => _range = res);
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: "Sana oralig‘i",
          border: OutlineInputBorder(),
          isDense: true,
        ),
        child: Text(
          _range == null
              ? "Tanlanmagan"
              : "${_fmt(_range!.start)} - ${_fmt(_range!.end)}",
        ),
      ),
    );
  }

  String _fmt(DateTime d) =>
      "${d.day.toString().padLeft(2, '0')}."
          "${d.month.toString().padLeft(2, '0')}."
          "${d.year}";
}

