import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadFileToStorage(PlatformFile file, String path) async {
  // "avatars/$username/$username.${avatar.extension ?? "png"}"
  var uploadTask =
      await FirebaseStorage.instance.ref(path).putFile(File(file.path ?? ""));
  return await uploadTask.ref.getDownloadURL();
}
