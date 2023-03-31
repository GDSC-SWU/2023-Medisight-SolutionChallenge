import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medisight/screen/tuto_screen.dart';
import 'package:medisight/widget/login_widget.dart';
import 'package:medisight/widget/logged_in_widget.dart';
import 'package:medisight/screen/permission_request_screen.dart';
import 'package:medisight/screen/alarm_observer.dart';

import '../screen/bottom_navi.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<Widget> _getRoute(User user) async {
    final documentSnapshot =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
    bool subfield = documentSnapshot.data()?.containsKey('firstTuto') ?? false;

    if (subfield) {
      // 앱을 처음 사용한 경우가 아닐 때
      return PermissionRequestScreen(
        child: AlarmObserver(
          uid: user.uid,
          child: BottomNavi(
            selectedIndex: 0,
          ),
        ),
      );
    } else {
      // 앱을 처음 사용한 경우일 때
      return PermissionRequestScreen(
        child: AlarmObserver(
          uid: user.uid,
          child: const TutoScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return FutureBuilder(
                future: _getRoute(snapshot.data!),
                builder: (context, AsyncSnapshot<Widget> routeSnapshot) {
                  if (routeSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return routeSnapshot.data!;
                  }
                },
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something Went Wrong..'));
            } else {
              return LoginWidget();
            }
          },
        ),
      );
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