import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:blog_app/utils/snackbar_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostModel with ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool loadingValue) {
    _loading = loadingValue;
    notifyListeners();
  }
  DatabaseReference databaseReference =
  FirebaseDatabase.instance.ref().child('post');
  firebase_storage.FirebaseStorage firebaseStorage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  XFile? image;
  final picker = ImagePicker();

  Future<void> pickFromCamera()async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera,imageQuality: 80);

    if(pickedFile != null){
      image = XFile(pickedFile.path);
    }
    notifyListeners();
  }

  Future<void> pickedFromGallery() async {
    final pickedFile =await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);

    if(pickedFile != null){
      image = XFile(pickedFile.path);
    }
    notifyListeners();
  }

  void pickImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  pickedFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.browse_gallery),
                title: const Text('Gallery'),
              ),
              ListTile(
                onTap: () {
                  pickFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
              ),
            ],
          ),
        );
      },
    );
  }


  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();



 void uploadToDatabase(BuildContext context) async {
    int date = DateTime.now().millisecondsSinceEpoch;
    try{
      setLoading(true);
      firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref('/blog$date');
      firebase_storage.UploadTask uploadTask =
      storageReference.putFile(File(image!.path).absolute);

      await Future.value(uploadTask);
      final newUrl = await storageReference.getDownloadURL();
      databaseReference.child(date.toString()).set({
        'postId':date.toString(),
        'postTitle':titleController.text.trim().toString(),
        'postDescription':descriptionController.text.trim().toString(),
        'postEmail':firebaseAuth.currentUser!.email.toString(),
        'postTime':date.toString(),
        'postImage':newUrl.toString(),
      }).then((value) {
        setLoading(false);
        SnackbarMessage().snackbarMessage(context, 'Data Uploaded',
            ContentType.success);
      }).onError((error, stackTrace) {
        setLoading(false);
        SnackbarMessage().snackbarMessage(context, error.toString(),
            ContentType.warning);});
    }catch(e){
      setLoading(false);
      SnackbarMessage().snackbarMessage(context, e.toString(),
          ContentType.warning);
    }
  }
}
