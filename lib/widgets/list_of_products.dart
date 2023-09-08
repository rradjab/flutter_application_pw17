import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw17/consts/constants.dart';
import 'package:flutter_application_pw17/providers/providers.dart';
import 'package:flutter_application_pw17/models/product_model.dart';

class ProductsView extends ConsumerWidget {
  const ProductsView({required this.products, super.key});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortItems = ref.watch(sortProvider);

    switch (sortItems) {
      case Sorting.nameA:
        products.sort((a, b) => a.name!.compareTo(b.name!));
        break;
      case Sorting.nameD:
        products.sort((b, a) => a.name!.compareTo(b.name!));
        break;
      case Sorting.priceA:
        products.sort((a, b) => a.price!.compareTo(b.price!));
        break;
      case Sorting.priceD:
        products.sort((b, a) => a.price!.compareTo(b.price!));
        break;
    }

    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return ListItemWidget(product: products[index]);
          },
        ))
      ],
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
