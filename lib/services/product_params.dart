import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw17/consts/constants.dart';
import 'package:flutter_application_pw17/models/product_params.dart';

class ProductParamService extends StateNotifier<ProductParams> {
  ProductParamService()
      : super(ProductParams(filter: Filters.showAll, sorting: Sorting.nameA));

  void updateParams({Filters? filter, Sorting? sorting}) {
    state = state.copyWith(filter: filter, sorting: sorting);
  }
}
