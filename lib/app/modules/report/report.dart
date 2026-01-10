import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';

/// =======================
/// MODEL
/// =======================
class RentalReportRow {
  final String customer;
  final String item;
  final DateTime start;
  final DateTime end;
  final double price;

  RentalReportRow({
    required this.customer,
    required this.item,
    required this.start,
    required this.end,
    required this.price,
  });
}

/// =======================
/// REPORT PAGE (RESPONSIVE + EXCEL)
/// =======================
class ReportsPage extends StatefulWidget {
  final List<RentalReportRow> data;

  const ReportsPage({super.key, required this.data});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  String reportType = "all";

  List<RentalReportRow> get filteredData {
    if (reportType == "customer") {
      return widget.data
          .where((e) => e.customer.isNotEmpty)
          .toList();
    }
    if (reportType == "item") {
      return widget.data.where((e) => e.item.isNotEmpty).toList();
    }
    return widget.data;
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w > 900;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          const SizedBox(height: 12),
          _stats(w),
          const SizedBox(height: 12),
          Expanded(
            child: isDesktop ? _table() : _mobileList(),
          ),
        ],
      ),
    );
  }

  /// =======================
  /// HEADER + EXPORT
  /// =======================
  Widget _header() {
    return Row(
      children: [
        const Text(
          "Hisobotlar",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        DropdownButton<String>(
          value: reportType,
          items: const [
            DropdownMenuItem(value: "all", child: Text("Barchasi")),
            DropdownMenuItem(value: "customer", child: Text("Mijozlar bo‘yicha")),
            DropdownMenuItem(value: "item", child: Text("Texnikalar bo‘yicha")),
          ],
          onChanged: (v) => setState(() => reportType = v!),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: _exportExcel,
          icon: const Icon(Icons.download, size: 18),
          label: const Text("Excel"),
        ),
      ],
    );
  }

  /// =======================
  /// STAT CARDS (KICHIK)
  /// =======================
  Widget _stats(double w) {
    final cols = w > 1000 ? 4 : w > 600 ? 2 : 1;

    return GridView.count(
      crossAxisCount: cols,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 3.4,
      children: [
        _stat("Ijara soni", filteredData.length.toString()),
        _stat(
          "Daromad",
          "${filteredData.fold<double>(0, (s, e) => s + e.price).toStringAsFixed(0)} so'm",
        ),
        _stat(
          "Mijozlar",
          filteredData.map((e) => e.customer).toSet().length.toString(),
        ),
        _stat(
          "Texnikalar",
          filteredData.map((e) => e.item).toSet().length.toString(),
        ),
      ],
    );
  }

  Widget _stat(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            const Icon(Icons.analytics, size: 18, color: Colors.blue),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.grey)),
                Text(value,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// =======================
  /// DESKTOP TABLE
  /// =======================
  Widget _table() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Mijoz")),
          DataColumn(label: Text("Texnika")),
          DataColumn(label: Text("Boshlanish")),
          DataColumn(label: Text("Tugash")),
          DataColumn(label: Text("Narx")),
        ],
        rows: filteredData.map((r) {
          return DataRow(cells: [
            DataCell(Text(r.customer)),
            DataCell(Text(r.item)),
            DataCell(Text(_d(r.start))),
            DataCell(Text(_d(r.end))),
            DataCell(Text("${r.price}")),
          ]);
        }).toList(),
      ),
    );
  }

  /// =======================
  /// MOBILE LIST
  /// =======================
  Widget _mobileList() {
    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (_, i) {
        final r = filteredData[i];
        return Card(
          child: ListTile(
            title: Text(r.item),
            subtitle: Text(
                "${r.customer}\n${_d(r.start)} → ${_d(r.end)}"),
            trailing: Text("${r.price} so'm"),
            isThreeLine: true,
          ),
        );
      },
    );
  }

  /// =======================
  /// EXCEL (CSV) EXPORT
  /// =======================
  void _exportExcel() {
    final rows = [
      ["Mijoz", "Texnika", "Boshlanish", "Tugash", "Narx"],
      ...filteredData.map((r) => [
        r.customer,
        r.item,
        _d(r.start),
        _d(r.end),
        r.price.toString(),
      ])
    ];

    final csv = rows.map((e) => e.join(",")).join("\n");
    final bytes = utf8.encode(csv);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute("download", "hisobot.csv")
      ..click();

    html.Url.revokeObjectUrl(url);
  }

  String _d(DateTime d) =>
      "${d.day.toString().padLeft(2, '0')}."
          "${d.month.toString().padLeft(2, '0')}."
          "${d.year}";
}
