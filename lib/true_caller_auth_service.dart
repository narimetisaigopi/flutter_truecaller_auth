import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_truecaller_auth/home_screen.dart';
import 'package:truecaller_sdk/truecaller_sdk.dart';

class TrueCallerAuthService {
  // This Example is valid for truecaller_sdk 0.0.1 onwards

//Import package

  late StreamSubscription streamSubscription;

  startVerfication(BuildContext context) async {
//Step 1: Initialize the SDK with SDK_OPTION_WITHOUT_OTP
    TruecallerSdk.initializeSDK(
        sdkOptions: TruecallerSdkScope.SDK_OPTION_WITHOUT_OTP);

//Step 2: Check if SDK is usable on that device, otherwise fall back to any other alternative
    bool isUsable = await TruecallerSdk.isUsable;
    // true: undhi
    // false: ledhu

//Step 3: If isUsable is true, you can call getProfile to show consent screen to verify user's number
    isUsable ? TruecallerSdk.getProfile : print("***Not usable***");

//OR you can also replace Step 2 and Step 3 directly with this
    TruecallerSdk.isUsable.then((isUsable) {
      isUsable ? TruecallerSdk.getProfile : print("***Not usable***");
    });

//Step 4: Be informed about the TruecallerSdk.getProfile callback result(success, failure, verification)
    streamSubscription =
        TruecallerSdk.streamCallbackData.listen((truecallerSdkCallback) {
      switch (truecallerSdkCallback.result) {
        case TruecallerSdkCallbackResult.success:
          print("true caller auth success");
          String firstName = truecallerSdkCallback.profile!.firstName;
          String? lastName = truecallerSdkCallback.profile!.lastName;
          String phNo = truecallerSdkCallback.profile!.phoneNumber;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
          break;
        case TruecallerSdkCallbackResult.failure:
          print("true caller auth failure");
          int errorCode = truecallerSdkCallback.error!.code;
          break;
        case TruecallerSdkCallbackResult.verification:
          print("Verification Required!!");
          break;
        default:
          print("Invalid result");
      }
    });
  }

//Step 5: Dispose streamSubscription
  void dispose() {
    streamSubscription.cancel();
  }
}
