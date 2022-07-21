import 'package:flutter/material.dart';

import '../widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void loading(bool state) {
    setState((){
      _isLoading = state;
    });
  }

  void _submitAuthForm(
    String email,
    String username,
    String password,
    bool isLogin,
  ) async {
    loading(true);
    UserCredential authResult;
    try {

      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance.collection('users').doc(authResult.user?.uid).set({
          'username': username,
          'email': email
        });
      }
    } on FirebaseAuthException catch (err) {
      String? message = 'An error occured, please check your credentials!';
      if (err.message != null) {
        message = err.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message!),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } catch (err) {
      print(err);
    } finally {
      loading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
          child: AuthForm(
        submitFn: _submitAuthForm,
        isLoading: _isLoading
      )),
    );
  }
}