import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackImgNotifier extends StateNotifier<List<String>> {
  BackImgNotifier() : super([]);

  void getImages() async {
    var image1 =
        await FirebaseStorage.instance.ref('heaven.jpg').getDownloadURL();
    var image2 =
        await FirebaseStorage.instance.ref('lights.jpg').getDownloadURL();
    state = [image1, image2];
  }
}
