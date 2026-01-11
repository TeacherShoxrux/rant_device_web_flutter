import 'package:flutter/material.dart';

import '../customer/csutomer_selection_widget/CustomerSelectPanel.dart';
class BookingItem {
  final int id;
  final String name;
  final String brand;
  final double pricePerDay;

  BookingItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.pricePerDay,
  });
}

class Booking {
  final BookingItem item;
  final DateTimeRange range;

  Booking({
    required this.item,
    required this.range,
  });
}

class BookingPage extends StatefulWidget {
  final List<BookingItem> items;
  const BookingPage({super.key, required this.items});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  BookingItem? _selectedItem;
  DateTimeRange? _selectedRange;

  Customer? selectedCustomer;
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


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Oldindan band qilish",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: isDesktop
                ? Row(
              children: [
               Expanded(child: CustomerSelectPanel(
              customers: mockCustomers,
              onSelected: (customer) {
                selectedCustomer = customer;
                // Sklad / cart / ijara logikasi shu yerda
              },
            ),),
                const SizedBox(width: 16),
                SizedBox(width: 360, child: _bookingPanel(context)),
              ],
            )
                : ListView(
              children: [
                _itemsList(height: 300),
                const SizedBox(height: 16),
                _bookingPanel(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// =======================
  /// ITEMS LIST
  /// =======================
  Widget _itemsList({double? height}) {
    return Card(
      child: SizedBox(
        height: height,
        child: ListView.separated(
          itemCount: widget.items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, i) {
            final item = widget.items[i];
            final selected = _selectedItem?.id == item.id;

            return ListTile(
              selected: selected,
              title: Text(item.name),
              subtitle: Text(item.brand),
              trailing: Text("${item.pricePerDay.toStringAsFixed(0)} so'm/kun"),
              onTap: () => setState(() => _selectedItem = item),
            );
          },
        ),
      ),
    );
  }

  /// =======================
  /// BOOKING PANEL
  /// =======================
  Widget _bookingPanel(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Band qilish",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _datePicker(context),
            const SizedBox(height: 12),

            if (_selectedItem != null && _selectedRange != null)
              _priceInfo(),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedItem != null && _selectedRange != null
                    ? _book
                    : null,
                child: const Text("Band qilish"),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// =======================
  /// DATE PICKER
  /// =======================
  Widget _datePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        final res = await showDateRangePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (res != null) {
          setState(() => _selectedRange = res);
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: "Band qilish sanasi",
          border: OutlineInputBorder(),
          isDense: true,
        ),
        child: Text(
          _selectedRange == null
              ? "Sana tanlanmagan"
              : "${_fmt(_selectedRange!.start)} → ${_fmt(_selectedRange!.end)}",
        ),
      ),
    );
  }

  /// =======================
  /// PRICE INFO
  /// =======================
  Widget _priceInfo() {
    final days =
        _selectedRange!.end.difference(_selectedRange!.start).inDays + 1;
    final total = days * _selectedItem!.pricePerDay;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Kunlar soni: $days"),
        Text(
          "Umumiy narx: ${total.toStringAsFixed(0)} so'm",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  /// =======================
  /// BOOK ACTION
  /// =======================
  void _book() {
    final booking = Booking(
      item: _selectedItem!,
      range: _selectedRange!,
    );

    // TODO: API ga yuboriladi
    debugPrint(
        "BAND QILINDI: ${booking.item.name} (${_fmt(booking.range.start)} - ${_fmt(booking.range.end)})");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Muvaffaqiyatli band qilindi")),
    );

    setState(() {
      _selectedItem = null;
      _selectedRange = null;
    });
  }

  String _fmt(DateTime d) =>
      "${d.day.toString().padLeft(2, '0')}."
          "${d.month.toString().padLeft(2, '0')}."
          "${d.year}";
}
