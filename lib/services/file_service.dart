

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firesetting/services/log_service.dart';
import 'package:firesetting/services/prefs_service.dart';

class FileService{
  static const folder_post="post_images";

  static Future<String> uploadPostImage(File _image)async {
    FirebaseApp app = await Firebase.initializeApp();
    FirebaseStorage _storage =FirebaseStorage.instanceFor(app: app,bucket: 'gs://fire1-6eb1f.firebasestorage.app');

    String uid =await Prefs.loadUserId();

    String img_name = "${uid}_${DateTime.now()}";
    var firebaseStorageRef =_storage.ref().child(folder_post).child(img_name);
    var uploadTask =firebaseStorageRef.putFile(_image);
    final TaskSnapshot taskSnapshot =await uploadTask.whenComplete((){});
    final String downloadUrl =await firebaseStorageRef.getDownloadURL();
    LogService.i(downloadUrl);
    return downloadUrl;
  }
}
