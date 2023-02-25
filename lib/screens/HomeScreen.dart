import 'dart:ui';
import "package:flutter/material.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:todo_sophisticated/components/SingleGrid.dart';
import 'package:todo_sophisticated/model/ListImg.dart';
import 'package:todo_sophisticated/utils/ColorsConstants.dart';

class HomeScreen extends HookWidget {
  HomeScreen({Key? key}) : super(key: key);
  final statusBarHeight = window.viewPadding.top;

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
    handleNavigation() {
      print("ola");
    }

    return Scaffold(
        backgroundColor: ColorsConstants.primaryColor,
        body: ListView.builder(
            itemCount: listHeader.length,
            itemBuilder: (context, index) {
              return StickyHeader(
                  header: Container(
                      padding: EdgeInsets.only(
                        top: statusBarHeight + 15,
                        bottom: 0,
                      ),
                      child: Column(
                        children: const [
                          Text(
                            "Chosse Activity",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorsConstants.secondaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "You can chosse more than one",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorsConstants.blue50,
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          Divider(
                            thickness: 2,
                            indent: 19,
                            color: ColorsConstants.whiteColor100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                  content: Stack(children: [
                    GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listImg.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (BuildContext context, index) {
                          var title = listImg[index].title;
                          var img = listImg[index].img;
                          return SingleGrid(title: title, image: img);
                        }),
                    Positioned(
                        width: MediaQuery.of(context).size.width,
                        bottom: MediaQuery.of(context).size.height * 0.1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.15),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 25,
                                backgroundColor: ColorsConstants.secondaryColor,
                                padding: const EdgeInsets.all(15)),
                            onPressed: handleNavigation,
                            child: Text("Get Start"),
                          ),
                        ))
                  ]));
            }));
  }
}
