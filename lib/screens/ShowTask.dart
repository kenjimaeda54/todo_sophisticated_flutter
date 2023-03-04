import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todo_sophisticated/mock/listIdImg.dart';
import 'package:todo_sophisticated/model/DataTask.dart';
import 'package:todo_sophisticated/utils/AppRoutes.dart';
import 'package:todo_sophisticated/utils/ColorsConstants.dart';

enum Type { description, date }

// class State {
//   String description = "";
//   String date = "";
//   String hour = "";
//   int idListImg = 0;
// }
//
// class DispatchAction {
//   String? description;
//   String? date;
//   String? hour;
//   int? idListImg;
//   DispatchAction(
//       {required this.date,
//       required this.hour,
//       required this.description,
//       required this.idListImg});
// }

class ShowTask extends HookWidget {
  ShowTask({Key? key}) : super(key: key);
  final CalendarController _controllerCalendar = CalendarController();

  // State _reducer(State state, DispatchAction action) {
  //   if (action.description != null) {
  //     state.description = action.description!;
  //   }
  //   if (action.idListImg != null) {
  //     state.idListImg = action.idListImg!;
  //   }
  //   if (action.date != null) {
  //     state.date = action.date!;
  //   }
  //   if (action.hour != null) {
  //     state.hour = action.hour!;
  //   }
  //   //não posso ter return no meio dos if,sempre preciso retornar o state aqui
  //   return state;
  // }

  @override
  Widget build(BuildContext context) {
    final realmData = realm.all<DataTask>();
    var listDataTask =
        useState<List<DataTask>>(realmData.map((e) => e).toList());
    // var store = useReducer<State, DispatchAction>(
    //     (state, action) => _reducer(state, action),
    //     initialState: State(),
    //     initialAction:
    //         DispatchAction(date: '', description: '', idListImg: 0, hour: ''));

    useEffect(() {
      // for (var e in dataTask) {
      //   //https://github.com/rrousselGit/flutter_hooks/blob/master/packages/flutter_hooks/example/lib/use_reducer.dart
      //   store.dispatch(DispatchAction(
      //       date: e.date,
      //       description: e.description,
      //       idListImg: e.idListImg,
      //       hour: e.hour));
      // }
    }, []);

    handleBackNavigation(BuildContext context) =>
        Navigator.of(context).pushNamed(AppRoutes.home);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            ListTile(
              leading: IconButton(
                  onPressed: () => handleBackNavigation(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: ColorsConstants.secondaryColor,
                  )),
              title: const Text(
                "Tasks",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorsConstants.secondaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              trailing: const Icon(
                Icons.calendar_month,
                size: 20,
                color: ColorsConstants.secondaryColor,
              ),
            ),
            Expanded(
              child: SfCalendar(
                controller: _controllerCalendar, // retirar o header
                view: CalendarView.schedule,
                headerStyle: const CalendarHeaderStyle(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: ColorsConstants.secondaryColor)),
                firstDayOfWeek: 1,
                todayHighlightColor: ColorsConstants.secondaryColor,
                dataSource: _getDataSource(),
                allowAppointmentResize: true,
                scheduleViewSettings: const ScheduleViewSettings(
                  hideEmptyScheduleWeek: true,
                  appointmentItemHeight: 100,
                  monthHeaderSettings: MonthHeaderSettings(
                    monthTextStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: ColorsConstants.secondaryColor),
                    height: 45,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                appointmentBuilder:
                    (BuildContext context, CalendarAppointmentDetails details) {
                  final Appointment appointments = details.appointments.first;
                  if (_controllerCalendar.view != CalendarView.month) {
                    final icon = listImg
                        .firstWhere((element) => element.id == appointments.id)
                        .img;
                    return Container(
                      decoration: BoxDecoration(
                        color: appointments.color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 10,
                                    ),
                                    child: Image.asset(
                                      height: 40,
                                      width: 40,
                                      icon,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    // para fazer wrap no texto
                                    child: Text(
                                      appointments.subject,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                        height: 1.3,
                                        color: ColorsConstants.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 10,
                              ),
                              child: Text(
                                DateFormat('hh:mm a')
                                    .format(appointments.startTime),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: ColorsConstants.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Text(appointments.subject);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

_DataSource _getDataSource() {
  final List<Appointment> appointments = <Appointment>[];
  final realmDataTask = realm.all<DataTask>();
  var listDataTask =
      useState<List<DataTask>>(realmDataTask.map((e) => e).toList());

  for (var element in listDataTask.value) {
    String valueString = element.colors.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString,
        radix:
            16); // convertento material acedent color para string e depois voltando para cor
    appointments.add(Appointment(
      subject: element.description,
      startTime: element.dateTime,
      endTime: element.dateTime,
      id: element.idListImg,
      color: Color(value),
    ));
  }
  return _DataSource(appointments);
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
