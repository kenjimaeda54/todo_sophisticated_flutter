import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_sophisticated/components/ButtonCommon.dart';
import 'package:todo_sophisticated/utils/ColorsConstants.dart';

class Details extends HookWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var quantityLetter = useState(0);
    final controllerText = useTextEditingController();
    final updateInput = useValueListenable(controllerText);

    useEffect(() {
      quantityLetter.value = updateInput.text.length;
    }, [updateInput]);

    handleNavigation() {}

    return Scaffold(
      backgroundColor: ColorsConstants.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: const Text(
                        "Click on the calendar to mark the date of the activity",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: ColorsConstants.secondaryColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Card(
                          color: ColorsConstants.whiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text("25 Feb"),
                                Icon(
                                  Icons.calendar_month,
                                  color: ColorsConstants.secondaryColor,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Write description for task",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: ColorsConstants.secondaryColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLines: 11,
                  maxLength: 300,
                  minLines: 1,
                  controller: controllerText,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: ColorsConstants.secondaryColor),
                  decoration: InputDecoration(
                    counterText: "",
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 27),
                    filled: true,
                    fillColor: ColorsConstants.whiteColor,
                    hintText: "Description",
                    hintStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Max character: 300",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: ColorsConstants.secondaryColor),
                        ),
                        Text(
                          "${quantityLetter.value} / 300",
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: ColorsConstants.secondaryColor),
                        ),
                      ]),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ButtonCommon(() => handleNavigation())),
            ]),
          ],
        ),
      ),
    );
  }
}
