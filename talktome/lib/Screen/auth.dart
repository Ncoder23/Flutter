import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:talktome/Widgets/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool _isLogging = true;
  final _form = GlobalKey<FormState>();
  String _enterdEmail = '';
  String _enteredPassword = '';
  String _userName = '';
  File? _image;
  late List<String> userNames;

  // load the Usernames of existing User
  void getUserNames() async {
    final value = await FirebaseFirestore.instance.collection('users').get();
    final data = value.docs;

    final List<String> usernames = data.map((e) {
      return e['username'] as String;
    }).toList();
    //print(usernames);
    userNames = usernames;
  }

  void _onSave() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    try {
      if (_isLogging) {
        final userCred = await _firebase.signInWithEmailAndPassword(
            email: _enterdEmail, password: _enteredPassword);
        //print(userCred);
      } else {
        final userCred = await _firebase.createUserWithEmailAndPassword(
            email: _enterdEmail, password: _enteredPassword);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCred.user!.uid}.jpg');
        await storageRef.putFile(_image!);
        final imgUrl = await storageRef.getDownloadURL();
        //print(imgUrl);
        FirebaseFirestore.instance
            .collection('users')
            .doc('${userCred.user!.uid}')
            .set({
          'username': _userName,
          'email': _enterdEmail,
          'imgURL': imgUrl,
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == '') {
        //
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: Text(error.message ?? 'User Creation Error'),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/chat.png',
                height: 160,
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _form,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!_isLogging)
                          PickImage((img) {
                            _image = img;
                          }),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text(
                              'enter your email address.',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _enterdEmail = newValue!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text(
                              'enter your password',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          style: const TextStyle(fontSize: 18),
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.length < 6) {
                              return 'Password must be atleast 6 charater long';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _enteredPassword = newValue!;
                          },
                        ),
                        if (!_isLogging)
                          TextFormField(
                            decoration: const InputDecoration(
                              label: Text(
                                'enter your username',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              return userNames.contains(value)
                                  ? 'Username Already Taken'
                                  : null;
                            },
                            onSaved: (newValue) {
                              _userName = newValue!;
                            },
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: _onSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: Text(_isLogging ? "LogIn" : "SignUp"),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogging = !_isLogging;
                            });
                          },
                          child: Text(_isLogging
                              ? 'Create a account'
                              : 'Already have an account'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
