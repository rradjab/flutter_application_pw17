import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_pw17/main.dart';
import 'package:flutter_application_pw17/models/product_model.dart';
import 'package:flutter_application_pw17/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductAdd extends ConsumerStatefulWidget {
  const ProductAdd({super.key});

  @override
  ConsumerState<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends ConsumerState<ProductAdd> {
  final productNameController = TextEditingController()..text = 'product';

  final productPriceController = TextEditingController()
    ..text = (Random().nextDouble() * 256).toStringAsFixed(2);

  @override
  void dispose() {
    productNameController.dispose();
    productPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                                num.tryParse(productPriceController.text) ?? 0,
                            purchased: false,
                            userEmail: user.userEmail));
                    productNameController.text = '';
                    productPriceController.text =
                        (Random().nextDouble() * 256).toStringAsFixed(2);
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
