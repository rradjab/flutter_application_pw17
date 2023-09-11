import 'package:flutter_application_pw17/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_pw17/models/product_params.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw17/consts/constants.dart';
import 'package:flutter_application_pw17/models/product_model.dart';

final firebaseProducts = StreamProvider.autoDispose
    .family<List<ProductModel>, ProductParams>((ref, params) {
  var stream = FirebaseFirestore.instance
      .collection('products')
      .where('userEmail', isEqualTo: user.userEmail)
      .snapshots();

  if (params.filter == Filters.purchased) {
    stream = FirebaseFirestore.instance
        .collection('products')
        .where('userEmail', isEqualTo: user.userEmail)
        .where('purchased', isEqualTo: true)
        .snapshots();
  } else if (params.filter == Filters.notPurchased) {
    stream = FirebaseFirestore.instance
        .collection('products')
        .where('userEmail', isEqualTo: user.userEmail)
        .where('purchased', isEqualTo: false)
        .snapshots();
  }

  return switch (params.sorting) {
    Sorting.nameA => stream.map((snapshot) => snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.id, doc.data()))
        .toList()
      ..sort((a, b) => a.name!.compareTo(b.name!))),
    Sorting.nameD => stream.map((snapshot) => snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.id, doc.data()))
        .toList()
      ..sort((b, a) => a.name!.compareTo(b.name!))),
    Sorting.priceA => stream.map((snapshot) => snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.id, doc.data()))
        .toList()
      ..sort((a, b) => a.price!.compareTo(b.price!))),
    Sorting.priceD => stream.map((snapshot) => snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.id, doc.data()))
        .toList()
      ..sort((b, a) => a.price!.compareTo(b.price!))),
  };
});
