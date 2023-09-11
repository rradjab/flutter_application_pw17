import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw17/models/product_model.dart';
import 'package:flutter_application_pw17/models/product_params.dart';
import 'package:flutter_application_pw17/services/auth_notifier.dart';
import 'package:flutter_application_pw17/services/product_params.dart';
import 'package:flutter_application_pw17/services/firestore_notifier.dart';

final paramsProvider =
    StateNotifierProvider<ProductParamService, ProductParams>(
        (ref) => ProductParamService());

final firebaseProductsProvider =
    StateNotifierProvider<FireStoreService, List<ProductModel>>(
        (ref) => FireStoreService());

final firebaseAuthProvider =
    StateNotifierProvider<FireStoreAuthService, String>(
        (ref) => FireStoreAuthService());
