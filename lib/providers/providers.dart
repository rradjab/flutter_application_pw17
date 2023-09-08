import 'package:flutter_application_pw17/models/product_model.dart';
import 'package:flutter_application_pw17/services/auth_notifier.dart';
import 'package:flutter_application_pw17/services/firestore_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw17/consts/constants.dart';
import 'package:flutter_application_pw17/services/backimg_notifier.dart';

final filterProvider = StateProvider((ref) => Filters.showAll);

final sortProvider = StateProvider((ref) => Sorting.nameA);

final usernameProvider = StateProvider((ref) => '');
final usermailProvider = StateProvider((ref) => '');

final backImgProvider = StateNotifierProvider<BackImgNotifier, List<String>>(
    (ref) => BackImgNotifier());

final firebaseProductsProvider =
    StateNotifierProvider<FireStoreService, List<ProductModel>>(
        (ref) => FireStoreService());

final firebaseAuthProvider =
    StateNotifierProvider<FireStoreAuthService, String>(
        (ref) => FireStoreAuthService());
