import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medisight/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoggedInWidget extends StatelessWidget {
  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          centerTitle: true,
          actions: [
            TextButton(
                child: Text('로그아웃', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                })
          ],
        ),
        body: Container(
            alignment: Alignment.center,
            color: Colors.blueGrey.shade900,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Profile',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
              SizedBox(height: 32),
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
              SizedBox(height: 8),
              Text(
                'Name: ' + user.displayName!,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Email: ' + user.email!,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ])));
  }
}
