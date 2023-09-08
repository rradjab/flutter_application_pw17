import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_pw17/consts/constants.dart';
import 'package:flutter_application_pw17/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw17/models/product_model.dart';

final firebaseProducts = StreamProvider.autoDispose
    .family<List<ProductModel>, Filters>((ref, params) {
  final userMail = ref.watch(usermailProvider);
  var stream = FirebaseFirestore.instance
      .collection('products')
      .where('userEmail', isEqualTo: userMail)
      .snapshots();
  if (params == Filters.purchased) {
    stream = FirebaseFirestore.instance
        .collection('products')
        .where('userEmail', isEqualTo: userMail)
        .where('purchased', isEqualTo: true)
        .snapshots();
  } else if (params == Filters.notPurchased) {
    stream = FirebaseFirestore.instance
        .collection('products')
        .where('userEmail', isEqualTo: userMail)
        .where('purchased', isEqualTo: false)
        .snapshots();
  }

  return stream.map((snapshot) => snapshot.docs
      .map((doc) => ProductModel.fromJson(doc.id, doc.data()))
      .toList());
});
