import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medisight/widget/login_widget.dart';
import 'package:medisight/widget/logged_in_widget.dart';
import 'package:medisight/screen/permission_request_screen.dart';
import 'package:medisight/screen/alarm_observer.dart';

import '../screen/bottom_navi.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final user = FirebaseAuth.instance.currentUser!;
              return PermissionRequestScreen(
                  child: AlarmObserver(
                      uid: user.uid, child: BottomNavi(selectedIndex: 0)));
            } else if (snapshot.hasError) {
              return Center(child: Text('Something Went Wrong..'));
            } else {
              return LoginWidget();
            }
          }));
}

/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medisight/screen/bottom_navi.dart';
import 'package:medisight/widget/login_widget.dart';
import 'package:medisight/widget/logged_in_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return LoggedInWidget();
          } else if (snapshot.hasError) {
            return Center(child: Text('Something Went Wrong..'));
          } else {
            return LoginWidget();
          }
        },
      ),
    );
  }
}
*/
