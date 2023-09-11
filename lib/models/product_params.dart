import 'package:flutter_application_pw17/consts/constants.dart';

class ProductParams {
  Filters filter;
  Sorting sorting;
  ProductParams({required this.filter, required this.sorting});

  ProductParams copyWith({Filters? filter, Sorting? sorting}) {
    return ProductParams(
      filter: filter ?? this.filter,
      sorting: sorting ?? this.sorting,
    );
  }
}
