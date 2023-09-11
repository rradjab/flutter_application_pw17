import 'package:flutter/material.dart';
import 'package:flutter_application_pw17/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw17/widgets/app_bar.dart';
import 'package:flutter_application_pw17/models/user_model.dart';
import 'package:flutter_application_pw17/widgets/add_product.dart';
import 'package:flutter_application_pw17/widgets/list_of_products.dart';

class ProductsScreen extends ConsumerWidget {
  final UserModel user;
  const ProductsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppBar(user.userName, ref),
      body: Stack(
        children: [
          images.isNotEmpty
              ? Positioned.fill(
                  child: Image.network(images[0], fit: BoxFit.cover),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          const Column(
            children: [
              Expanded(
                child: ProductsView(),
              ),
              ProductAdd(),
            ],
          ),
        ],
      ),
    );
  }
}
