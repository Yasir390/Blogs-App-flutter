import 'dart:io';

import 'package:blog_app/components/resusable_button.dart';
import 'package:blog_app/components/reusable_text_form_field.dart';
import 'package:blog_app/model/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  static const String routeName = '/postScreen';

  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Upload Blogs'),
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<PostModel>(
              builder: (context, postProvider, child) {
                return Column(
                  children: [
                     SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          postProvider.pickImage(context);
                        },
                        child: Card(
                          color: Colors.teal,
                          child:postProvider.image == null ? const Icon(CupertinoIcons.camera) : Image.file(File(postProvider.image!.path).absolute)
                        ),
                      ),
                    ),
                    ReusableTextFormField(
                      hintText: 'Title',
                      controller: postProvider.titleController,
                      onChanged: (p0) {},
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
                      controller: postProvider.descriptionController,
                      onChanged: (p0) {},
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
                      title: 'Upload',
                      onPressed: () {
                        postProvider.uploadToDatabase(context);
                      },
                      loading: postProvider.loading,
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
