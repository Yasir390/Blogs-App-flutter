import 'dart:io';

import 'package:blog_app/model/update_post_model.dart';
import 'package:blog_app/utils/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../components/resusable_button.dart';
import '../components/reusable_text_form_field.dart';

class UpdatePost extends StatefulWidget {
  static const String routeName = '/updatePostScreen';
  // final String title,description;
  // final XFile? image;

 // const UpdatePost({super.key, required this.title, required this.description, this.image});
   UpdatePost({super.key});

  @override
  State<UpdatePost> createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {

  // DatabaseReference databaseReference =
  // FirebaseDatabase.instance.ref().child('post');
  // firebase_storage.FirebaseStorage firebaseStorage =
  //     firebase_storage.FirebaseStorage.instance;
  // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var image;

  //XFile? image;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  var uniqueId;
  @override
  Widget build(BuildContext context) {
   // final updatePostProvider = Provider.of<UpdatePostModel>(context);
    final snapshot = ModalRoute.of(context)!.settings.arguments as DataSnapshot;
   titleController.text = snapshot.child('postTitle').value.toString();
   descriptionController.text = snapshot.child('postDescription').value.toString();
    image = snapshot.child('postImage').value.toString();
  //  updatePostProvider.image = XFile(snapshot.child('postImage').value.toString());
   uniqueId = snapshot.child('postId').value.toString();

   var title,desc;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Update Blogs'),
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<UpdatePostModel>(
              builder: (context, updatePostProvider, child) {
                return Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                        updatePostProvider.pickImage(context);
                        },
                        child: Card(
                            color: Colors.teal,
                          child:updatePostProvider.image == null ?Image.network(image):Image.file(File(updatePostProvider.image!.path).absolute),
                         // child:image == null ?  Image.file(File(updatePostProvider.image!.path).absolute) : Image.network(image),
                           // child:updatePostProvider.image == null ? const Icon(CupertinoIcons.camera) : Image.file(File(updatePostProvider.image!.path).absolute),
                          // child:updatePostProvider.image == null ? const Icon(CupertinoIcons.camera) :Image.network(image),


                        ),
                      ),
                    ),
                    ReusableTextFormField(
                      hintText: 'Title',
                      controller:titleController,
                      onChanged: (value) {
                        title =value.toString();
                      },
                      iconName: Icons.title,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        return value!.isEmpty ? 'Enter Title' : null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReusableTextFormField(
                      hintText: 'Description',
                      controller:descriptionController,
                      onChanged: (value) {
                        desc = value.toString();
                      },
                      iconName: Icons.description,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        return value!.isEmpty ? 'Enter Description' : null;
                      },
                      maxLines: 3,

                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReusableButton(
                      title: 'Update',
                      onPressed: () {
                        
                       //updatePostProvider.updateDatabase(context, uniqueId, titleController.text , descriptionController.text);
                         updatePostProvider.updateData(context, titleController.text, descriptionController.text,uniqueId);
                      },
                    loading: updatePostProvider.loading,
                    )
                  ],
                );
              },

            ),
          ),
        ),
      ),
    );
  }
}
