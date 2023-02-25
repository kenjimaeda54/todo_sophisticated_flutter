import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_sophisticated/utils/ColorsConstants.dart';

class SingleGrid extends HookWidget {
  late String image;
  late String title;
  SingleGrid({Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    handleNavigation() {}

    return InkWell(
      onTap: handleNavigation,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Column(children: [
        SizedBox(
          height: 80,
          width: 80,
          child: CircleAvatar(
            backgroundColor: ColorsConstants.whiteColor,
            child:
                Image.asset(image, height: 50, width: 50, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
              color: ColorsConstants.secondaryColor),
        )
      ]),
    );
  }
}
