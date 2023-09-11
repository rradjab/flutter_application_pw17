import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw17/providers/providers.dart';
import 'package:flutter_application_pw17/models/product_model.dart';
import 'package:flutter_application_pw17/services/products_notifier.dart';

class ProductsView extends ConsumerWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = ref.watch(paramsProvider);
    return ref.watch(firebaseProducts(params)).when(
          data: ((data) => Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListItemWidget(product: data[index]);
                    },
                  ))
                ],
              )),
          error: (Object error, StackTrace stackTrace) => Text(
            error.toString(),
            style: const TextStyle(color: Colors.amber, fontSize: 45),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

class ListItemWidget extends ConsumerWidget {
  const ListItemWidget({required this.product, super.key});
  final ProductModel product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        ref.read(firebaseProductsProvider.notifier).removeProduct(product);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.white.withOpacity(0.8),
          child: ListTile(
            title: Text('${product.name}'),
            subtitle: Text('Price ${product.price}\$'),
            trailing: IconButton(
              onPressed: () {
                ref
                    .read(firebaseProductsProvider.notifier)
                    .updateProduct(product);
              },
              icon: product.purchased!
                  ? const Icon(Icons.check_circle_outline_outlined,
                      color: Colors.green)
                  : const Icon(Icons.add_circle_outline_outlined,
                      color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
