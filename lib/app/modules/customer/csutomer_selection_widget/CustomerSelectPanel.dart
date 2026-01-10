import 'package:flutter/material.dart';

/// =======================
/// MODEL
/// =======================
class Customer {
  final int id;
  final String fullName;
  final String phone;
  final String passport;

  Customer({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.passport,
  });
}

/// =======================
/// WIDGET
/// =======================
class CustomerSelectPanel extends StatefulWidget {
  final List<Customer> customers;
  final ValueChanged<Customer?> onSelected;
  final double width;

  const CustomerSelectPanel({
    super.key,
    required this.customers,
    required this.onSelected,
    this.width = 280,
  });

  @override
  State<CustomerSelectPanel> createState() => _CustomerSelectPanelState();
}

class _CustomerSelectPanelState extends State<CustomerSelectPanel> {
  final TextEditingController _controller = TextEditingController();

  Customer? _selectedCustomer;
  List<Customer> _filteredCustomers = [];

  @override
  void initState() {
    super.initState();
    _filteredCustomers = widget.customers;
  }

  void _search(String value) {
    setState(() {
      final q = value.toLowerCase();
      _filteredCustomers = widget.customers.where((c) {
        return c.fullName.toLowerCase().contains(q) ||
            c.phone.contains(q) ||
            c.passport.toLowerCase().contains(q);
      }).toList();
    });
  }

  void _selectCustomer(Customer customer) {
    setState(() {
      _selectedCustomer = customer;
      _controller.text = customer.fullName;
      _filteredCustomers.clear();
    });
    widget.onSelected(customer);
  }

  void _clearSelection() {
    setState(() {
      _selectedCustomer = null;
      _controller.clear();
      _filteredCustomers = widget.customers;
    });
    widget.onSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Mijoz tanlash",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          /// INPUT
          TextField(
            controller: _controller,
            onChanged: _search,
            decoration: InputDecoration(
              hintText: "Ism / Telefon / Passport",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _selectedCustomer != null
                  ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: _clearSelection,
              )
                  : null,
              border: const OutlineInputBorder(),
              isDense: true,
            ),
          ),

          const SizedBox(height: 12),

          /// TANLANGAN MIJOZ
          if (_selectedCustomer != null) _selectedCustomerCard(),

          /// VARIANTLAR
          if (_selectedCustomer == null)
            Expanded(child: _customerSuggestions()),
        ],
      ),
    );
  }

  /// =======================
  /// VARIANTLAR RO‘YXATI
  /// =======================
  Widget _customerSuggestions() {
    if (_filteredCustomers.isEmpty) {
      return const Center(
        child: Text(
          "Natija topilmadi",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      itemCount: _filteredCustomers.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, index) {
        final c = _filteredCustomers[index];
        return ListTile(
          dense: true,
          leading: const Icon(Icons.person_outline),
          title: Text(c.fullName),
          subtitle: Text("${c.phone} • ${c.passport}"),
          onTap: () => _selectCustomer(c),
        );
      },
    );
  }

  /// =======================
  /// TANLANGAN MIJOZ CARD
  /// =======================
  Widget _selectedCustomerCard() {
    final c = _selectedCustomer!;
    return Card(
      color: Colors.green.shade50,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.green.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tanlangan mijoz",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text("F.I.SH: ${c.fullName}"),
            Text("Telefon: ${c.phone}"),
            Text("Passport: ${c.passport}"),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _clearSelection,
                child: const Text("Mijozni olib tashlash"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
