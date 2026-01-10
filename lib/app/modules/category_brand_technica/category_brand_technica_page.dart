import 'package:dream_art_app/app/modules/category_brand_technica/widgets/BrandForm.dart';
import 'package:dream_art_app/app/modules/category_brand_technica/widgets/CategoryForm.dart';
import 'package:dream_art_app/app/modules/category_brand_technica/widgets/EquipmentForm.dart';
import 'package:flutter/material.dart';

class BrandCategoryEquipmentPage extends StatefulWidget {
  const BrandCategoryEquipmentPage({super.key});

  @override
  State<BrandCategoryEquipmentPage> createState() =>
      _BrandCategoryEquipmentPageState();
}

class _BrandCategoryEquipmentPageState
    extends State<BrandCategoryEquipmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          tabs: const [
            Tab(text: "Brand"),
            Tab(text: "Kategoriya"),
            Tab(text: "Texnika"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              BrandForm(),
              CategoryForm(),
              EquipmentForm(),
            ],
          ),
        )
      ],
    );
  }
}



