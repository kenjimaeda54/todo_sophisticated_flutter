import 'dart:ui';
import "package:flutter/material.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_sophisticated/components/ButtonCommon.dart';
import 'package:todo_sophisticated/components/SingleGrid.dart';
import 'package:todo_sophisticated/model/ListImg.dart';
import 'package:todo_sophisticated/utils/AppRoutes.dart';
import 'package:todo_sophisticated/utils/ColorsConstants.dart';
import '../mock/listIdImg.dart';
import '../model/DataTask.dart';

class HomeScreen extends HookWidget {
  HomeScreen({Key? key}) : super(key: key);
  final statusBarTopHeight = window.viewPadding.top;
  final statusBarBottonHeight = window.viewPadding.bottom;

  @override
  Widget build(BuildContext context) {
    var itensSelected = useState<ListImg?>(null);

    handleNavigationScreenDetails() {
      var snackBar = itensSelected.value == null
          ? const SnackBar(content: Text("You need selected at least one item"))
          : null;
      if (snackBar != null) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      Navigator.of(context).pushReplacementNamed(AppRoutes.details,
          arguments: itensSelected.value);
    }

    handleSelectItem(ListImg item) {
      // o useState trabalha com conceito de imutabilidade então não pode ir diretamente  e alterar o estado,
      // precisa mudar a lista que esta na refreencia é igualar o valor com oque esta no estado,
      // muitos paradigmas funcionam dessa maneira pois trabalhamos com conceito de observer,
      // exemplo em    em redux , pois  não podemos altera  uma lista que esta no redux diretamente,precisa manipular ela
      // e igualar ao valor do estate
      // state.data = data.fitler(it => it.id === item.id) // isso e em redux
      // itensSelected.value.contains(item)
      //     ? itensSelected.value = itensSelected.value
      //         .where((element) => element.id != item.id)
      //         .toList()
      //     : itensSelected.value = [...itensSelected.value, item];
      itensSelected.value = item;
    }

    handleNavigationShowActivies() {
      var snackBar = realm.all<DataTask>().isEmpty
          ? const SnackBar(content: Text("You have no activies"))
          : null;
      if (snackBar != null) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      Navigator.of(context).pushReplacementNamed(AppRoutes.show);
    }

    return Scaffold(
        backgroundColor: ColorsConstants.primaryColor,
        body: Stack(
          children: [
            ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: statusBarBottonHeight + 150,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Chosse Activity",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorsConstants.secondaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextButton(
                          onPressed: () => handleNavigationShowActivies(),
                          child: const Text(
                            "Click  here to see your activities",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorsConstants.blue50,
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                        const Divider(
                          thickness: 2,
                          indent: 19,
                          color: ColorsConstants.whiteColor100,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GridView.count(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            crossAxisCount: 3,
                            mainAxisSpacing: 50,
                            crossAxisSpacing: 5,
                            children: listImg
                                .map((it) => SingleGrid(
                                      listImg: it,
                                      itensSelected: itensSelected.value,
                                      handleSelectedItem: handleSelectItem,
                                    ))
                                .toList())
                      ],
                    ),
                  );
                }),
            Positioned(
                width: MediaQuery.of(context).size.width,
                bottom: MediaQuery.of(context).size.height * 0.1,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: MediaQuery.of(context).size.width * 0.22),
                    child: ButtonCommon(() => handleNavigationScreenDetails())))
          ],
        ));
  }
}
