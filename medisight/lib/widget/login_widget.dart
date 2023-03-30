import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medisight/provider/google_sign_in.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 247, 255),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(
                    left: 50, top: 0, right: 0, bottom: 20),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Color.fromARGB(255, 34, 56, 96),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Container(
              padding: const EdgeInsets.only(
                  left: 30, top: 0, right: 30, bottom: 13),
              width: 500,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Color.fromRGBO(107, 134, 255, 0.316),
                      blurRadius: 6)
                ],
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Image.asset('assets/images/logo-title-light.png',
                        width: 250, height: 100),
                    SizedBox(height: 20),
                    Text(
                      '아이디와 비밀번호 입력없이\n구글 계정만으로 간편하게 로그인 하세요.',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Color.fromARGB(0, 244, 67, 54),
                        ),
                        backgroundColor: Colors.white,
                        shadowColor: Color.fromARGB(90, 0, 0, 0),
                        minimumSize: Size.fromHeight(50),
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/google.png',
                            width: 30,
                            height: 30,
                          ),
                          const Text(
                            'Login with Google',
                            style: TextStyle(
                                color: Colors.black87, fontSize: 15.0),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
