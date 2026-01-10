import 'package:flutter/material.dart';

import '../customer/csutomer_selection_widget/CustomerSelectPanel.dart';

class SkladPage extends StatelessWidget {
  SkladPage({super.key});
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

  Customer? selectedCustomer;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 900;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMobile) CustomerSelectPanel(
          customers: mockCustomers,
          onSelected: (customer) {
            selectedCustomer = customer;
            // Sklad / cart / ijara logikasi shu yerda
          },
        ),
        Expanded(child: _rightContent(context)),
      ],
    );
  }
  Widget _leftInfoPanel() {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Mijoz tanlanmagan!",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          Icon(Icons.inventory_2_outlined,
              size: 64, color: Colors.grey),
          SizedBox(height: 8),
          Text("No data", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
  Widget _rightContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _brandTabs(),
          const SizedBox(height: 12),
          _categoryChips(),
          const SizedBox(height: 20),
          _productGrid(context),
        ],
      ),
    );
  }

  Widget _brandTabs() {
    final brands = [
      "Canon",
      "Sony",
      "Flashka",
      "Stabilizator",
      "Audio rec",
      "Chiroqlar",
      "Others"
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: brands.map((b) {
          return Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.camera,color: Colors.amberAccent,size: 36,),
                Text(b),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _categoryChips() {
    final categories = [
      "Kamera",
      "Objektiv EF",
      "Objektiv RF",
      "Objektiv Samyang",
      "Batareya",
      "Sigma",
    ];

    return Wrap(
      spacing: 8,
      children: categories.map((c) {
        return Chip(
          label: Text(c),
          backgroundColor: Colors.black87,
          labelStyle: const TextStyle(color: Colors.white),
        );
      }).toList(),
    );
  }

  Widget _productGrid(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 1;
    if (width > 1400) {
      crossAxisCount = 5;
    } else if (width > 1100) {
      crossAxisCount = 4;
    } else if (width > 800) {
      crossAxisCount = 3;
    } else if (width > 500) {
      crossAxisCount = 2;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemCount: 10,
      itemBuilder: (_, index) => _productCard(),
    );
  }
  Widget _productCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Icon(Icons.camera_alt, size: 80, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "R5 Mark II",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text("foto video"),
            const SizedBox(height: 4),
            const Text("Brandi: Canon"),
            const Text("Hozirda mavjud: 5 ta"),
            const Text(
              "Narxi: 200 000 so'm",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                onPressed: () {},
                child: const Text("Qo‘shish"),
              ),
            ),
          ],
        ),
      ),
    );
  }




}
