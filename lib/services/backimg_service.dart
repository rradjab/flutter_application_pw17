import 'package:firebase_storage/firebase_storage.dart';

Future<List<String>> getImages() async {
  try {
    var image1 =
        await FirebaseStorage.instance.ref('heaven.jpg').getDownloadURL();
    var image2 =
        await FirebaseStorage.instance.ref('lights.jpg').getDownloadURL();
    return [image1, image2];
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
  return [];
}
