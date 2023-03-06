import 'dart:math';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:realm/realm.dart';
import 'package:todo_sophisticated/components/ButtonCommon.dart';
import 'package:todo_sophisticated/model/DataTask.dart';
import 'package:todo_sophisticated/model/ListImg.dart';
import 'package:todo_sophisticated/utils/AppRoutes.dart';
import 'package:todo_sophisticated/utils/ColorsConstants.dart';

class Details extends HookWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var quantityLetter = useState(0);
    var monthSelect =
        useState<String>(DateFormat.MMMMd().format(DateTime.now()));
    var dateSelect = useState<DateTime?>(null);
    final arguments = ModalRoute.of(context)?.settings.arguments as ListImg;
    var argumentsRoute = useState<ListImg>(arguments);
    final controllerText = useTextEditingController();
    final updateInput = useValueListenable(controllerText);

    useEffect(() {
      quantityLetter.value = updateInput.text.length;
    }, [updateInput]);

    //as vezes ira precisar chamar um builder com contexto diferente
    handleNavigation(BuildContext contextScaffold) {
      var snackBar = updateInput.text.isEmpty
          ? const SnackBar(content: Text("You need to fill in the description"))
          : null;
      if (snackBar != null) {
        ScaffoldMessenger.of(contextScaffold).showSnackBar(snackBar);
        return;
      }
      controllerText.text = "";
      List<MaterialAccentColor> listColors = [
        Colors.cyanAccent,
        Colors.lightGreenAccent,
        Colors.limeAccent,
        Colors.pinkAccent,
        Colors.indigoAccent,
        Colors.amberAccent,
        Colors.purpleAccent,
        Colors.greenAccent
      ];

      var sortColor = Random().nextInt(8);
      var dataTask = DataTask(
          ObjectId(),
          updateInput.text,
          dateSelect.value
              .toString(), // estou salvando como string para não acontecer de realm mudar o horario salvo devido a região
          argumentsRoute.value.id,
          listColors[sortColor].toString());
      realm.write(() => realm.add(dataTask));
      Navigator.of(context)
          .pushNamed(AppRoutes.show); // esse contexto precisa ser da rota
    }

    handleSumbitDatePicker(DateTime value) {
      var formatDate = DateFormat.MMMMd().format(value);
      monthSelect.value = formatDate;
      dateSelect.value = value;
    }

    handleShowCalendar() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                minimumDate: DateTime.now(),
                initialDateTime: dateSelect.value,
                maximumDate: DateTime.now().add(const Duration(days: 366)),
                onDateTimeChanged: handleSumbitDatePicker,
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: ColorsConstants.primaryColor,
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(
            top: 40,
            left: 20,
            right: 20,
          ),
          child: Stack(children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              child: InkWell(
                                onTap: handleShowCalendar,
                                child: Card(
                                  color: ColorsConstants.whiteColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(monthSelect.value ?? "25 feb"),
                                        const Icon(
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
                        child: ButtonCommon(() => handleNavigation(context))),
                  ]),
                ]),

            // Positioned(
            //     left: 0,
            //     top: 0,
            //     right: 0,
            //     bottom: 30,
            //     child: SizedBox(
            //       height: 100,
            //       child: CupertinoDatePicker(
            //           mode: CupertinoDatePickerMode.dateAndTime,
            //           onDateTimeChanged: handleSumbitDatePicker),
            //     ))
          ]),
        ),
      ),
    );
  }
}
