import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:todo_sophisticated/model/DataTask.dart';
import 'package:todo_sophisticated/utils/ColorsConstants.dart';

enum Type { description, date }

class State {
  String description = "";
  String date = "";
  String hour = "";
  List<int> idListImg = [];
}

class DispatchAction {
  String? description;
  String? date;
  String? hour;
  List<int>? idListImg;
  DispatchAction(
      {required this.date,
      required this.hour,
      required this.description,
      required this.idListImg});
}

class ShowTask extends HookWidget {
  ShowTask({Key? key}) : super(key: key);

  State _reducer(State state, DispatchAction action) {
    if (action.description != null) {
      state.description = action.description!;
    }
    if (action.idListImg != null) {
      state.idListImg = action.idListImg!;
    }
    if (action.date != null) {
      state.date = action.date!;
    }
    if (action.hour != null) {
      state.hour = action.hour!;
    }
    //não posso ter return no meio dos if,sempre preciso retornar o state aqui
    return state;
  }

  @override
  Widget build(BuildContext context) {
    final monthCurrenty = DateFormat.LLLL().format(DateTime.now());
    final currentDate = DateTime.now().weekday;

    print(currentDate);
    // final datesOfWeek = [currentDate.subtract(duration)];
    var store = useReducer<State, DispatchAction>(
        (state, action) => _reducer(state, action),
        initialState: State(),
        initialAction:
            DispatchAction(date: '', description: '', idListImg: [], hour: ''));

    useEffect(() {
      final dataTask = realm.all<DataTask>();
      for (var e in dataTask) {
        //https://github.com/rrousselGit/flutter_hooks/blob/master/packages/flutter_hooks/example/lib/use_reducer.dart
        store.dispatch(DispatchAction(
            date: e.date,
            description: e.description,
            idListImg: e.idListImg,
            hour: e.hour));
      }
    }, []);

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
              leading: const Icon(
                Icons.arrow_back,
                size: 20,
                color: ColorsConstants.secondaryColor,
              ),
              title: Text(
                monthCurrenty ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
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
          ],
        ),
      ),
    );
  }
}
