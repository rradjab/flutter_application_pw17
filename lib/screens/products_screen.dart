import 'package:flutter/material.dart';
import 'package:flutter_application_pw17/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw17/widgets/app_bar.dart';
import 'package:flutter_application_pw17/widgets/add_product.dart';
import 'package:flutter_application_pw17/widgets/list_of_products.dart';
import 'package:flutter_application_pw17/services/products_notifier.dart';
import 'package:flutter_application_pw17/providers/providers.dart';

class ProductsScreen extends ConsumerWidget {
  final UserModel user;
  const ProductsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(backImgProvider);
    final filter = ref.watch(filterProvider);
    return Scaffold(
      appBar: customAppBar(user.userName),
      body: Stack(
        children: [
          images.isNotEmpty
              ? Positioned.fill(
                  child: Image.network(images[0], fit: BoxFit.cover),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          ref.watch(firebaseProducts(filter)).when(
                data: ((data) => Column(
                      children: [
                        Expanded(
                          child: ProductsView(
                            products: data,
                          ),
                        ),
                        ProductAdd(userEmail: user.userEmail),
                      ],
                    )),
                error: (Object error, StackTrace stackTrace) => Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.amber, fontSize: 45),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
        ],
      ),
    );
  }
}
