import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medisight/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.all(32),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/medisight_logo.png',
            width: 350, height: 350),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('로그인 페이지 입니다.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        SizedBox(height: 8),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '계정과 비밀번호 입력없이 구글 계정으로 로그인 하세요.',
              style: TextStyle(fontSize: 16),
            )),
        Spacer(),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.white,
              minimumSize: Size(double.infinity, 50),
            ),
            icon: FaIcon(FontAwesomeIcons.google, color: Colors.lightBlue),
            label: Text('구글 계정으로 로그인', style: TextStyle(color: Colors.black87)),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogin();
            }),
        SizedBox(height: 40),
        RichText(
            text: TextSpan(text: 'Already have an account? ', children: [
          TextSpan(
              text: 'Log in',
              style: TextStyle(decoration: TextDecoration.underline))
        ])),
        Spacer(),
      ]));
}
