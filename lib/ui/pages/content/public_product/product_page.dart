// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:misiontic_template/ui/pages/content/public_product/widgets/product_screen.dart';

class ProductPage extends StatelessWidget {
  // final ThemeController controller = Get.find();
  ProductPage({Key? key}) : super(key: key);

  // We create a Scaffold that is used for all the content pages
  // We only define one AppBar, and one scaffold.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ProductScreen(),
      ),
    );
  }
}
