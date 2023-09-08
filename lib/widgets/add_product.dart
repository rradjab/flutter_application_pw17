import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_pw17/models/product_model.dart';
import 'package:flutter_application_pw17/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductAdd extends ConsumerWidget {
  ProductAdd({super.key, required this.userEmail});
  final String userEmail;
  final productNameController = TextEditingController()..text = 'product';

  final productPriceController = TextEditingController()
    ..text = (Random().nextDouble() * 256).toStringAsFixed(2);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.deepPurple,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 35,
                child: TextField(
                  controller: productNameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.deepPurple[100],
                      border: const OutlineInputBorder(),
                      hintText: 'Product name'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 35,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: productPriceController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.deepPurple[100],
                    border: const OutlineInputBorder(),
                    hintText: 'Price',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (productNameController.text.trim().isNotEmpty &&
                      productPriceController.text.trim().isNotEmpty) {
                    ref.read(firebaseProductsProvider.notifier).addProduct(
                        ProductModel(
                            name: productNameController.text,
                            price:
                                double.tryParse(productPriceController.text) ??
                                    0,
                            purchased: false,
                            userEmail: userEmail));
                    productNameController.text = '';
                    productPriceController.text =
                        Random().nextInt(9999).toString();
                  }
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
