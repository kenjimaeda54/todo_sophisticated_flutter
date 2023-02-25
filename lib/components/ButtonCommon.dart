import "package:flutter/material.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import '../utils/ColorsConstants.dart';

class ButtonCommon extends HookWidget {
  late Function() handlePress;
  ButtonCommon(this.handlePress, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handlePress,
      style: ElevatedButton.styleFrom(
          elevation: 13,
          backgroundColor: ColorsConstants.secondaryColor,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
      child: const Text(
        "Get Start",
        style: TextStyle(
          color: ColorsConstants.whiteColor,
          fontWeight: FontWeight.w400,
          fontSize: 17,
        ),
      ),
    );
  }
}
