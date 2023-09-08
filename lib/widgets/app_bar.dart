import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_pw17/consts/constants.dart';
import 'package:flutter_application_pw17/providers/providers.dart';

var filter = Filters.showAll;
var sorting = Sorting.nameA;

AppBar customAppBar(String title) {
  return AppBar(
    backgroundColor: Colors.deepPurple,
    title: Text('Hi $title!'),
    centerTitle: true,
    leading: Consumer(builder: (context, ref, child) {
      return PopupMenuButton(
        color: Colors.blueGrey,
        icon: const Icon(
          Icons.filter_alt,
          color: Colors.black,
        ),
        onSelected: (value) {
          switch (value) {
            case 0:
              filter = Filters.showAll;
              break;
            case 1:
              filter = Filters.purchased;
              break;
            case 2:
              filter = Filters.notPurchased;
              break;
          }
          ref.read(filterProvider.notifier).update((state) => filter);
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem<int>(
              value: 0,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Show All"),
                  ),
                  if (filter == Filters.showAll) const Icon(Icons.check),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Purchased"),
                  ),
                  if (filter == Filters.purchased) const Icon(Icons.check),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 2,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Not purchased"),
                  ),
                  if (filter == Filters.notPurchased) const Icon(Icons.check),
                ],
              ),
            ),
          ];
        },
      );
    }),
    actions: [
      Consumer(builder: (context, ref, child) {
        return PopupMenuButton(
          color: Colors.blueGrey,
          icon: const Icon(
            Icons.swap_vert,
            color: Colors.black,
          ),
          onSelected: (value) {
            switch (value) {
              case 0:
                sorting =
                    sorting == Sorting.nameD ? Sorting.nameA : Sorting.nameD;
                // ignore: avoid_print
                print('$value $sorting');
                break;
              case 1:
                sorting =
                    sorting == Sorting.priceD ? Sorting.priceA : Sorting.priceD;
                break;
            }
            ref.read(sortProvider.notifier).update((state) => sorting);
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    if (ref.watch(sortProvider) == Sorting.nameA ||
                        ref.watch(sortProvider) == Sorting.nameD)
                      Icon(ref.watch(sortProvider) == Sorting.nameA
                          ? Icons.arrow_upward
                          : Icons.arrow_downward),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Sort by name"),
                    )
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    if (ref.watch(sortProvider) == Sorting.priceA ||
                        ref.watch(sortProvider) == Sorting.priceD)
                      Icon(ref.watch(sortProvider) == Sorting.priceA
                          ? Icons.arrow_upward
                          : Icons.arrow_downward),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Sort by price"),
                    )
                  ],
                ),
              ),
            ];
          },
        );
      }),
    ],
  );
}
