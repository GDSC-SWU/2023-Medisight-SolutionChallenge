import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medisight/provider/permission_provider.dart';
import 'package:provider/provider.dart';

class PermissionRequestScreen extends StatelessWidget {
  const PermissionRequestScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<PermissionProvider>(
      builder: (context, provider, _) {
        if (provider.isGrantedAll()) {
          return child;
        }
        return Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('앱 접근권한 안내', style: TextStyle(fontSize: 30)),
                const SizedBox(height: 60),
                const FaIcon(FontAwesomeIcons.bell,
                    size: 200, color: Colors.lightBlue),
                Container(
                  padding: const EdgeInsets.only(
                      left: 34, top: 120, right: 34, bottom: 13),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('다른 앱 위에 표시동의', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 10),
                        Text('알람 작동을 위한 백그라운드 접근권한을 허용해주세요.',
                            style: TextStyle(
                                color: Color.fromARGB(255, 125, 125, 125),
                                fontSize: 16))
                      ]),
                ),
                const SizedBox(height: 30),
                Container(
                    height: 100,
                    width: size.width,
                    padding: const EdgeInsets.only(
                        left: 34, top: 30, right: 34, bottom: 13),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue),
                        onPressed: provider.requestSystemAlertWindow,
                        child: const Text('접근권한 허용',
                            style: TextStyle(
                              fontSize: 16,
                            )))),
              ],
            ),
          ),
        );
      },
    );
  }
}
