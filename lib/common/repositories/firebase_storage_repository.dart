import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStoreageRepositoryProvider = Provider(
  (ref) => FirebaseStoreageRepository(
    storage: FirebaseStorage.instance,
  ),
);

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
