import "package:flutter/material.dart";

import "customer_selection_page.dart";

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Namuna uchun ma'lumotlar
  List<RentalItem> cartItems = [
    RentalItem(
      id: '1',
      name: 'Professional Kamera Sony A7III',
      imageUrl: 'https://via.placeholder.com/150',
      pricePerDay: 50.0,
      rentalDays: 2,
    ),
    RentalItem(
      id: '2',
      name: 'Dron DJI Mavic Air 2',
      imageUrl: 'https://via.placeholder.com/150',
      pricePerDay: 75.0,
      rentalDays: 1,
    ),
  ];

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + (item.pricePerDay * item.rentalDays));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Savatcha / Bron qilish"),
        backgroundColor: Colors.blueAccent,
      ),
      body: cartItems.isEmpty
          ? Center(child: Text("Savatchangiz bo'sh"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network("https://picsum.photos/200/300", width: 60, fit: BoxFit.cover),
                    title: Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${item.pricePerDay} \$ / kuniga"),
                    trailing:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        item.rentalDays == 1?IconButton(
                    icon: Icon(Icons.delete_forever,color: Colors.red,),
                    onPressed: () {
                      setState(() {
                        cartItems.removeAt(index);
                      });
                    }):IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(() {
                              if (item.rentalDays > 1) item.rentalDays--;
                            });
                          },
                        ),
                        Text("${item.rentalDays} dona", style: TextStyle(fontSize: 16)),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () {
                            setState(() {
                              item.rentalDays++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildCheckoutSection(),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Umumiy summa:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("$totalPrice \$", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      setState(() {
                        // if (item.rentalDays > 1) item.rentalDays--;
                      });
                    },
                  ),
                  Text("\$ kun", style: TextStyle(fontSize: 16)),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () {
                      setState(() {
                        // item.rentalDays++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Bu yerda C# / ASP.NET API ga so'rov yuboriladi
                      _showBookingSuccess();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                    child: Text("Band qilish", style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Bu yerda C# / ASP.NET API ga so'rov yuboriladi
                      _showBookingSuccess();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text("Ijaraga berish", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showBookingSuccess()async {
    final result = await showDialog(
      context: context,
      builder: (context) => SafeWebDialog(
        customers: List.generate(20, (index) => "Mijoz #${index + 1}"),
      ),
    );
    if (result != null) {
      // Saqlash logikasi
    }



    // showDialog(
    //   context: context,
    //   builder: (context) =>
    //   WebResponsiveDialog(customers: [],)
    //   //     AlertDialog(
    //   //   title: Text("Muvaffaqiyatli!"),
    //   //   content: Text("Sizning buyurtmangiz qabul qilindi. Tez orada operator bog'lanadi."),
    //   //   actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],
    //   // ),
    // );
  }
}

class RentalItem {
  final String id;
  final String name;
  final String imageUrl;
  final double pricePerDay;
  int rentalDays;

  RentalItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.pricePerDay,
    this.rentalDays = 1,
  });
}