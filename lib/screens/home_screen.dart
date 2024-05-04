import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:blog_app/model/search_controller_model.dart';
import 'package:blog_app/screens/options_screen.dart';
import 'package:blog_app/screens/post_screen.dart';
import 'package:blog_app/screens/update_post.dart';
import 'package:blog_app/utils/snackbar_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/reusable_text_form_field.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/homeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref('post');

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, PostScreen.routeName);
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
            IconButton(
              onPressed: () {
                _firebaseAuth.signOut().then((value) {
                  Navigator.pushNamed(context, OptionsScreen.routeName);
                  SnackbarMessage()
                      .snackbarMessage(context, 'Logout', ContentType.success);
                }).onError((error, stackTrace) {
                  SnackbarMessage().snackbarMessage(
                      context, error.toString(), ContentType.warning);
                });
              },
              icon: const Icon(
                Icons.logout,
              ),
            )
          ],
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReusableTextFormField(
                hintText: 'Search',
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                iconName: Icons.search,
                keyboardType: TextInputType.text,
                validator: (value) {
                  return value!.isEmpty ? 'Enter Email' : null;
                },
              ),
            ),
            Expanded(
                child: FirebaseAnimatedList(
              query: databaseReference,
              itemBuilder: (context, snapshot, animation, index) {
                //String searchValue = snapshot.child('postTitle').value.toString();
                final searchValue =
                    snapshot.child('postTitle').value.toString();

                final uniqueId =
                    snapshot.child('postId').value.toString();

                if (searchController.text.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 250,
                                width: 300,
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                      'images/img.png',
                                  image: snapshot
                                      .child('postImage')
                                      .value
                                      .toString(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ListTile(
                              shape: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20)),
                             // tileColor: Colors.teal.shade100,
                              title: Text(
                                snapshot.child('postTitle').value.toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              subtitle: Text(snapshot
                                  .child('postDescription')
                                  .value
                                  .toString()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed:  () {
                                      Navigator.pushNamed(context, UpdatePost.routeName,arguments: snapshot);
                                    },
                                    icon:const Icon(Icons.edit),
                                  )
                                  ,
                                  IconButton(
                                    onPressed:  () {
                                      databaseReference.child(uniqueId).remove();
                                    },
                                    icon:const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 24),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(snapshot.child('postTitle').value.toString(),
                          //       style: Theme.of(context).textTheme.titleMedium,
                          //       ),
                          //       Text(snapshot.child('postDescription').value.toString()),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  );
                } else if (searchValue
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase())) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 250,
                            width: double.infinity,
                            decoration: const BoxDecoration(color: Colors.teal),
                            child: FadeInImage.assetNetwork(
                              placeholder:
                                  'https://media.istockphoto.com/id/1439436349/photo/red-apple-isolated-on-white-background-clipping-path-full-depth-of-field.jpg?s=2048x2048&w=is&k=20&c=h0FIN48XtILU6rloPxzPFgoxJ3_LOgj3TrVo9g4cC8k=',
                              image:
                                  snapshot.child('postImage').value.toString(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  snapshot.child('postTitle').value.toString()),
                              Text(snapshot
                                  .child('postDescription')
                                  .value
                                  .toString()),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
