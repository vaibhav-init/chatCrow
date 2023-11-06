import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStoreageRepository {
  final FirebaseStorage storage;

  FirebaseStoreageRepository({
    required this.storage,
  });

  Future<String> uploadFile(String path, File file) async {
    UploadTask uploadTask = storage.ref().child(path).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
