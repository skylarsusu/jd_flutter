import 'package:flutter/material.dart';

class JDHybridItemModel {
  final Widget img;
  final Widget img2;
  final Widget moduleBgImg;
  final String jumpUrl;
  final Widget title;

  JDHybridItemModel({
    this.img,
    this.img2,
    this.moduleBgImg,
    this.jumpUrl,
    this.title,
  });
}

class JDHybridItem extends StatelessWidget {

  final JDHybridItemModel model;
  JDHybridItem({
    this.model,
});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            left: 12.0,
            top: 12.0,
            bottom: 20.0,
            right: 12.0,
            child: this.model.img,
          ),
          this.model.moduleBgImg,

          Positioned(
              child: this.model.title,
              bottom: 5.0,
              left: 15.0,
              right: 15.0,
          ),
        ],
      ),
    );
  }
}

class JDHybridView extends StatelessWidget {
  final List<JDHybridItemModel> modelList;
  JDHybridView({
    this.modelList,
});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: modelList.map((e) => JDHybridItem(model:e)).toList(),
      ),
    );
  }
}
