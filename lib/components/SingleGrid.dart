import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_sophisticated/utils/ColorsConstants.dart';
import '../model/ListImg.dart';

class SingleGrid extends HookWidget {
  late final ListImg listImg;
  late Function(ListImg item) handleSelectedItem;
  List<ListImg> istenSelected;

  SingleGrid(
      {Key? key,
      required this.listImg,
      required this.istenSelected,
      required this.handleSelectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => handleSelectedItem(listImg),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Column(children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: istenSelected.contains(listImg)
                    ? ColorsConstants.blue100
                    : ColorsConstants.whiteColor,
                width: 1,
              )),
          child: CircleAvatar(
            backgroundColor: ColorsConstants.whiteColor,
            child: Image.asset(listImg.img,
                height: 50, width: 50, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          listImg.title,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
              color: ColorsConstants.secondaryColor),
        )
      ]),
    );
  }
}
