import 'package:flutter/material.dart';
import 'package:flutter_truecaller_auth/true_caller_auth_service.dart';

class TrueCallerAuthScreen extends StatefulWidget {
  const TrueCallerAuthScreen({super.key});

  @override
  State<TrueCallerAuthScreen> createState() => _TrueCallerAuthScreenState();
}

class _TrueCallerAuthScreenState extends State<TrueCallerAuthScreen> {
  TrueCallerAuthService trueCallerAuthService = TrueCallerAuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 24, right: 24),
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
                icon: Image.network(
                  "https://w7.pngwing.com/pngs/314/17/png-transparent-truecaller-android-telephone-phone-blue-telephone-call-mobile-phones.png",
                  width: 30,
                  height: 30,
                ),
                onPressed: () {
                  trueCallerAuthService.startVerfication(context);
                },
                label: Text(
                  "Login With TrueCaller ".toUpperCase(),
                  style: const TextStyle(fontSize: 18),
                )),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    trueCallerAuthService.dispose();
    super.dispose();
  }
}
