import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_pw17/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FireStoreService extends StateNotifier<List<ProductModel>> {
  FireStoreService() : super([]);

  final _products = FirebaseFirestore.instance
      .collection('products')
      .withConverter<ProductModel>(
        fromFirestore: (snapshot, _) => ProductModel.fromJson(
          snapshot.id,
          snapshot.data()!,
        ),
        toFirestore: (product, _) => product.toJson(),
      );

  void addProduct(ProductModel product) {
    _products.add(product);
  }

  void updateProduct(ProductModel product) {
    FirebaseFirestore.instance
        .collection('products')
        .doc(product.id)
        .update({'purchased': !product.purchased!});
  }

  void removeProduct(ProductModel product) {
    FirebaseFirestore.instance.collection('products').doc(product.id).delete();
  }
}
