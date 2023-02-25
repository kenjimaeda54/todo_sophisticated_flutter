import 'dart:ui';
import "package:flutter/material.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:todo_sophisticated/components/SingleGrid.dart';
import 'package:todo_sophisticated/model/ListImg.dart';
import 'package:todo_sophisticated/utils/ColorsConstants.dart';

class HomeScreen extends HookWidget {
  HomeScreen({Key? key}) : super(key: key);
  final statusBarTopHeight = window.viewPadding.top;
  final statusBarBottonHeight = window.viewPadding.bottom;
  List<ListImg> listItemsSelected = [];

  final List<ListImg> listImg = [
    ListImg(id: 1, img: "assets/img/bike.png", title: "Cycling"),
    ListImg(id: 2, img: "assets/img/book.png", title: "Reading"),
    ListImg(id: 3, img: "assets/img/clock.png", title: "Alert"),
    ListImg(id: 4, img: "assets/img/party.png", title: "Party"),
    ListImg(id: 5, img: "assets/img/gaming.png", title: "Gaming"),
    ListImg(id: 6, img: "assets/img/music.png", title: "Play Guitar"),
    ListImg(id: 7, img: "assets/img/romance.png", title: "Loving"),
    ListImg(id: 8, img: "assets/img/run.png", title: "Jogging"),
    ListImg(id: 9, img: "assets/img/shopping.png", title: "Shopping"),
    ListImg(id: 10, img: "assets/img/writer.png", title: "Writing"),
    ListImg(id: 11, img: "assets/img/water.png", title: "Drink"),
    ListImg(id: 12, img: "assets/img/skate.png", title: "Skating"),
    ListImg(id: 13, img: "assets/img/trading.png", title: "Trading"),
    ListImg(id: 14, img: "assets/img/paiting.png", title: "Painting"),
    ListImg(id: 15, img: "assets/img/working.png", title: "Working"),
  ];

  final listHeader = ["HEADER1"];

  @override
  Widget build(BuildContext context) {
    var itensSelected = useState(List<ListImg>.empty());
    handleNavigation() {
      print("ola");
    }

    handleSelectItem(ListImg item) {
      // o useState trabalha com conceito de imutabilidade então não pode ir diretamente  e alterar o estado,
      // precisa mudar a lista que esta na refreencia é igualar o valor com oque esta no estado,
      // muitos paradigmas funcionam dessa maneira pois trabalhamos com conceito de observer,
      // exemplo em    em redux , pois  não podemos altera  uma lista que esta no redux diretamente,precisa manipular ela
      // e igualar ao valor do estate
      // state.data = data.fitler(it => it.id === item.id) // isso e em redux
      itensSelected.value.contains(item)
          ? itensSelected.value = itensSelected.value
              .where((element) => element.id != item.id)
              .toList()
          : itensSelected.value = [...itensSelected.value, item];
    }

    return Scaffold(
        backgroundColor: ColorsConstants.primaryColor,
        body: Stack(
          children: [
            ListView.builder(
                itemCount: listHeader.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: statusBarTopHeight,
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
                        const Text(
                          "You can chosse more than one",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorsConstants.blue50,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
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
                                      istenSelected: itensSelected.value,
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
                  child: ElevatedButton(
                    onPressed: handleNavigation,
                    style: ElevatedButton.styleFrom(
                        elevation: 13,
                        backgroundColor: ColorsConstants.secondaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20)),
                    child: const Text(
                      "Get Start",
                      style: TextStyle(
                        color: ColorsConstants.whiteColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ))
          ],
        ));
  }
}
