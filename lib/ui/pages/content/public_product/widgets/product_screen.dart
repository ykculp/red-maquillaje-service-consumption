// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:misiontic_template/data/services/product_pool.dart';
import 'package:misiontic_template/domain/models/product_model.dart';


class ProductScreen extends StatelessWidget {
  // final ThemeController controller;

  // const ProductScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductPoolService service = ProductPoolService();
    Future<List<ProductModel>> futureProducts = service.fecthData();
    return FutureBuilder<List<ProductModel>>(
      future: futureProducts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              ProductModel product = items[index];
              return Card(
                child: Row(
                  children: [
                    Image.network(
                      product.imageUrl,
                      width: 100,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nombre: ${product.name}"),
                          Text("Marca: ${product.brand}"),
                          Text("Categoria: ${product.category}"),
                          Text("Descripcion: ${product.description}"),
                          Text("Precio: ${product.price}"),
                        ],
                      ),
                    )
                  ],
                ),
              );
              ;
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
