import 'package:dream_art_app/app/modules/customer/customer_page.dart';
import 'package:dream_art_app/app/modules/rent_items/rent_item_page.dart';
import 'package:flutter/material.dart';

import '../booking/booking_page.dart';
import '../category_brand_technica/category_brand_technica_page.dart';
import '../report/report.dart';
import '../sklad/sklad_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;

  final menus = [
    "Mijozlar ro‘yxati",
    "Sklad",
    "Ijaraga olinganlar",
    "Bron qilinganlar",
    "Admin panel",
    "Xisobotlar",
  ];
  static final rentalsMock = [
    Rental(
      id: 1,
      customerName: "Rustam Axmerov",
      itemName: "Canon R5 Mark II",
      startDate: DateTime.now().subtract(const Duration(days: 2)),
      endDate: DateTime.now().add(const Duration(days: 3)),
    ),
    Rental(
      id: 2,
      customerName: "Shoxrux Karimov",
      itemName: "Sony A7 IV",
      startDate: DateTime.now().subtract(const Duration(days: 6)),
      endDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Rental(
      id: 3,
      customerName: "Jasmin Abdujalilova",
      itemName: "DJI RS3 Pro",
      startDate: DateTime.now().subtract(const Duration(days: 10)),
      endDate: DateTime.now().subtract(const Duration(days: 5)),
      returned: true,
    ),
  ];
static  final reportMock = [
  RentalReportRow(
    customer: "Rustam Axmerov",
    item: "Canon R5",
    start: DateTime(2025, 1, 5),
    end: DateTime(2025, 1, 8),
    price: 900000,
  ),
  RentalReportRow(
    customer: "Shoxrux Karimov",
    item: "DJI RS3",
    start: DateTime(2025, 1, 3),
    end: DateTime(2025, 1, 6),
    price: 600000,
  ),
];
static  final bookingItemsMock = [
    BookingItem(
      id: 1,
      name: "Canon R5",
      brand: "Canon",
      pricePerDay: 300000,
    ),
    BookingItem(
      id: 2,
      name: "Sony A7 IV",
      brand: "Sony",
      pricePerDay: 280000,
    ),
    BookingItem(
      id: 3,
      name: "DJI RS3 Pro",
      brand: "DJI",
      pricePerDay: 200000,
    ),
  ];
  final pages = [
  const CustomersPage(),
    SkladPage(),

   RentedItemsPage(rentals: rentalsMock),
    BookingPage(items: bookingItemsMock),
    const BrandCategoryEquipmentPage(),
    ReportsPage( data: reportMock,)
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1235;

        return Scaffold(
          appBar: isDesktop
              ? _desktopAppBar()
              : AppBar(
            title: const Text("Rental System"),
            backgroundColor:Colors.blueAccent,
          ),

          drawer: isDesktop ? null : _mobileDrawer(),

          body: Padding(
            padding: const EdgeInsets.all(16),
            child: pages[selectedIndex],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _desktopAppBar() {
    return AppBar(
      backgroundColor:Colors.blueAccent,
      title: Row(
        children: [
          const Icon(Icons.camera_alt),
          const SizedBox(width: 8),
          const Text("Rental System"),

          const Spacer(),

          ...List.generate(menus.length, (index) {
            final isActive = selectedIndex == index;
            return InkWell(
              onTap: () {
                setState(() => selectedIndex = index);
              },
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isActive ? Colors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  menus[index],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }),

          const Spacer(),

          const Icon(Icons.shopping_cart),
          const SizedBox(width: 16),
          const CircleAvatar(child: Text("U")),
        ],
      ),
    );
  }

  Widget _mobileDrawer() {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            color: const Color(0xFF0B2A4A),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(16),
            child: const Text(
              "Rental System",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ...List.generate(menus.length, (index) {
            return ListTile(
              title: Text(menus[index]),
              selected: selectedIndex == index,
              onTap: () {
                setState(() => selectedIndex = index);
                Navigator.pop(context);
              },
            );
          }),
        ],
      ),
    );
  }


}
